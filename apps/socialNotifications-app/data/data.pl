
use strict;
use Getopt::Long;

my $client_id;
my $client_secret;
my $org;
my $app;
my $enterprise;

my $baseURL = "https://api.usergrid.com/";
my $enterpriseURL = "https://amer-apibaas-prod.apigee.net/appservices/";
my $urlParameters;
my $data;

# declare the perl command line flags/options we want to allow
GetOptions( "client_id=s" => \$client_id, 
			"client_secret=s" => \$client_secret,
			"org=s" => \$org,
			"app=s" => \$app,
			"enterprise" => \$enterprise
			)
 or die("Error in command line arguments\n");
 
if( !$client_id || !$client_secret ) {
  die( "perl data.pl -client_id <client_id> -client_secret <client_secret> -org <orgName> -app <appName> -enterprise <boolean>" );
}

if($enterprise ) {
	$baseURL = $enterpriseURL;
}

$baseURL .= $org . "/" . $app;

$urlParameters = "client_id=$client_id&client_secret=$client_secret";


print "client id = $client_id\n";
print "client secret = $client_secret\n";
print "org = $org\n";
print "app = $app\n";
print "enterprise = $enterprise\n";
print "$baseURL\n\n";

# curl call example
# $data = '{"timestamp":0,"counters":{"dog_likes":1}}';
# system "curl -X POST '$baseURL/events?$urlParameters' -d '$data'";

# add users
print "Adding Users\n\n";

# User: Fred Jones
$data = '{
	"name": "Fred Jones",
	"username": "2145059383",
	"email": "jnorrid+fjones@apigee.com",
	"picture": "http://www.gravatar.com/avatar/15bd9bd75cfcfec9e53f994e8d1b9fd4",
	"id": "25a412aa-2b17-11e5-812d-5f82351ae874"
}';
system "curl -X POST '$baseURL/users?$urlParameters' -d '$data'";

# User: Bob Smith
$data = '{
	"name": "Bob Smith",
	"username": "4084708080",
	"email": "jnorrid+bsmith@gmail.com",
	"picture": "http://www.gravatar.com/avatar/9303ba87f9f6a3c0902c037a88de37fc",
	"id": "3cfb844a-175a-11e5-ad38-5316aae6338d"
}';
system "curl -X POST '$baseURL/users?$urlParameters' -d '$data'";

# User: Jenny D. Davidsen
$data = '{
	"name": "Jenny D. Davidsen",
	"username": "4088675309",
	"email": "jenny@pobox.com",
	"picture": "http://4.bp.blogspot.com/-4BzaXC-x6wQ/U7oH1ZScJ0I/AAAAAAAANDw/xcN1UrldJ9I/s1600/867-5309+Jenny+1.jpg",
	"id": "aaa65d8a-16a6-11e5-86ea-7b4f7ff44431",
	"adr": {
		"addr1": "10 Almaden Blvd.",
		"addr2": "Suite 16",
		"city": "San Jose",
		"country": "United States",
		"state": "CA",
		"zip": "95113"
	}
}';
system "curl -X POST '$baseURL/users?$urlParameters' -d '$data'";

print "\nBuilding Relationships\n\n";

# User: Fred follows Jenny
system "curl -X POST '$baseURL/users/2145059383/following/users/4088675309?$urlParameters'";

# User: Jenny follows Fred
system "curl -X POST '$baseURL/users/4088675309/following/users/2145059383?$urlParameters'";

# User: Fred follows Bob
system "curl -X POST '$baseURL/users/2145059383/following/users/4084708080?$urlParameters'";

# User: Bob follows Fred
system "curl -X POST '$baseURL/users/4084708080/following/users/2145059383?$urlParameters'";

print "\nLoad Products\n\n";

$data = '[ {
    "id" : "faffb31a-16a3-11e5-af63-5f62107fde1d",
    "category" : 2,
    "description" : "Green Baby Rocker",
    "discount" : 0.5,
    "partNo" : "1368433309790",
    "photos" : [ "http://demos.apigee.net/retail/cdn/images/Baby/Green Baby Rocker.jpg", "http://demos.apigee.net/retail/cdn/images/Baby/Green Baby Rocker.jpg" ],
    "price" : 19.4,
    "productName" : "Green Baby Rocker",
    "rating" : 4.2
  }, {
    "id" : "fb09500a-16a3-11e5-9bf8-fb469b19e6a2",
    "category" : 2,
    "description" : "Girl\\\'s Hair Bands 3-Pack Flower Bow",
    "discount" : 0,
    "partNo" : "1368433309753",
    "photos" : [ "http://demos.apigee.net/retail/cdn/images/Baby/Girl\\\'s Hair Bands 3-Pack Flower Bow.jpeg" ],
    "price" : 8,
    "productName" : "Girl\\\'s Hair Bands 3-Pack Flower Bow",
    "rating" : 2
  }, {
    "id" : "fb12c5ea-16a3-11e5-ada1-5946bd30f28c",
    "category" : 2,
    "description" : "Feeding bottles set",
    "discount" : 0,
    "partNo" : "1368433309719",
    "photos" : [ "http://demos.apigee.net/retail/cdn/images/Baby/Feeding bottles set.jpg" ],
    "price" : 4,
    "productName" : "Feeding bottles set",
    "rating" : 2
  }, {
    "id" : "fb18e06a-16a3-11e5-bb75-6d4d7a2fb8cf",
    "category" : 2,
    "description" : "Fake Baby Tattoo - Easy wash away",
    "discount" : 0,
    "partNo" : "1368433309682",
    "photos" : [ "http://demos.apigee.net/retail/cdn/images/Baby/Fake Baby Tattoo - Easy wash away.jpg" ],
    "price" : 10,
    "productName" : "Fake Baby Tattoo - Easy wash away",
    "rating" : 2
  }, {
    "id" : "fb1e379a-16a3-11e5-ba0a-6fd98d9336b1",
    "category" : 2,
    "description" : "Blue Baby Bear Socks",
    "discount" : 5,
    "partNo" : "1368433309682",
    "photos" : [ "http://demos.apigee.net/retail/cdn/images/Baby/Blue Baby Bear Socks.jpg" ],
    "price" : 20,
    "productName" : "Blue Baby Bear Socks",
    "rating" : 2
  }, {
    "id" : "fb242b0a-16a3-11e5-bdb2-01a0762c1f10",
    "category" : 2,
    "description" : "Bellybutton Spin - Set of 3",
    "discount" : 5,
    "partNo" : "1368433309616",
    "photos" : [ "http://demos.apigee.net/retail/cdn/images/Baby/Bellybutton Spin - Set of 3.jpeg" ],
    "price" : 35,
    "productName" : "Bellybutton Spin - Set of 3",
    "rating" : 2
  }, {
    "id" : "fb2b08da-16a3-11e5-b999-5b042a5ae982",
    "category" : 3,
    "description" : "National Geographic magazine has maintained its status as one of the most-read publications for over one hundred years because of its quality educational content, riveting emotional stories, and vivid photographic essays.",
    "discount" : 0.12,
    "partNo" : "B00005NIOH",
    "photos" : [ "http://ecx.images-amazon.com/images/I/51J7LcfkvnL.jpg" ],
    "price" : 19,
    "productName" : "National Geographic Subscription 1yr Autorenewing",
    "rating" : 4.6
  }, {
    "id" : "fb3038fa-16a3-11e5-9d35-5584980f219d",
    "category" : 3,
    "description" : "The man who revolutionized personal technology is celebrated by the writers and editors of TIME magazine in a beautifully illustrated look back on his life and legacies.",
    "discount" : 0.19,
    "partNo" : "978-1618930026",
    "photos" : [ "http://ecx.images-amazon.com/images/I/516-D2YXwgL.jpg" ],
    "price" : 13.87,
    "productName" : "Time Steve Jobs: The Genius Who Changed Our World",
    "rating" : 3.97
  }, {
    "id" : "fb34f3ea-16a3-11e5-a500-f5ec1fd57303",
    "category" : 3,
    "description" : "From the highly acclaimed, multiple award-winning Anthony Doerr, a stunningly ambitious and beautiful novel about a blind French girl and a German boy whose paths collide in occupied France as both try to survive the devastation of World War II.",
    "discount" : 0.12,
    "partNo" : "978-1476746586",
    "photos" : [ "http://ecx.images-amazon.com/images/I/51gmM5cve8L.jpg" ],
    "price" : 16.2,
    "productName" : "All the Light We Cannot See: A Novel by Anthony Doerr",
    "rating" : 4.89
  }, {
    "id" : "fb39fcfa-16a3-11e5-8c82-cf25c8fec803",
    "category" : 3,
    "description" : "Walt Disney Animation Studios presents an epic tale of adventure and comedy with Frozen. When a prophecy traps a kingdom in eternal winter, Anna, a young dreamer, must team up with Kristoff, a daring mountain man, and his reindeer on the grandest of journeys to find Anna\\\'s sister, the Snow Queen Elsa, and put an end to her icy spell.",
    "discount" : 0.11,
    "partNo" : "978-0736430517",
    "photos" : [ "http://ecx.images-amazon.com/images/I/51-vYxxKF percent2BL.jpg" ],
    "price" : 2.38,
    "productName" : "Frozen Little Golden Book (Disney Frozen)",
    "rating" : 4.26
  }, {
    "id" : "fb3ff06a-16a3-11e5-9f05-d1e9ddc535e4",
    "description" : "In The Fault in Our Stars, John Green has created a soulful novel that tackles big subjects--life, death, love--with the perfect blend of levity and heart-swelling emotion. Hazel is sixteen, with terminal cancer, when she meets Augustus at her kids-with-cancer support group.",
    "discount" : 0.13,
    "partNo" : "978-0142424179",
    "photos" : [ "http://ecx.images-amazon.com/images/I/714XxMB percent2B5uL.jpg" ],
    "price" : 8.15,
    "productName" : "The Fault in Our Stars by John Green",
    "rating" : 4.9
  }, {
    "id" : "fb45479a-16a3-11e5-b996-11975f8fca95",
    "category" : 3,
    "description" : "Sky piracy is a bit out of Darian Freyâ€™s league. Fate has not been kind to the captain of the airship Ketty Jayâ€”or his motley crew. They are all running from something.",
    "discount" : 0.16,
    "partNo" : "978-0345522511",
    "photos" : [ "http://ecx.images-amazon.com/images/I/514FGgdh17L.jpg" ],
    "price" : 13.04,
    "productName" : "Retribution Falls by Chris Wooding",
    "rating" : 4.73
  }, {
    "id" : "fb4e6f5a-16a3-11e5-bc1a-5766a30056ad",
    "category" : 2,
    "description" : "Your child will love gobbling up bath toys with the Super Scoop and youâ€™ll love how simple it makes keeping your tub clutter free. The wide mouth and handle make it easy to scoop up toys and the cute fish-shaped hook hangs securely on the bathroom wall to drain and dry.",
    "discount" : 0.13,
    "partNo" : "62003",
    "photos" : [ "http://ecx.images-amazon.com/images/I/81cgTw6ia6L._SL600_.jpg" ],
    "price" : 10.39,
    "productName" : "BRICA Super Scoop Bath Toy Organizer",
    "rating" : 4.69
  }, {
    "id" : "fb53ed9a-16a3-11e5-b8a3-41142e47bd73",
    "category" : 2,
    "description" : "Test the waters with America\\\'s #1 Safety Duck. No need to worry that your baby\\\'s bath water is too hot to handle. This adorable rubber ducky has our White Hot safety disc at the bottom that tells you when the water is too hot, then let\\\'s you know that it\\\'s safe to put your baby in.",
    "discount" : 0.11,
    "partNo" : "31001",
    "photos" : [ "http://ecx.images-amazon.com/images/I/71d-yPz2g6L._SL600_.jpg" ],
    "price" : 2.39,
    "productName" : "Munchkin \\\'White Hot\\\' Duck Bath Toy",
    "rating" : 4.7
  }, {
    "id" : "fb58cf9a-16a3-11e5-b741-e9b8a76293c4",
    "category" : 2,
    "description" : "The Zoo Pack is the little kid backpack where fun meets function. Whimsical details and durable materials make this the perfect on-the-go pack for kids on-the-go.",
    "discount" : 0.12,
    "partNo" : "210204",
    "photos" : [ "http://ecx.images-amazon.com/images/I/51yOkBc7ANL.jpg", "http://ecx.images-amazon.com/images/I/51zAZwundzL.jpg" ],
    "price" : 17.07,
    "productName" : "Skip Hop Zoo Pack Little Kid Backpack",
    "rating" : 4.81
  }, {
    "id" : "fb5dd8aa-16a3-11e5-b20c-23d1128a3a0c",
    "category" : 2,
    "description" : "Orbit Baby\\\'s spacious cargo basket gives you plenty of storage for all of your family\\\'s necessities while you stroll.",
    "discount" : 0.15,
    "partNo" : "A810449020046",
    "photos" : [ "http://ecx.images-amazon.com/images/I/71g7qKtbrmL._SL600_.jpg" ],
    "price" : 80,
    "productName" : "Orbit Baby G3 Stroller Cargo Basket",
    "rating" : 4.05
  }, {
    "id" : "fb62e1ba-16a3-11e5-901f-87006c55f4ea",
    "category" : 2,
    "description" : "Adapt to take 2 inline with the navigator double kit . From newborn baby to two toddlers: one buggy, loads of years! Slimline at 23 wide, lightweight 28lbs",
    "discount" : 0.12,
    "partNo" : "B00FLXBQ6S",
    "photos" : [ "http://ecx.images-amazon.com/images/I/71kdKZwmVVL._SL600_.jpg", "http://ecx.images-amazon.com/images/I/71BqHwpUNaL._SL600_.jpg" ],
    "price" : 499.99,
    "productName" : "phil&teds Navigator Stroller",
    "rating" : 3.8
  }, {
    "id" : "fb674e8a-16a3-11e5-afa4-ed77e6279472",
    "category" : 2,
    "description" : "Snug & Dry Diapers with SureFit design and stretchy waistband bring your baby the dryness and comfort they deserve.",
    "discount" : 0.16,
    "partNo" : "36000365474",
    "photos" : [ "http://ecx.images-amazon.com/images/I/81YIe5f1RqL._SL600_.jpg" ],
    "price" : 47.19,
    "productName" : "Huggies Snug & Dry Diapers",
    "rating" : 4.52
  }, {
    "id" : "fb6c7eaa-16a3-11e5-8e5e-576f280ec63f",
    "category" : 1,
    "description" : "DC Sports mufflers are made to replace your vehicle\\\'s factory muffler which offers improved looks and deeper tones.",
    "discount" : 0.11,
    "partNo" : "EX-5016",
    "photos" : [ "http://ecx.images-amazon.com/images/I/61yzLl19W4L._SL600_.jpg" ],
    "price" : 41.94,
    "productName" : "DC Sport EX-5016 Stainless Steel Round Muffler and Slant Cut Exhaust Tip",
    "rating" : 4.54
  }, {
    "id" : "fb72c03a-16a3-11e5-a524-2944b48f7e7f",
    "category" : 1,
    "description" : "High performance SUV and light truck tire with a V-shape design for superior handling in dry and wet road conditions",
    "discount" : 0.13,
    "partNo" : "1004912",
    "photos" : [ "http://ecx.images-amazon.com/images/I/712-Mx5iW0L._SL600_.jpg" ],
    "price" : 171.58,
    "productName" : "Hankook Ventus ST RH06 All-Season Tire - 265/50R20 112W",
    "rating" : 4.97
  }, {
    "id" : "fb77c94a-16a3-11e5-a648-1fe75acd57fd",
    "category" : 1,
    "description" : "Mann-Filter Spin-on Oil Filters are used for the filtration of lube oils, hydraulic oils and coolants in a variety of applications.",
    "discount" : 0.17,
    "partNo" : "06H115403",
    "photos" : [ "http://ecx.images-amazon.com/images/I/61PmB4Dqg0L._SL600_.jpg", "http://ecx.images-amazon.com/images/I/61KqMqFFigL._SL600_.jpg" ],
    "price" : 13.38,
    "productName" : "Mann-Filter W 719/45 Spin-on Oil Filter",
    "rating" : 3.95
  }, {
    "id" : "fb7cab4a-16a3-11e5-8feb-59b2c572b582",
    "category" : 1,
    "description" : "Mann-Filter elements are metal-free. They are made of one material and do not create ash when disposed of in a thermal process.",
    "discount" : 0.19,
    "partNo" : "A4011558728809",
    "photos" : [ "http://ecx.images-amazon.com/images/I/71LegLTYV0L._SL600_.jpg" ],
    "price" : 10.32,
    "productName" : "Mann-Filter HU 719/6 X Metal-Free Oil Filter",
    "rating" : 4.36
  }, {
    "id" : "fb85d30a-16a3-11e5-baa1-135830217795",
    "category" : 1,
    "description" : "Mobil 1 0W-40 exceeding industry standards and the major leading builder requirements is the cornerstone of the performance reserve that lets Mobil 1 0W-40 keep performing well after conventional oils cannot.",
    "discount" : 0.11,
    "partNo" : "B000SKV4U2",
    "photos" : [ "http://ecx.images-amazon.com/images/I/71d0cJSsjfL._SL600_.jpg" ],
    "price" : 48,
    "productName" : "Mobil 1 96989 0W-40 Synthetic Motor Oil - 1 Quart (Pack of 6)",
    "rating" : 4.23
  }, {
    "id" : "fb8c3baa-16a3-11e5-89fa-4bc1a0adccdf",
    "category" : 1,
    "description" : "16x8 Black American Racing AR890 5x5 with a 30mm offset and a 78.3 hub bore",
    "discount" : 0.13,
    "partNo" : "AR89068050730",
    "photos" : [ "http://ecx.images-amazon.com/images/I/61giEGUslXL._SL600_.jpg", "http://ecx.images-amazon.com/images/I/41J8Gisfu4L.jpg" ],
    "price" : 118.97,
    "productName" : "American Racing AR890 Wheel with Satin Black Machined (16x8/5x5)",
    "rating" : 4.82
  }, {
    "id" : "fb9144ba-16a3-11e5-b7c5-dd95c328c857",
    "category" : 0,
    "description" : "Helps support easy breathing and congestion relief for day and night. Helps provide moisture for dry cough, sinus irritation and other effects caused by dry air. Whisper quiet operation",
    "discount" : 0.14,
    "partNo" : "EE-5301TP",
    "photos" : [ "http://www.homedepot.ca/wcsstore/HomeDepotCanada/images/catalog/humidifier_Pink_drop_4.jpg" ],
    "price" : 64.99,
    "productName" : "Crane Ultrasonic Cool Mist Humidifier, Pink Drop Shape",
    "rating" : 4.27
  }, {
    "id" : "fb98228a-16a3-11e5-ac2e-f1f8c9ef69c5",
    "category" : 0,
    "description" : "1.1 cu. ft. Countertop stainless microwave with 1000 watts of cooking power",
    "discount" : 0.17,
    "partNo" : "DMW111KSSDD",
    "photos" : [ "http://www.homedepot.ca/wcsstore/HomeDepotCanada/images/catalog/DMW111KSSDD_4.jpg" ],
    "price" : 99.99,
    "productName" : "Danby 1.1 Cubic Feet Microwave-Stainless",
    "rating" : 4.52
  }, {
    "id" : "fb9d048a-16a3-11e5-8403-fd07e270babf",
    "category" : 0,
    "description" : "DC23 Motorhead is engineered for powerful cleaning on carpets. It has a motorised brush head with stiff nylon bristles that spin up to 90 times per second to dislodge ground-in dirt and pet hair. DC23 Motorhead has Root Cycloneâ„¢ technology + Core separator â€“ advanced cyclone technology for capturing microscopic dust as small as 0.5 microns.",
    "discount" : 0.2,
    "partNo" : "14666-01",
    "photos" : [ "http://www.homedepot.ca/wcsstore/HomeDepotCanada/images/catalog/15701.DC23_IRSYE_53A4_NP_4.jpg", "http://www.homedepot.ca/wcsstore/HomeDepotCanada/images/catalog/15701.DC23MH_High_Res_JPEG_4.jpg" ],
    "price" : 598.99,
    "productName" : "Dyson DC23 Motorhead",
    "rating" : 4.25
  }, {
    "id" : "fba20d9a-16a3-11e5-9bbf-5557a034a14e",
    "category" : 0,
    "description" : "From its generous 637 square inches of total cooking space to its 7mm diameter stainless steel rod cooking grates, the Genesis S-310 gas grill literally shines with quality and craftsmanship. Whatâ€™s more, its front-mounted control knobs free up both side tables to provide expansive prep space on this vision in stainless steel.",
    "discount" : 0.17,
    "partNo" : "6650001",
    "photos" : [ "http://www.homedepot.ca/wcsstore/HomeDepotCanada/images/catalog/cmyk_6650001A_4.jpg", "http://www.homedepot.ca/wcsstore/HomeDepotCanada/images/catalog/cmyk_6550001C_4.jpg" ],
    "price" : 1049.99,
    "productName" : "Weber Genesis S310 NG BBQ",
    "rating" : 3.91
  }, {
    "id" : "fba716aa-16a3-11e5-8139-b9239fb18b11",
    "category" : 0,
    "description" : "Take home a refrigerator that makes storing all your favorite fresh and frozen food easy. With 25 cu.ft. of capacity, this WhirlpoolÂ® side-by-side refrigerator offers the space you need to meet all your food storage needs.",
    "discount" : 0.1,
    "partNo" : "WRS325FDAM",
    "photos" : [ "http://www.homedepot.com/catalog/productImages/400/5f/5f04933a-16db-4c53-afda-8538a3013f61_400.jpg", "http://www.homedepot.com/catalog/productImages/400/f8/f85a77d9-8929-419b-ac4c-936cc6ae9d69_400.jpg" ],
    "price" : 988.2,
    "productName" : "WhirlpoolÂ® Stainless Steel 25 cu.ft. Side-by-Side Refrigerator",
    "rating" : 4.08
  }, {
    "id" : "fbabd19a-16a3-11e5-9efa-adbab9639cc8",
    "category" : 0,
    "description" : "The DV361 comes with features including king-size capacity, a filter check indication, 7 drying cycles, and Sensor Dry, which will adjust for ideal drying times and save extra energy.",
    "discount" : 0.18,
    "partNo" : "DV361EWBEWR",
    "photos" : [ "http://www.trailappliances.com/catalogue-content/product-images/779/DV361EWBEWR-1-main.jpg" ],
    "price" : 549.98,
    "productName" : "Samsung White 7.3 cu.ft. Dryer, 7 Cycles",
    "rating" : 4.13
  }, {
    "id" : "fbb08c8a-16a3-11e5-9bb0-0bc2e2be30b9",
    "category" : 4,
    "description" : "22.3 MP Full Frame CMOS Digital SLR Camera with EF 24-105mm f/4 L IS USM Lens",
    "discount" : 0.18,
    "partNo" : "5260B009",
    "photos" : [ "http://ecx.images-amazon.com/images/I/71FJVZu3VxL._SL1500_.jpg", "http://ecx.images-amazon.com/images/I/71dRUNqpSQL._SL1500_.jpg" ],
    "price" : 3999,
    "productName" : "Canon EOS 5D Mark III",
    "rating" : 3.9
  }, {
    "id" : "fbb6a70a-16a3-11e5-953b-fb625fed5dbf",
    "category" : 4,
    "description" : "20.2 MP CMOS Digital SLR Camera with 3.0-Inch LCD and EF24-105mm IS Lens Kit",
    "discount" : 0.12,
    "partNo" : "8035B009",
    "photos" : [ "http://ecx.images-amazon.com/images/I/71lm0i0NUiL._SL1500_.jpg", "http://ecx.images-amazon.com/images/I/61ZKQkka0BL._SL1500_.jpg" ],
    "price" : 2499,
    "productName" : "Canon EOS 6D",
    "rating" : 4.41
  }, {
    "id" : "fbbbb01a-16a3-11e5-a23a-639d1c1aee91",
    "category" : 4,
    "description" : "IS 16.0 MP Digital Camera with 30x Wide-Angle Optical Image Stabilized Zoom and 3.0-Inch LCD (Black)",
    "discount" : 0.15,
    "partNo" : "6353B001",
    "photos" : [ "http://ecx.images-amazon.com/images/I/61bp8OZEHML._SL1500_.jpg", "http://ecx.images-amazon.com/images/I/61KIT-Z05hL._SL1500_.jpg" ],
    "price" : 299,
    "productName" : "Canon PowerShot SX500",
    "rating" : 3.82
  }, {
    "id" : "fbc1556a-16a3-11e5-ae2e-eb230f9ff07d",
    "category" : 4,
    "description" : "18 MP CMOS Digital SLR Camera and DIGIC 4 Imaging with EF-S 18-55mm f/3.5-5.6 IS Lens",
    "discount" : 0.11,
    "partNo" : "5169B003",
    "photos" : [ "http://ecx.images-amazon.com/images/I/71hurE69ltL._SL1500_.jpg", "http://ecx.images-amazon.com/images/I/61f4uWo percent2B09L._SL1500_.jpg" ],
    "price" : 599,
    "productName" : "Canon EOS Rebel T3i",
    "rating" : 4.1
  }, {
    "id" : "fbc5c23a-16a3-11e5-a38a-cfd80ea30262",
    "category" : 4,
    "description" : "IS 16.0 MP Digital Camera with 16x Optical Zoom and 720p HD Video (Black)",
    "discount" : 0.17,
    "partNo" : "B00EFILR6E",
    "photos" : [ "http://ecx.images-amazon.com/images/I/71gXhXiyccL._SL1500_.jpg", "http://ecx.images-amazon.com/images/I/71aQfOREubL._SL1500_.jpg" ],
    "price" : 179,
    "productName" : "Canon PowerShot SX170",
    "rating" : 4.61
  }, {
    "id" : "fbcb678a-16a3-11e5-bc47-17db3758fdb2",
    "category" : 4,
    "description" : "12.2 MP CMOS Digital SLR with 18-55mm IS II Lens and EOS HD Movie Mode (Black)",
    "discount" : 0.17,
    "partNo" : "5157B002",
    "photos" : [ "http://ecx.images-amazon.com/images/I/61-hlE2BgajL._SL1500_.jpg", "http://ecx.images-amazon.com/images/I/61UN-1oElmL._SL1500_.jpg" ],
    "price" : 449,
    "productName" : "Canon EOS Rebel T3",
    "rating" : 4.82
  }, {
    "id" : "fbcfd45a-16a3-11e5-8cd4-f3c57e580e5c",
    "category" : 5,
    "description" : "An essential for kicked-back days",
    "discount" : 0.15,
    "partNo" : "18841",
    "photos" : [ "http://g.nordstromimage.com/imagegallery/store/product/Gigantic/3/_8701003.jpg", "http://g.nordstromimage.com/imagegallery/store/product/Large/4/_8700964.jpg" ],
    "price" : 64.5,
    "productName" : "Roll-Up Denim Bermuda Shorts (Wise) (Regular and Petite)",
    "rating" : 4.16
  }, {
    "id" : "fbd4b65a-16a3-11e5-be7f-fd01ec50cb7c",
    "category" : 5,
    "description" : "Svelte skinnies cut from J Brand",
    "discount" : 0.14,
    "partNo" : "918674",
    "photos" : [ "http://g.nordstromimage.com/imagegallery/store/product/Large/13/_8943693.jpg", "http://g.nordstromimage.com/imagegallery/store/product/Large/7/_8943687.jpg" ],
    "price" : 185,
    "productName" : "485\\\' Mid Rise Super Skinny Jeans (Wildflower)",
    "rating" : 4.31
  }, {
    "id" : "fbd9bf6a-16a3-11e5-85a6-bfc3ecef110a",
    "category" : 5,
    "description" : "Capri-length jeans with side-slit hems offer exceptional comfort in stretch cotton washed in springy colors.",
    "discount" : 0.12,
    "partNo" : "243749",
    "photos" : [ "http://g.nordstromimage.com/imagegallery/store/product/Gigantic/2/_8838842.jpg", "http://g.nordstromimage.com/imagegallery/store/product/Large/9/_8838829.jpg" ],
    "price" : 84,
    "productName" : "Hayden\\\' Stretch Cotton Crop Pants (Regular and Petite)",
    "rating" : 4.37
  }, {
    "id" : "fbde534a-16a3-11e5-bd51-c95144d23027",
    "category" : 5,
    "description" : "Sleek stretch jeans are fashioned from dimensional denim and styled with a fitted leg and retro, ankle-grazing hems. ",
    "discount" : 0.17,
    "partNo" : "612987",
    "photos" : [ "http://g.nordstromimage.com/imagegallery/store/product/Gigantic/18/_7330658.jpg", "http://g.nordstromimage.com/imagegallery/store/product/Gigantic/0/_7330660.jpg" ],
    "price" : 169,
    "productName" : "The Slim Cigarette\\\' Stretch Jeans (Los Angeles)",
    "rating" : 4.6
  }, {
    "id" : "fbe3354a-16a3-11e5-8506-93d9bcd3901f",
    "category" : 5,
    "description" : "A comfortable yet stylish mid-rise waist gives way to the lean tapered legs on a pair of medium-rinse skinnies. 31 inseam; 12 leg opening; 9 front rise; 13 back rise (size 29). Zip fly with two-button closure. Five-pocket style. Dark dye may transfer to lighter materials. 98 percent cotton, 2 percent elastane. Machine wash cold, tumble dry low. By Hudson Jeans; Made in the USA of imported fabric. t.b.d.",
    "discount" : 0.15,
    "partNo" : "697690",
    "photos" : [ "http://g.nordstromimage.com/imagegallery/store/product/Gigantic/9/_9103069.jpg", "http://g.nordstromimage.com/imagegallery/store/product/Large/18/_9102838.jpg" ],
    "price" : 198,
    "productName" : "Collin\\\' Skinny Jeans (Saville)",
    "rating" : 4.56
  }, {
    "id" : "fbe8656a-16a3-11e5-96f4-1139ffe4b83f",
    "category" : 5,
    "description" : "Inky stretch denim styles ultra-versatile jeans with super-skinny legs. 29 inseam; 11 leg opening; 9 1/2 front rise; 14 back rise. Zip fly with button closure. Five-pocket style. Dark dye may transfer to lighter materials. 77 percent cotton, 21 percent polyester, 2 percent spandex. Machine wash cold, tumble dry low. By J Brand; made in the USA. t.b.d. ",
    "discount" : 0.14,
    "partNo" : "361308",
    "photos" : [ "http://g.nordstromimage.com/imagegallery/store/product/Gigantic/0/_9107580.jpg", "http://g.nordstromimage.com/imagegallery/store/product/Large/13/_9107573.jpg" ],
    "price" : 178,
    "productName" : "811\\\' Skinny Stretch Jeans (Saltwater)",
    "rating" : 4.98
  }, {
    "id" : "fbed205a-16a3-11e5-9bcc-7fe22fc2b9f7",
    "category" : 6,
    "description" : "2.6GHz Dual-core Intel Core i5, Turbo Boost up to 3.1GHz 8GB 1600MHz DDR3L SDRAM 512GB PCIe-based Flash Storage Backlit Keyboard (English) & User\\\'s Guide Accessory Kit",
    "discount" : 0.12,
    "partNo" : "ME866LLA",
    "photos" : [ "http://store.storeimages.cdn-apple.com/3977/as-images.apple.com/is/image/AppleInc/macbook-pro-gallery1-2013?wid=978&hei=535&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1386284299630", "http://store.storeimages.cdn-apple.com/3977/as-images.apple.com/is/image/AppleInc/macbook-pro-gallery4-2013?wid=978&hei=535&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1386284601137" ],
    "price" : 1799,
    "productName" : "MacBook Pro: 2.6GHz with 13-inch Retina display",
    "rating" : 3.85
  }, {
    "id" : "fbf3fe2a-16a3-11e5-96da-7126c24f5d06",
    "category" : 6,
    "description" : "3.5GHz 6-Core Intel Xeon E5 processor 16GB 1866MHz DDR3 ECC memory Dual AMD FirePro D500 with 3GB GDDR5 VRAM each 256GB PCIe-based flash storage1",
    "discount" : 0.11,
    "partNo" : "MD878LLA",
    "photos" : [ "http://store.storeimages.cdn-apple.com/3977/as-images.apple.com/is/image/AppleInc/mac-pro-gallery1-2013?wid=930&hei=629&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1381433550923", "http://store.storeimages.cdn-apple.com/3977/as-images.apple.com/is/image/AppleInc/mac-pro-gallery3-2013?wid=930&hei=629&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1381433508335" ],
    "price" : 3999,
    "productName" : "MacPro: 6-Core and Dual GPU",
    "rating" : 4.16
  }, {
    "id" : "fbf843ea-16a3-11e5-b041-792b883ff964",
    "category" : 6,
    "description" : "3.4GHz quad-core Intel Core i5 Turbo Boost up to 3.8GHz 8GB (two 4GB) memory 1TB hard drive1 NVIDIA GeForce GTX 775M with 2GB video memory",
    "discount" : 0.19,
    "partNo" : "ME089LLA",
    "photos" : [ "http://store.storeimages.cdn-apple.com/3977/as-images.apple.com/is/image/AppleInc/2012-imac-gallery1?wid=975&hei=625&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1380574636826", "http://store.storeimages.cdn-apple.com/3977/as-images.apple.com/is/image/AppleInc/2012-imac-gallery2?wid=975&hei=625&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1380574340912" ],
    "price" : 1999,
    "productName" : "iMac: 27-inch 3.4GHz",
    "rating" : 4.27
  }, {
    "id" : "fbfe375a-16a3-11e5-b469-5dd15804be0d",
    "category" : 6,
    "description" : "2.3GHz quad-core Intel Core i7 Turbo Boost up to 3.5GHz 16GB 1600MHz memory 512GB PCIe-based flash storage 1 Intel Iris Pro Graphics NVIDIA GeForce GT 750M with 2GB GDDR5 memory Built-in battery (8 hours)2",
    "discount" : 0.2,
    "partNo" : "ME294LLA",
    "photos" : [ "http://store.storeimages.cdn-apple.com/3977/as-images.apple.com/is/image/AppleInc/macbook-pro-gallery1-2013?wid=978&hei=535&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1386284299630", "http://store.storeimages.cdn-apple.com/3977/as-images.apple.com/is/image/AppleInc/macbook-pro-gallery2-2013?wid=978&hei=535&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1387429117504" ],
    "price" : 2599,
    "productName" : "MacBook Pro: 2.3GHz with 15-inch Retina display",
    "rating" : 4.95
  }, {
    "id" : "fc03677a-16a3-11e5-a6f9-5f6a2c3a24d5",
    "category" : 6,
    "description" : "Specifications 2.3GHz quad-core Intel Core i7 4GB memory 1TB hard drive1 Intel HD Graphics 4000 OS X Mavericks",
    "discount" : 0.13,
    "partNo" : "MD388LLA",
    "photos" : [ "http://store.storeimages.cdn-apple.com/3977/as-images.apple.com/is/image/AppleInc/2012-macmini-gallery1?wid=975&hei=535&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1350177646557", "http://store.storeimages.cdn-apple.com/3977/as-images.apple.com/is/image/AppleInc/2012-macmini-gallery2?wid=975&hei=535&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1350177647082" ],
    "price" : 799,
    "productName" : "Mac mini: 2.3GHz",
    "rating" : 4.43
  }, {
    "id" : "fc08226a-16a3-11e5-94f9-fb4d93d8f823",
    "category" : 6,
    "description" : "13-inch : 256GB Specifications 1.4GHz dual-core Intel Core i5 processor Turbo Boost up to 2.7GHz Intel HD Graphics 5000 4GB memory 256GB PCIe-based flash storage",
    "discount" : 0.11,
    "partNo" : "MD761LLB",
    "photos" : [ "http://store.storeimages.cdn-apple.com/3977/as-images.apple.com/is/image/AppleInc/macbook-air-gallery1-2014?wid=978&hei=580&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1397772293689", "http://store.storeimages.cdn-apple.com/3977/as-images.apple.com/is/image/AppleInc/macbook-air-gallery3-2014?wid=978&hei=580&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1397772305327" ],
    "price" : 1199,
    "productName" : "MacBook Air: 13-inch",
    "rating" : 4.68
  }, {
    "id" : "fc0cb64a-16a3-11e5-b4ee-35d921f521ed",
    "category" : 7,
    "description" : "Whether itâ€™s a cushioned deck with springy push off you like or a solid, stable surface that feels more like the road, the Nordictrack C 950 Adjustable Auto Incline Pro Treadmill gives you the best of both worlds with FlexSelectâ„¢ Cushioning. A half-twist of the adjustment dampener gives you the surface you prefer. You can track your progress clearly on a big, 7-inch display and multiply your results with the convenience of the interactive iFit technology.",
    "discount" : 0.16,
    "partNo" : "00659575000P",
    "photos" : [ "http://c.shld.net/rpx/i/s/i/spin/image/spin_prod_862496712?hei=1000&wid=1000&qlt=75,0&op_sharpen=1&op_usm=0.9,0.5,0,0" ],
    "price" : 1050,
    "productName" : "Phoenix 98835 Motorized Treadmill",
    "rating" : 4.94
  }, {
    "id" : "fc11984a-16a3-11e5-ad0e-7744b7d4d577",
    "category" : 7,
    "description" : "Get More of Everything on This Auto Adjusting Incline Treadmill from Nordictrack",
    "discount" : 0.17,
    "partNo" : "00624990000P",
    "photos" : [ "http://c.shld.net/rpx/i/s/i/spin/image/spin_prod_887711412?hei=1000&wid=1000&qlt=75,0&op_sharpen=1&op_usm=0.9,0.5,0,0", "http://c.shld.net/rpx/i/s/i/spin/image/spin_prod_887711312?hei=1000&wid=1000&qlt=75,0&op_sharpen=1&op_usm=0.9,0.5,0,0" ],
    "price" : 1499.99,
    "productName" : "NordicTrack C 950 Pro Treadmill",
    "rating" : 4.04
  }, {
    "id" : "fc16051a-16a3-11e5-aea7-45f83f0dab0f",
    "category" : 7,
    "description" : "The Automatic Adjusting NordicTrack Treadmill Makes Results Happen. The ultimate runnerâ€™s machine, the NordicTrack C700 auto adjustable treadmill features a longer and wider, 20-inch by 60-inch deck for more space to stretch your stride. Whether you walk, jog or run â€“ this treadmill accommodates your style with speeds up to 12 miles per hour that can be changed at a buttonâ€™s touch. Comfort and reliability combine as a 2.75 CHP motor powers your workout while FlexSelectâ„¢ Cushioning lets you adjust the deck to a hard or soft running surface.",
    "discount" : 0.1,
    "partNo" : "00624988000P",
    "photos" : [ "http://c.shld.net/rpx/i/s/i/spin/image/spin_prod_882013012?hei=1000&wid=1000&qlt=75,0&op_sharpen=1&op_usm=0.9,0.5,0,0", "http://c.shld.net/rpx/i/s/i/spin/image/spin_prod_898894012?hei=1000&wid=1000&qlt=75,0&op_sharpen=1&op_usm=0.9,0.5,0,0" ],
    "price" : 1199.99,
    "productName" : "NordicTrack C 700 Treadmill",
    "rating" : 3.86
  }, {
    "id" : "fc1e427a-16a3-11e5-9cac-939f180cbd66",
    "category" : 7,
    "description" : "Get ready to run in comfort with the 6.75 Treadmill by Smooth. A great way to stay in shape and log the miles you need all year round, this treadmill delivers convenience, ergonomic design, quiet operation and technological innovation to bring you a phenomenal running experience no matter the weather. Easy to move around, this comparatively lightweight treadmill is quick to set up and break down for space saving convenience that will fit any home.",
    "discount" : 0.17,
    "partNo" : "00697861000P",
    "photos" : [ "http://c.shld.net/rpx/i/s/i/spin/image/spin_prod_670699701?hei=1000&wid=1000&qlt=75,0&op_sharpen=1&op_usm=0.9,0.5,0,0", "http://c.shld.net/rpx/i/s/i/spin/image/spin_prod_670699301?hei=1000&wid=1000&qlt=75,0&op_sharpen=1&op_usm=0.9,0.5,0,0" ],
    "price" : 2297.99,
    "productName" : "Smooth Fitness Smooth 6.75 Treadmill",
    "rating" : 4.42
  }, {
    "id" : "fc23247a-16a3-11e5-9ca9-f1ee1f60d1db",
    "category" : 7,
    "description" : "Amp it Up with the NordicTrack Elite 3700 Interactive Treadmill. Equipped with the best fitness technology available and banning the boredom of working out, the NordicTrack elite 3700 interactive treadmill puts your goals well within reach. The Intermix Acousticsâ„¢ Sound System on the treadmill features two high quality three-inch speakers for amazing sound, delivering the inspiration to press â€œstartâ€ and the motivation to keep moving. Plug in your iPod, ditch your ear buds and turn up the volume for a fun way to workout.",
    "discount" : 0.13,
    "partNo" : "00624932000P",
    "photos" : [ "http://c.shld.net/rpx/i/s/i/spin/image/spin_prod_887946012?hei=1000&wid=1000&qlt=75,0&op_sharpen=1&op_usm=0.9,0.5,0,0", "http://c.shld.net/rpx/i/s/i/spin/image/spin_prod_926103012?hei=1000&wid=1000&qlt=75,0&op_sharpen=1&op_usm=0.9,0.5,0,0" ],
    "price" : 1999.99,
    "productName" : "NordicTrack Elite 3700 Treadmill",
    "rating" : 4.84
  }, {
    "id" : "fc27b85a-16a3-11e5-b561-7be9589da940",
    "category" : 7,
    "description" : "The right treadmill makes a difference, especially for highly active fitness enthusiasts. That\\\'s why the AFG 7.1AT treadmill has a highly durable, non-folding frame that\\\'s designed to last a lifetime. Built with heavy gauge steel, it delivers a club-like workout experience that wonâ€™t shift or creak during the most intense exercise sessions. The commercial-grade 3.25 horsepower continuous-duty motor offers a smooth and silent ride, no matter your pace. This ultra-quiet drive system also features a 15 percent power incline that delivers more workout options to help you reach every fitness goal faster, distraction- and worry-free.",
    "discount" : 0.17,
    "partNo" : "00621094000P",
    "photos" : [ "http://c.shld.net/rpx/i/s/i/spin/image/spin_prod_540924301?hei=1000&wid=1000&qlt=75,0&op_sharpen=1&op_usm=0.9,0.5,0,0", "http://c.shld.net/rpx/i/s/i/spin/image/spin_prod_540923301?hei=1000&wid=1000&qlt=75,0&op_sharpen=1&op_usm=0.9,0.5,0,0" ],
    "price" : 1699.99,
    "productName" : "AFG 7.1AT Treadmill",
    "rating" : 3.92
  }, {
    "id" : "fc2c4c3a-16a3-11e5-874e-a93c47af73de",
    "category" : 8,
    "description" : "Chocolate lovers will surely appreciate this gift box of assorted milk-, white- and dark-chocolate-covered OreosÂ®, drizzled chocolate-covered pretzels and three ounces of jumbo chocolate-covered almonds.",
    "discount" : 0.13,
    "partNo" : "40957500",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/24766340957500p?qlt=85,1&op_sharpen=1&resMode=bilin&id=RjQSp2&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 39.99,
    "productName" : "Chocolate Favorites Faux Suede Desktop Gift Box",
    "rating" : 4.33
  }, {
    "id" : "fc31a36a-16a3-11e5-a08e-d5292ddbf65f",
    "category" : 8,
    "description" : "The lucky recipients will find three pounds of delicious sweet and savory foods including French chocolate truffles, white-chocolate-covered pretzels, Old DominionÂ® peanut brittle squares, Brown & HaleyÂ® Almond RocaÂ®, cinnamon apple crisps, BellagioÂ® coffee drink mix, savory snack mix, East ShoreÂ® honey wheat dipping pretzels, Robert Rothschild FarmÂ® raspberry honey dipping mustard, DolcettoÂ® chocolate-filled petite wafer cookies, California smoked almonds, focaccia crisp crackers, WalkerÂ® shortbread cookies, peanut-butter-filled pretzels, dried fruit-and-nut mix, and brie cheese spread.",
    "discount" : 0.14,
    "partNo" : "40957524",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/24766540957524p?qlt=85,1&op_sharpen=1&resMode=bilin&id=zPNS31&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 99.99,
    "productName" : "Superior Grand Gourmet Basket",
    "rating" : 4.92
  }, {
    "id" : "fc35c21a-16a3-11e5-a451-bd4c6ebe2f57",
    "category" : 8,
    "description" : "It\\\'s filled with over two and a half pounds of gourmet chocolate delights, including HebertÂ® handcrafted specialty chocolate nonpareils, caramel-filled chocolate croquettes, and an all-natural Hebert milk chocolate bar; plus chocolate chip cookies, white-chocolate- covered pretzels, chocolate-covered almonds, chocolate-filled peppermints and chocolate-covered OreosÂ®.",
    "discount" : 0.15,
    "partNo" : "40957555",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/24766840957555p?qlt=85,1&op_sharpen=1&resMode=bilin&id=pC6TR0&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 69.99,
    "productName" : "Chocolate Cravings Gift Tower",
    "rating" : 4.9
  }, {
    "id" : "fc3a7d0a-16a3-11e5-91f3-f935e2e168c8",
    "category" : 8,
    "description" : "The ultimate gift for chocolate connoisseurs, this delightful gift set featuring a delectable assortment of six 3.5-oz. EXCELLENCE bars in the following flavors: Orange Intense, White Coconut, A Touch of Sea Salt, Toffee Crunch, Dark Chocolate Chili",
    "discount" : 0.17,
    "partNo" : "41002209",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/25072241002209p?qlt=85,1&op_sharpen=1&resMode=bilin&id=oN9TD3&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 23.99,
    "productName" : "Lindt EXCELLENCE 6-Count Chocolate Bar Gift Set",
    "rating" : 3.89
  }, {
    "id" : "fc3ee9da-16a3-11e5-963f-3dea29c8dbd4",
    "category" : 8,
    "description" : "Premium GhirardelliÂ® chocolate is taken to towering heights with this truly delightful gift. Each stacking box is filled with a different chocolate confection that\\\'s sure to satisfy any chocolate lover\\\'s cravings.",
    "discount" : 0.13,
    "partNo" : "40850603",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/24088640850603p?qlt=85,1&op_sharpen=1&resMode=bilin&id=swBTv2&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 59.99,
    "productName" : "GhirardelliÂ® Glorious 6-Tier Gift Tower",
    "rating" : 4.81
  }, {
    "id" : "fc437dba-16a3-11e5-bd94-a57cf6e37828",
    "category" : 8,
    "description" : "Treat yourself or someone dear with this delightful chocolate gift box, beautifully adorned with the iconic San Francisco skyline and filled with a San Francisco treasure.",
    "discount" : 0.12,
    "partNo" : "40850665",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/24089240850665p?qlt=85,1&op_sharpen=1&resMode=bilin&id=ycLS71&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 34.99,
    "productName" : "GhiradelliÂ® San Francisco Skyline 80-Count Large Cylinder Gift Box",
    "rating" : 4.14
  }, {
    "id" : "fc4838aa-16a3-11e5-a7e3-690790971676",
    "category" : 9,
    "description" : "A vital, first step in your skin care regimen, Crystal Peel\\\'s Microdermabrasion Creme is the original, patented, physician-endorsed formula created for home use. It polishes away dead skin cells revealing a radiant, youthful glow.",
    "discount" : 0.15,
    "partNo" : "40330686",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/21199640330686p?qlt=85,1&op_sharpen=1&resMode=bilin&id=jQXT_1&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 67.99,
    "productName" : "Crystal Peelâ„¢ Microdermabrasion Collection Duo",
    "rating" : 4.97
  }, {
    "id" : "fc4d1aaa-16a3-11e5-97c0-2529a70d4d3a",
    "category" : 9,
    "description" : "Skin-energizing Dead Sea salt crystals are 100 percent natural and packed with healthy minerals. Rich in health-enabling minerals, muscles and joints feel relaxed and skin feels soft, smooth and refreshingly hydrated after a bath.",
    "discount" : 0.19,
    "partNo" : "18310767",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/18994718310767p?qlt=85,1&op_sharpen=1&resMode=bilin&id=eHISv1&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 21,
    "productName" : "Ahava Natural 32-Ounce Bath Salts",
    "rating" : 4.44
  }, {
    "id" : "fc5530fa-16a3-11e5-abf5-4ba69f67f6d1",
    "category" : 9,
    "description" : "The basq ultra rich Illipe Body Butter is a full body, mega rich complex of Illipe, Shea and Jojoba butters that tone, replenish and strengthen skin.",
    "discount" : 0.18,
    "partNo" : "16880779",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/12284516880779p?qlt=85,1&op_sharpen=1&resMode=bilin&id=A1yS72&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 30,
    "productName" : "basq Illipe Body Butter",
    "rating" : 3.92
  }, {
    "id" : "fc5a12fa-16a3-11e5-975e-ab8508901b18",
    "category" : 9,
    "description" : "This luscious cream wash feels more like a body lotion than a liquid soap.",
    "discount" : 0.15,
    "partNo" : "18310627",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/18994618310627p?qlt=85,1&op_sharpen=1&resMode=bilin&id=21SSf3&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 23,
    "productName" : "Ahava Mineral Botanic 17-Ounce Wash in Hibiscus and Fig",
    "rating" : 4.51
  }, {
    "id" : "fc5f6a2a-16a3-11e5-8cfe-3373ba9a5ae3",
    "category" : 9,
    "description" : "Ideal for vacationers, staycationers, honeymooners, or anyone who needs an oasis experience, this bath and body gift box brims with tropical delight including Mango Papaya Lotion, Coconut Milk Sugar Scrub and Sea Glass Shower Gel.",
    "discount" : 0.16,
    "partNo" : "41996478",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/31854341996478p?qlt=85,1&op_sharpen=1&resMode=bilin&id=druSJ3&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 55.99,
    "productName" : "B. Witching Bath Co. Tropical Oasis Bath & Body Gift Box",
    "rating" : 4.83
  }, {
    "id" : "fc64733a-16a3-11e5-a67b-cb9cbc2c2f9b",
    "category" : 9,
    "description" : "This velvety cream wash feels more like a soft, moisturizing body lotion than a typical liquid soap.",
    "discount" : 0.18,
    "partNo" : "18310597",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/18994418310597p?qlt=85,1&op_sharpen=1&resMode=bilin&id=fiySz0&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 23,
    "productName" : "Ahava Mineral Botanic 17-Ounce Wash in Lotus and Chestnut",
    "rating" : 4.97
  }, {
    "id" : "fc692e2a-16a3-11e5-998f-6f805416f471",
    "category" : 10,
    "description" : "A great addition to any bathroom, towels feel extremely soft against your skin. They\\\'re also absorbent and durable for years of use.",
    "discount" : 0.13,
    "partNo" : "129575",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/262528129575c?qlt=85,1&op_sharpen=1&resMode=bilin&id=0I3TR2&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 29.99,
    "productName" : "Turkish Ribbed Bath Towels, 100 percent Cotton",
    "rating" : 4.33
  }, {
    "id" : "fc6e5e4a-16a3-11e5-ad12-7965af13f89c",
    "category" : 10,
    "description" : "Luxurious comfort for the modern home, the Kenneth Cole Reaction Home Towel Collection is uniquely designed from combed cotton for a super plush look and sumptuously soft feel. These long-lasting towels are finished with a contemporary textured trim.",
    "discount" : 0.18,
    "partNo" : "204148",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/234645204148c?qlt=85,1&op_sharpen=1&resMode=bilin&id=iKwSB1&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 19.99,
    "productName" : "Kenneth Cole Reaction Home Towel Collection",
    "rating" : 4.55
  }, {
    "id" : "fc72a40a-16a3-11e5-98a3-e118f655b2ee",
    "category" : 10,
    "description" : "Towels and tubmats are made of aero spun technology with plush and luxurious low-twist fine yarns. These welcome additions to your bathroom are super absorbent and boast a plush, but not bulky feel.",
    "discount" : 0.11,
    "partNo" : "128595",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/161349128595c?qlt=85,1&op_sharpen=1&resMode=bilin&id=3_tTH0&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 14.99,
    "productName" : "MicrodryÂ® Cotton Bath Towels",
    "rating" : 4.74
  }, {
    "id" : "fc7710da-16a3-11e5-a21b-8983a1e7d3c5",
    "category" : 10,
    "description" : "Simple, traditional lighting works well with any decor. The Devon Collection from Kathy Ireland HomeÂ® is embodies a timeless design that will have everlasting appeal in your home.",
    "discount" : 0.11,
    "partNo" : "40321998",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/21270140321998p?qlt=85,1&op_sharpen=1&resMode=bilin&id=G8aTt0&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 198.99,
    "productName" : "Kathy Ireland Home Devon Collection 4-Lamp Set",
    "rating" : 4.98
  }, {
    "id" : "fc7b2f8a-16a3-11e5-b251-579fc05351bb",
    "category" : 10,
    "description" : "These stylish, transitional lamps easily blend into a variety of interiors making it easy to beautifully illuminate any room in your home.",
    "discount" : 0.11,
    "partNo" : "40321981",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/21270040321981p?qlt=85,1&op_sharpen=1&resMode=bilin&id=NG0Tv2&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 249.99,
    "productName" : "Kathy Ireland Home The Broadway 3-Lamp Set (1 Floor/2 Table)",
    "rating" : 4.49
  }, {
    "id" : "fc7fc36a-16a3-11e5-8ed7-9528d188cd96",
    "category" : 10,
    "description" : "This dignified lamp set features a faux brown marble accents and a cima gold finish for some upscale flare. Crafted of metal and resin with faux silk fabric soft bell shape, beige shade.",
    "discount" : 0.18,
    "partNo" : "40321974",
    "photos" : [ "http://s7d9.scene7.com/is/image/BedBathandBeyond/21269940321974p?qlt=85,1&op_sharpen=1&resMode=bilin&id=U8QSH1&hei=1198&wid=1198&fmt=png-alpha" ],
    "price" : 158.99,
    "productName" : "Kathy Ireland Home Riviera Table Lamp (Set of 2)",
    "rating" : 4.4
  }, {
    "id" : "9ca9128a-29df-11e5-b7d2-470647beb807",
    "category" : 4,
    "description" : "APS-C 16.3MP X-Trans CMOS II Sensor w/ EXR Processor II Weather Resistant - dust-resistant, water-resistant and -10 DegreeC low-temperature operation. Real Time Viewfinder - 2.36million dot OLED display, and the world\\\'s highest magnification ratio of 0.77x* Real Time Viewfinder Classic Chrome - A sixth choice has been added to Film Simulation, which gives a unique luster and depth to photos. High-speed 1/32000sec electronic shutter",
    "discount" : 0.12,
    "partNo" : "16421452",
    "photos" : [ "http://ecx.images-amazon.com/images/I/91ogjUlLaOL._SL1500_.jpg", "http://ecx.images-amazon.com/images/I/81OtZSYOwXL._SL1500_.jpg" ],
    "price" : 1148,
    "productName" : "Fujifilm X-T1 16 MP Mirrorless Digital Camera",
    "rating" : 4.41
  } ]';
  
  
  
system "curl -X POST '$baseURL/products?$urlParameters' -d \$'$data'";

print "\nBuild Rules Collection\n\n";

# Rules
$data = '[
	{
        "notificationType": "RelevantNewProducts",
        "productId": "9ca9128a-29df-11e5-b7d2-470647beb807",
        "scoreValue": 5,
        "targetCollection": "products",
        "targetId": "fbb08c8a-16a3-11e5-9bb0-0bc2e2be30b9"
    },
    {
        "notificationType": "RelevantNewProducts",
        "productId": "9ca9128a-29df-11e5-b7d2-470647beb807",
        "scoreValue": 7,
        "targetCollection": "products",
        "targetId": "fbb6a70a-16a3-11e5-953b-fb625fed5dbf"
    },
    {
        "notificationType": "RelevantNewProducts",
        "productId": "9ca9128a-29df-11e5-b7d2-470647beb807",
        "scoreValue": 2,
        "targetCollection": "products",
        "targetId": "fbbbb01a-16a3-11e5-a23a-639d1c1aee91"
    },
    {
        "notificationType": "RelevantNewProducts",
        "productId": "9ca9128a-29df-11e5-b7d2-470647beb807",
        "scoreValue": 6,
        "targetCollection": "products",
        "targetId": "fbc1556a-16a3-11e5-ae2e-eb230f9ff07d"
    },
    {
        "notificationType": "RelevantNewProducts",
        "productId": "fc7fc36a-16a3-11e5-8ed7-9528d188cd96",
        "scoreValue": 6,
        "targetCollection": "products",
        "targetId": "fc7b2f8a-16a3-11e5-b251-579fc05351bb"
    },
    {
        "notificationType": "RelevantNewProducts",
        "productId": "fc7fc36a-16a3-11e5-8ed7-9528d188cd96",
        "scoreValue": 10,
        "targetCollection": "products",
        "targetId": "fc7710da-16a3-11e5-a21b-8983a1e7d3c5"
    },
    {
        "notificationType": "RelevantNewProducts",
        "productId": "fc7b2f8a-16a3-11e5-b251-579fc05351bb",
        "scoreValue": 6,
        "targetCollection": "products",
        "targetId": "fc7fc36a-16a3-11e5-8ed7-9528d188cd96"
    },
    {
        "notificationType": "RelevantNewProducts",
        "productId": "fc7710da-16a3-11e5-a21b-8983a1e7d3c5",
        "scoreValue": 10,
        "targetCollection": "products",
     	"targetId": "fc7fc36a-16a3-11e5-8ed7-9528d188cd96"
    },
    {
        "notificationType": "RelevantNewProducts",
        "productId": "fc72a40a-16a3-11e5-98a3-e118f655b2ee",
        "scoreValue": 1,
        "targetCollection": "products",
        "targetId": "fb7cab4a-16a3-11e5-8feb-59b2c572b582"
    },
    {
        "notificationType": "RelevantOffers",
        "productId": "9ca9128a-29df-11e5-b7d2-470647beb807",
        "scoreValue": 5,
        "targetCollection": "offers",
        "targetId": "8d38cb8a-3702-11e5-bb69-35bf5c65e8f4"
    },
    {
        "notificationType": "RelevantOffers",
        "productId": "fc7fc36a-16a3-11e5-8ed7-9528d188cd96",
        "scoreValue": 8,
        "targetCollection": "offers",
        "targetId": "37d32eba-16a5-11e5-9d24-79ff6500ce10"
    },
    {
        "notificationType": "RelevantOffers",
        "productId": "fc7fc36a-16a3-11e5-8ed7-9528d188cd96",
        "scoreValue": 4,
        "targetCollection": "offers",
        "targetId": "37d85eda-16a5-11e5-af89-5f218f0cbe01"
    },
    {
        "notificationType": "RelevantOffers",
        "productId": "fc7b2f8a-16a3-11e5-b251-579fc05351bb",
        "scoreValue": 8,
        "targetCollection": "offers",
        "targetId": "37d32eba-16a5-11e5-9d24-79ff6500ce10"
    },
    {
        "notificationType": "RelevantOffers",
        "productId": "fc7b2f8a-16a3-11e5-b251-579fc05351bb",
        "scoreValue": 4,
        "targetCollection": "offers",
        "targetId": "37d85eda-16a5-11e5-af89-5f218f0cbe01"
    },
    {
        "notificationType": "RelevantOffers",
        "productId": "fc7710da-16a3-11e5-a21b-8983a1e7d3c5",
        "scoreValue": 8,
        "targetCollection": "offers",
        "targetId": "37d32eba-16a5-11e5-9d24-79ff6500ce10"
    },
    {
        "notificationType": "RelevantOffers",
        "productId": "fc7710da-16a3-11e5-a21b-8983a1e7d3c5",
        "scoreValue": 4,
        "targetCollection": "offers",
        "targetId": "37d85eda-16a5-11e5-af89-5f218f0cbe01"
    },
    {
        "notificationType": "RelevantOffers",
        "productId": "fc72a40a-16a3-11e5-98a3-e118f655b2ee",
        "scoreValue": 5,
        "targetCollection": "offers",
        "targetId": "37d85eda-16a5-11e5-af89-5f218f0cbe01"
    },
    {
        "notificationType": "RelevantOffers",
        "productId": "fc72a40a-16a3-11e5-98a3-e118f655b2ee",
        "scoreValue": 5,
        "targetCollection": "offers",
        "targetId": "37e249ea-16a5-11e5-b728-5f7d2c4a67ed"
    },
    {
        "notificationType": "RelevantOffers",
        "productId": "fc6e5e4a-16a3-11e5-ad12-7965af13f89c",
        "scoreValue": 5,
        "targetCollection": "offers",
        "targetId": "37d32eba-16a5-11e5-9d24-79ff6500ce10"
    },
    {
        "notificationType": "RelevantReviews",
        "productId": "9ca9128a-29df-11e5-b7d2-470647beb807",
        "scoreValue": 10,
        "targetCollection": "reviews",
        "targetId": "b174889a-3bb2-11e5-b0ce-fddd64235814"
    },
    {
        "notificationType": "RelevantReviews",
        "productId": "9ca9128a-29df-11e5-b7d2-470647beb807",
        "scoreValue": 3,
        "targetCollection": "reviews",
        "targetId": "e3ea4b0a-41ef-11e5-847f-bf08d78cf2e6"
    },
    {
        "notificationType": "RelevantReviews",
        "productId": "fc7fc36a-16a3-11e5-8ed7-9528d188cd96",
        "scoreValue": 5,
        "targetCollection": "reviews",
        "targetId": "e3fdd30a-41ef-11e5-8dbc-0315ab37ba51"
    },
    {
        "notificationType": "RelevantReviews",
        "productId": "fc7b2f8a-16a3-11e5-b251-579fc05351bb",
        "scoreValue": 2,
        "targetCollection": "reviews",
        "targetId": "c63f140a-41ef-11e5-a675-f951529d7f30"
    },
    {
        "notificationType": "RelevantReviews",
        "productId": "fc7710da-16a3-11e5-a21b-8983a1e7d3c5",
        "scoreValue": 8,
        "targetCollection": "reviews",
        "targetId": "78bf368a-41ed-11e5-b01f-af69f1d95add"
    },
    {
        "notificationType": "RelevantReviews",
        "productId": "fc72a40a-16a3-11e5-98a3-e118f655b2ee",
        "scoreValue": 5,
        "targetCollection": "reviews",
        "targetId": "768a7c3a-41ed-11e5-9cb6-4bf1b8e6819a"
    },
    {
        "notificationType": "RelevantReviews",
        "productId": "fc6e5e4a-16a3-11e5-ad12-7965af13f89c",
        "scoreValue": 7,
        "targetCollection": "reviews",
        "targetId": "584eec1a-41ed-11e5-8e11-fdedc9163c70"
    },
    
    {
        "notificationType": "RelevantAccessoriesForNearbyStore",
        "productId": "9ca9128a-29df-11e5-b7d2-470647beb807",
        "scoreValue": 5,
        "targetCollection": "products",
        "targetId": "fbed205a-16a3-11e5-9bcc-7fe22fc2b9f7"
    },
    
    {
        "notificationType": "RelevantAccessoriesForNearbyStore",
        "productId": "9ca9128a-29df-11e5-b7d2-470647beb807",
        "scoreValue": 6,
        "targetCollection": "products",
        "targetId": "fc6e5e4a-16a3-11e5-ad12-7965af13f89c"
    },
    {
        "notificationType": "RelevantAccessoriesForNearbyStore",
        "productId": "fc7fc36a-16a3-11e5-8ed7-9528d188cd96",
        "scoreValue": 5,
        "targetCollection": "products",
        "targetId": "fc6e5e4a-16a3-11e5-ad12-7965af13f89c"
    },
    {
        "notificationType": "RelevantAccessoriesForNearbyStore",
        "productId": "fc7b2f8a-16a3-11e5-b251-579fc05351bb",
        "scoreValue": 5,
        "targetCollection": "products",
        "targetId": "fc6e5e4a-16a3-11e5-ad12-7965af13f89c"
    },
    {
        "notificationType": "RelevantAccessoriesForNearbyStore",
        "productId": "fc7710da-16a3-11e5-a21b-8983a1e7d3c5",
        "scoreValue": 5,
        "targetCollection": "products",
        "targetId": "fbed205a-16a3-11e5-9bcc-7fe22fc2b9f7"
    },
    {
        "notificationType": "RelevantAccessoriesForNearbyStore",
        "productId": "fc72a40a-16a3-11e5-98a3-e118f655b2ee",
        "scoreValue": 7,
        "targetCollection": "products",
        "targetId": "fc692e2a-16a3-11e5-998f-6f805416f471"
    }
]';

system "curl -X POST '$baseURL/rules?$urlParameters' -d '$data'";

print "\nBuild Offers\n\n";

$data = '[
	{
  		"category": "Baby",
  		"color": "94cbb9",
  		"description": "Buy any baby swing from Fisher Price, and receive a free Fisher Price Bouncer. Limit one per customer.",
  		"effective": "2014-08-14",
  		"expiration": "2014-08-9",
  		"id": "37f50e9a-16a5-11e5-9470-51b5688e5b36",
  		"store_id": "b151280a-0d78-11e4-be2f-b7d9e56bc914",
  		"title": "Free Bouncer with Purchase of Fisher Price Swings"
	},
	{
        "id": "37c6ab9a-16a5-11e5-b39e-d9fab7b5be1c",
        "category": "Health",
        "color": "#71a973",
        "description": "Get any men\\\'s grooming product for 30 percent off the retail price for a limited time. Limit 10 items per customer.",
        "effective": "2014-7-1",
        "expiration": "2014-7-31",
        "title": "30 percent Off Men\\\'s Grooming Products"
    },
    {
        "id": "37cd3b4a-16a5-11e5-870a-2b20601e1030",
        "category": "Baby",
        "color": "ffb105",
        "description": "For a limited time, buy any two baby toys for up to 35 dollars each and receive one of equal or lesser value for free!",
        "effective": "2014-11-1",
        "expiration": "2014-12-31",
        "store_id": "b151280a-0d78-11e4-be2f-b7d9e56bc914",
        "title": "Baby Toys - Buy Two, Get One Free"
    },
    {
        "id": "37d32eba-16a5-11e5-9d24-79ff6500ce10",
        "category": "Home",
        "color": "506d7d",
        "description": "All home decor items are on sale for 30 percent off for a limited time. Limit 5 items per customer.",
        "effective": "2014-11-1",
        "expiration": "2014-11-30",
        "store_id": "b151280a-0d78-11e4-be2f-b7d9e56bc914",
        "title": "Home Decor at 40 percent off"
    },
    {
        "id": "37d85eda-16a5-11e5-af89-5f218f0cbe01",
        "category": "Appliances",
        "color": "506d7d",
        "description": "For a limited time, all Kitchenaid appliances are priced at 20 percent off.",
        "effective": "2014-08-01",
        "expiration": "2014-08-31",
        "store_id": "b151280a-0d78-11e4-be2f-b7d9e56bc914",
        "title": "20 percent off Kitchenaid Appliances"
    },
    {
        "id": "37dd8efa-16a5-11e5-b683-1546599e224c",
        "category": "Clothing",
        "color": "f07d65",
        "description": "Spend 50 dollars or more on womens clothing, and we\\\'ll take 5 dollars off your purchase price.",
        "effective": "2014-08-10",
        "expiration": "2014-08-21",
        "store_id": "b151280a-0d78-11e4-be2f-b7d9e56bc914",
        "title": "Womens Clothing at 5 dollars Off"
    },
    {
        "id": "37e249ea-16a5-11e5-b728-5f7d2c4a67ed",
        "category": "Home",
        "color": "506d7d",
        "description": "Spruce up your patio for summer with our patio and garden clearance sale. Items as much as 50 percent off while supplies last.",
        "effective": "2014-10-13",
        "expiration": "2014-10-23",
        "store_id": "b151280a-0d78-11e4-be2f-b7d9e56bc914",
        "title": "Patio and Garden Clearance Sale! 10-50 percent Off"
    },
    {
        "id": "37e5f36a-16a5-11e5-83b4-97f96928af7f",
        "category": "Baby",
        "color": "ffda52",
        "description": "For a limited time, select baby products (including toys and clothing) are available for half off!",
        "effective": "2014-08-01",
        "expiration": "2014-08-31",
        "store_id": "b151280a-0d78-11e4-be2f-b7d9e56bc914",
        "title": "50 percent off on Select Baby products"
    },
    {
        "id": "37f07aba-16a5-11e5-ad7a-4573927a7418",
        "category": "Health",
        "color": "e67259",
        "description": "Save 30 percent on qualifying beauty products while supplies last.",
        "effective": "2014-08-10",
        "expiration": "2014-08-17",
        "store_id": "b151280a-0d78-11e4-be2f-b7d9e56bc914",
        "title": "30 percent off on Select Beauty Products"
    },
    {
        "id": "8d38cb8a-3702-11e5-bb69-35bf5c65e8f4",
        "category": "Camera",
        "color": "#71a973",
        "description": "Free Shipping on all Cameras.",
        "effective": "2014-7-1",
        "expiration": "2014-7-31",
        "title": "Free Shipping on all Cameras"
    }
]';

system "curl -X POST '$baseURL/offers?$urlParameters' -d '$data'";

print "\nBuild Reviews\n\n";

$data = '[
	{
		"id": "b174889a-3bb2-11e5-b0ce-fddd64235814",
		"productId": "9ca9128a-29df-11e5-b7d2-470647beb807",
		"title": "Great Camera!",
		"description": "worked great on vacation",
		"stars": 5
	},
	{
		"id": "e3ea4b0a-41ef-11e5-847f-bf08d78cf2e6",
		"productId": "9ca9128a-29df-11e5-b7d2-470647beb807",
		"title": "broken",
		"description": "the camera broke after 5 minutes",
		"stars": 1
	},
	{
		"id": "e3fdd30a-41ef-11e5-8dbc-0315ab37ba51",
		"productId": "fc7fc36a-16a3-11e5-8ed7-9528d188cd96",
		"title": "looks ok!",
		"description": "",
		"stars": 3
	},
	{
		"id": "c63f140a-41ef-11e5-a675-f951529d7f30",
		"productId": "fc7b2f8a-16a3-11e5-b251-579fc05351bb",
		"title": "looks great!",
		"description": "perfect for my living room",
		"stars": 5
	},
	{
		"id": "78bf368a-41ed-11e5-b01f-af69f1d95add",
		"productId": "fc7710da-16a3-11e5-a21b-8983a1e7d3c5",
		"title": "looks great!",
		"description": "perfect for my living room",
		"stars": 5
	},
	{
		"id": "768a7c3a-41ed-11e5-9cb6-4bf1b8e6819a",
		"productId": "fc72a40a-16a3-11e5-98a3-e118f655b2ee",
		"title": "looks great!",
		"description": "perfect for my bathroom",
		"stars": 5
	},
	{
		"id": "584eec1a-41ed-11e5-8e11-fdedc9163c70",
		"productId": "fc6e5e4a-16a3-11e5-ad12-7965af13f89c",
		"title": "very soft",
		"description": "still have them",
		"stars": 5
	}
]';

system "curl -X POST '$baseURL/offers?$urlParameters' -d '$data'";

print "\n";


