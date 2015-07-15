# Data Examples

The datasets in this directory are provided for you to use when experimenting with Insights. You can import the datasets to Insights, then use them to create journeys or predictve models.

## Catalogs Included

- Financial -- Datasets that describe user activity with a financial institution. This includes transfers and stock trades.

## Setting Up

Each tarball contains datasets for a different catalog (the Insights way to group related datasets). To use the data in journeys and models, you first import it into your Insights organization.

1. Download and untar the sample files. You'll end up with a catalog directory for each containing multiple datasets.
2. In a web browser, go to the Insights console to import the datasets.
3. Click the Data tab and follow UI guidance to import each dataset for a catalog.

For more information, see the [documentation about importing data](http://apigee.com/docs/insights/content/importing-data-data-browser).

## Dataset Schemas

### Financial Catalog

The Financial catalog datasets describe user activity with a financial institution. This includes transfers and stock trades. 

#### Suggested Uses

- Predict account closures. Once you've imported the data, try the [closure predict model](https://github.com/apigee/insights-samples/blob/master/models/closure-predict-model.R) to predict how likely it is users will close accounts.


#### Account

<table>
    <tr>
        <th>Column</th>
        <th>Data Type</th>
        <th>Tag</th>
    </tr>
    <tr>
        <td>UserID</td>
        <td>String</td>
        <td>user</td>
    </tr>
    <tr>
        <td>Time</td>
        <td>date &lt;yyyy-MM-dd HH:mm:ss></td>
        <td>timestamp</td>
    </tr>
    <tr>
        <td>Type</td>
        <td>String</td>
        <td></td>
    </tr>
</table>

#### News

<table>
    <tr>
        <th>Column</th>
        <th>Data Type</th>
        <th>Tag</th>
    </tr>
    <tr>
        <td>UserID</td>
        <td>String</td>
        <td>user</td>
    </tr>
    <tr>
        <td>Time</td>
        <td>date &lt;yyyy-MM-dd HH:mm:ss></td>
        <td>timestamp</td>
    </tr>
    <tr>
        <td>Type</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Stock</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Category</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>MarketCap</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>DividendYield</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>RelativeValuation</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Volume</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>InterestCoverage</td>
        <td>String</td>
        <td></td>
    </tr>
</table>

#### Purchase

<table>
    <tr>
        <th>Column</th>
        <th>Data Type</th>
        <th>Tag</th>
    </tr>
    <tr>
        <td>UserID</td>
        <td>String</td>
        <td>user</td>
    </tr>
    <tr>
        <td>Time</td>
        <td>date &lt;yyyy-MM-dd HH:mm:ss></td>
        <td>timestamp</td>
    </tr>
    <tr>
        <td>Type</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Stock</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Category</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>MarketCap</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>DividendYield</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>RelativeValuation</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Volume</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>InterestCoverage</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>PurchaseAmt</td>
        <td>int</td>
        <td></td>
    </tr>
</table>

#### Transfer

<table>
    <tr>
        <th>Column</th>
        <th>Data Type</th>
        <th>Tag</th>
    </tr>
    <tr>
        <td>UserID</td>
        <td>String</td>
        <td>user</td>
    </tr>
    <tr>
        <td>Time</td>
        <td>date &lt;yyyy-MM-dd HH:mm:ss></td>
        <td>timestamp</td>
    </tr>
    <tr>
        <td>Type</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>TransferAmount</td>
        <td>int</td>
        <td></td>
    </tr>
</table>

#### User

<table>
    <tr>
        <th>Column</th>
        <th>Data Type</th>
        <th>Tag</th>
    </tr>
    <tr>
        <td>UserID</td>
        <td>String</td>
        <td>user</td>
    </tr>
    <tr>
        <td>Age</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Gender</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>DownloadedMobileApp</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>HouseholdCompositionExperian</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>IncomeModelExperian</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>LengthofResidenceExperian</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>MHPMortgageAmountExperian</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>NumOfChildrenInLivingUnitExperian</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Person1MaritalStatusExperian</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>SubscribedToEmails</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>ZipCodeExperian</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>RiskProfile</td>
        <td>String</td>
        <td></td>
    </tr>
</table>

