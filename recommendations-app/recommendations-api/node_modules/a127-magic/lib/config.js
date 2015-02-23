/****************************************************************************
 The MIT License (MIT)

 Copyright (c) 2014 Apigee Corporation

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 ****************************************************************************/
'use strict';

// todo: potentially pull stuff from vault as well...

var path = require('path');
var fs = require('fs');
var yaml = require('yamljs');
var debug = require('debug')('a127');
var _ = require('underscore');
var loader = require('./loader');
var volosSwagger = require('volos-swagger');
var initializeSwagger = require('swagger-tools').initializeMiddleware;
var util = require('util');

module.exports = {
  env: getEnvironment,
  load: load,
  reload: reload
};

var ENV_FILENAME = '.a127_env';
var SECRETS_FILENAME = '.a127_secrets';
var SERVICES_FILENAME = '.a127_services';

var BASE_DEFAULTS = {
  'a127.magic': {
    swaggerFile: 'api/swagger/swagger.yaml',
    controllers: {
      useStubs: false,
      controllers: 'api/controllers',
      mocks: 'api/mocks'
    },
    volos: {
      helpers: 'api/helpers'
    },
    swaggerTools: undefined
  }
};

var appRoot, configDir, config, env;

function reload(a127Env, cb) {

  if (a127Env === undefined && cb === undefined) { throw new Error('callback is required'); }
  if (_.isFunction(a127Env)) { cb = a127Env; a127Env = undefined; }

  env = config = undefined;

  appRoot = findAppRoot();
  configDir = path.resolve(appRoot, 'config');

  env = a127Env || getEnvironment();

  var defaultConfig = readYamlFromConfigFile('default.yaml');
  var currentConfig = env ? readYamlFromConfigFile(env + '.yaml') : {};
  var secrets = readSecretsFromVault();
  
  var servicesBase = readYamlFromConfigFile(SERVICES_FILENAME);
  var services = {};
  _.each(servicesBase, function(serviceValues, serviceName) {
    _.each(serviceValues, function(serviceValue, serviceKey) {
      var configKey = util.format('%s.%s', serviceName, serviceKey);
      services[configKey] = serviceValue;
    });
  });

  config = _.extend(BASE_DEFAULTS, defaultConfig, currentConfig, secrets, services);

  resolveRelativeProjectPaths(config);

  var magic = config['a127.magic'];
  var swaggerObject = loader.load(magic.swaggerFile, config);
  magic.swaggerObject = swaggerObject;

  magic.volosAuth = volosSwagger.auth(swaggerObject, magic.volos);
  magic.volosApp = volosSwagger.app;

  magic.resource = require('./resource')(magic.volosAuth.resources);

  initializeSwagger(swaggerObject, function(swaggerTools) {
    magic.swaggerTools = swaggerTools;
    cb(config);
  });
}

function findAppRoot() {
  var root = _.find([
    process.env.A127_APPROOT,
    path.resolve(__dirname).split('/node_modules')[0],
    path.dirname(require.main.filename),
    process.cwd()
  ],
    function(test) {
      return test && fs.existsSync(path.resolve(test, 'config')) && fs.existsSync(path.resolve(test, 'api'));
    });
  if (!root) { throw new Error('Can\'t find application root directory. Try setting env var: A127_APPROOT'); }
  debug('Application root: %s', root);
  return root;
}

function resolveRelativeProjectPaths(config) {
  var magic = config['a127.magic'];
  magic.swaggerFile = path.resolve(appRoot, magic.swaggerFile);
  if (_.isString(magic.controllers.controllers)) {
    magic.controllers.controllers = path.resolve(appRoot, magic.controllers.controllers);
  } else if (_.isArray(magic.controllers.controllers)) {
    magic.controllers.controllers = _.map(magic.controllers.controllers, function(_path) {
      return path.resolve(appRoot, _path);
    })
  }
  magic.volos.helpers = path.resolve(appRoot, magic.volos.helpers);
}

// todo: actually use vault instead of file
function readSecretsFromVault() {
  return readYamlFromConfigFile(SECRETS_FILENAME);
}

function getEnvironment() {
  if (env) { return env; }
  env = process.env.A127_ENV || process.env.NODE_ENV;
  if (!env) { // load from file
    var envFile = path.resolve(configDir, ENV_FILENAME);
    env = readFileNoError(envFile);
  }
  if (debug.enabled) { debug('set environment: ' + env); }
  return env;
}

function readYamlFromConfigFile(fileName) {
  try {
    var file = path.resolve(configDir, fileName);
    var obj = yaml.load(file);
    if (debug.enabled) { debug('read config file: ' + file); }
    return obj;
  }
  catch(err) {
    if (debug.enabled) { debug('failed attempt to read config: ' + file); }
    return {};
  }
}

function readFileNoError(file) {
  try {
    return fs.readFileSync(file, 'utf8');
  } catch (ex) {
    return null;
  }
}

function load(a127Env, cb) {
  if (a127Env === undefined && cb === undefined) { throw new Error('callback is required'); }
  if (_.isFunction(a127Env)) { cb = a127Env; a127Env = undefined; }
  if (!config || (a127Env && env !== a127Env)) {
    reload(a127Env, cb);
  } else {
    cb(config);
  }
}
