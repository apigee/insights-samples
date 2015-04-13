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

These are the schemas of the datasets included here.

### Financial Dataset

#### Account

<table>
    <tr>
        <td>UserID</td>
        <td>Time</td>
        <td>Type</td>
    </tr>
    <tr>
        <td>String</td>
        <td>date &lt;yyyy-MM-dd HH:mm:ss></td>
        <td>String</td>
    </tr>
    <tr>
        <td>user</td>
        <td>timestamp</td>
        <td> </td>
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
        <td>Downloaded_Mobile_App</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Household_Composition_Experian</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Income_Model_est_HH_code_SCS_v4_Experian</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Length_of_Residence_Experian</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>MHP_Mortgage_Amount_Experian</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Num_of_Children_in_Living_Unit_Experian</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Person_1_Marital_Status_Experian</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Subscribed_to_emails</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Zip_Code_Experian</td>
        <td>String</td>
        <td></td>
    </tr>
    <tr>
        <td>Risk_Profile</td>
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
