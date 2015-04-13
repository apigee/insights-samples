Data Examples
=============

These datasets 

Samples Included
----------------

Catalogs

- Customer Service
- Financial

Setting Up
----------

# Download the datasets
# Import datasets into Insights

Schemas
-------

These are the schemas of the sample datasets.

### CustomerService Catalog

The datasets in this catalog describe activities around customer service. This includes interactions over the telephone and through chat, as well as contact with customers through surveys.

#### Call

<table>
    <tr>
        <th>Column</th>
        <th>Data Type</th>
        <th>Notes</th>
    </tr>
    <tr>
        <td>CustomerID</td>
        <td>String</td>
        <td>user</td>
    </tr>
    <tr>
        <td>TStart</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Dataset</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>AgentID</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>SessionStartDate</td>
        <td>date &lt;yyyy-MM-dd HH:mm:ss></td>
        <td>timestamp</td>
    </tr>
    <tr>
        <td>Duration</td>
        <td>Integer</td>
        <td></td>
    </tr>
    <tr>
        <td>Category</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>CallInTime</td>
        <td>String</td>
        <td></td>
    </tr>
</table>

#### Chat

<table>
    <tr>
        <th>Column</th>
        <th>Data Type</th>
        <th>Notes</th>
    </tr>
    <tr>
        <td>CustomerID</td>
        <td>String</td>
        <td>user</td>
    </tr>
    <tr>
        <td>TStart</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Dataset</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>RepID</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>SessionStartDate</td>
        <td>date &lt;yyyy-MM-dd HH:mm:ss></td>
        <td>timestamp</td>
    </tr>
    <tr>
        <td>Duration</td>
        <td>Integer</td>
        <td></td>
    </tr>
    <tr>
        <td>Category</td>
        <td>String</td>
        <td></td>
    </tr>
</table>

#### Customer

<table>
    <tr>
        <th>Column</th>
        <th>Data Type</th>
        <th>Notes</th>
    </tr>
    <tr>
        <td>CustomerID</td>
        <td>String</td>
        <td>user</td>
    </tr>
    <tr>
        <td>ESTBDate</td>
        <td>date &lt;yyyy-MM-dd HH:mm:ss></td>
        <td>timestamp</td>
    </tr>
    <tr>
        <td>ContractExpDate</td>
        <td>date &lt;yyyy-MM-dd HH:mm:ss></td>
        <td>timestamp</td>
    </tr>
    <tr>
        <td>UpgradeEligibleDate</td>
        <td>date &lt;yyyy-MM-dd HH:mm:ss></td>
        <td>timestamp</td>
    </tr>
    <tr>
        <td>OSType</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>CustomerName</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Address</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>City</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>State</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Zip</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Phone</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>RatePlan</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>RatePlan</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>AvgMin</td>
        <td>Integer</td>
        <td></td>
    </tr>
    <tr>
        <td>AvgData</td>
        <td>Integer</td>
        <td></td>
    </tr>
    <tr>
        <td>NavigationSubscrFlg</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>ChildMonitorSubscFlg</td>
        <td>String</td>
        <td></td>
    </tr>
</table>

#### SurveyCall

<table>
    <tr>
        <th>Column</th>
        <th>Data Type</th>
        <th>Notes</th>
    </tr>
    <tr>
        <td>SurveyDate</td>
        <td>date &lt;yyyy-MM-dd HH:mm:ss></td>
        <td>timestamp</td>
    </tr>
    <tr>
        <td>CustomerID</td>
        <td>String</td>
        <td>user</td>
    </tr>
    <tr>
        <td>Channel</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>RepID</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>NPSScore</td>
        <td>Integer</td>
        <td></td>
    </tr>
    <tr>
        <td>RepKnowledge</td>
        <td>Integer</td>
        <td></td>
    </tr>
    <tr>
        <td>RepProfessionalism</td>
        <td>Integer</td>
        <td></td>
    </tr>
    <tr>
        <td>RepResolution</td>
        <td>Integer</td>
        <td></td>
    </tr>
</table>

#### SurveyChat

<table>
    <tr>
        <th>Column</th>
        <th>Data Type</th>
        <th>Notes</th>
    </tr>
    <tr>
        <td>SurveyDate</td>
        <td>date &lt;yyyy-MM-dd HH:mm:ss></td>
        <td>timestamp</td>
    </tr>
    <tr>
        <td>CustomerID</td>
        <td>String</td>
        <td>user</td>
    </tr>
    <tr>
        <td>Channel</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>RepID</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>NPSScore</td>
        <td>Integer</td>
        <td></td>
    </tr>
    <tr>
        <td>RepKnowledge</td>
        <td>Integer</td>
        <td></td>
    </tr>
    <tr>
        <td>RepProfessionalism</td>
        <td>Integer</td>
        <td></td>
    </tr>
    <tr>
        <td>RepResolution</td>
        <td>Integer</td>
        <td></td>
    </tr>
</table>

### Financial Catalog

The Financial catalog datasets describe user activity with a financial institution. This includes transfers and stock trades. 

#### Account

<table>
    <tr>
        <th>Column</th>
        <th>Data Type</th>
        <th>Notes</th>
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
        <th>Notes</th>
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
        <th>Notes</th>
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
        <th>Notes</th>
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
        <th>Notes</th>
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

