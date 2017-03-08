<?php
require "./models/gridDataSource.php";
class gridData extends gridDataSource{
protected $tableName = "customerinformation";
protected $gridFields =["CustomerID","CustomerTypeID","CustomerName","CustomerLogin","CustomerPassword"];
public $dashboardTitle ="Customer Information";
public $breadCrumbTitle ="Customer Information";
public $idField ="CustomerID";
public $editCategories = [
"Main" => [

"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerFirstName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerLastName" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerSalutation" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerAddress3" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerState" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerCountry" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerPhone" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerFax" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerEmail" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerWebPage" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerLogin" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerPassword" => [
"inputType" => "text",
"defaultValue" => ""
],
"Attention" => [
"inputType" => "text",
"defaultValue" => ""
],
"TaxIDNo" => [
"inputType" => "text",
"defaultValue" => ""
]
]
"Info" => [

"TermsStart" => [
"inputType" => "text",
"defaultValue" => ""
],
"PriceMatrix" => [
"inputType" => "text",
"defaultValue" => ""
],
"PriceMatrixCurrent" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditRating" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditLimit" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditComments" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentDay" => [
"inputType" => "text",
"defaultValue" => ""
],
"ApprovalDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerSince" => [
"inputType" => "text",
"defaultValue" => ""
],
"StatementCycleCode" => [
"inputType" => "text",
"defaultValue" => ""
],
"CustomerSpecialInstructions" => [
"inputType" => "text",
"defaultValue" => ""
]
]
"Ship" => [

"RoutingInfo1" => [
"inputType" => "text",
"defaultValue" => ""
],
"RoutingInfo2" => [
"inputType" => "text",
"defaultValue" => ""
],
"RoutingInfo3" => [
"inputType" => "text",
"defaultValue" => ""
],
"RoutingInfoCurrent" => [
"inputType" => "text",
"defaultValue" => ""
],
"FreightPayment" => [
"inputType" => "text",
"defaultValue" => ""
],
"SpecialShippingInstructions" => [
"inputType" => "text",
"defaultValue" => ""
],
"RoutingNotes" => [
"inputType" => "text",
"defaultValue" => ""
]
]
"Allowance" => [

"RebateAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"RebateAmountNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"NewStoreDiscount" => [
"inputType" => "text",
"defaultValue" => ""
],
"NewStoreDiscountNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseAllowance" => [
"inputType" => "text",
"defaultValue" => ""
],
"WarehouseAllowanceNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"AdvertisingDiscount" => [
"inputType" => "text",
"defaultValue" => ""
],
"AdvertisingDiscountNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"ManualAdvertising" => [
"inputType" => "text",
"defaultValue" => ""
],
"ManualAdvertisingNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"TradeDiscount" => [
"inputType" => "text",
"defaultValue" => ""
],
"TradeDiscountNotes" => [
"inputType" => "text",
"defaultValue" => ""
],
"SpecialTerms" => [
"inputType" => "text",
"defaultValue" => ""
]
]
"EDI" => [

"EDIQualifier" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDITestQualifier" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDITestID" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIContactName" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIContactAgentFax" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIContactAgentPhone" => [
"inputType" => "text",
"defaultValue" => ""
],
"EDIContactAddressLine" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToAddress3" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToState" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipToZip" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForAddress1" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForAddress2" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForAddress3" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForCity" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForState" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipForZip" => [
"inputType" => "text",
"defaultValue" => ""
]
]
"Financials" => [

"CustomerID" => [
"inputType" => "text",
"defaultValue" => ""
],
"BookedOrders" => [
"inputType" => "text",
"defaultValue" => ""
],
"AvailibleCredit" => [
"inputType" => "text",
"defaultValue" => ""
],
"AverageDaytoPay" => [
"inputType" => "text",
"defaultValue" => ""
],
"LateDays" => [
"inputType" => "text",
"defaultValue" => ""
],
"LastPaymentDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"LastPaymentAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"PromptPerc" => [
"inputType" => "text",
"defaultValue" => ""
],
"HighestCredit" => [
"inputType" => "text",
"defaultValue" => ""
],
"HighestBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"AdvertisingDollars" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrentARBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"TotalAR" => [
"inputType" => "text",
"defaultValue" => ""
],
"Under30" => [
"inputType" => "text",
"defaultValue" => ""
],
"Over30" => [
"inputType" => "text",
"defaultValue" => ""
],
"Over60" => [
"inputType" => "text",
"defaultValue" => ""
],
"Over90" => [
"inputType" => "text",
"defaultValue" => ""
],
"Over120" => [
"inputType" => "text",
"defaultValue" => ""
],
"Over150" => [
"inputType" => "text",
"defaultValue" => ""
],
"Over180" => [
"inputType" => "text",
"defaultValue" => ""
],
"LastSalesDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"SalesYTD" => [
"inputType" => "text",
"defaultValue" => ""
],
"SalesLastYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"SalesLifetime" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentsYTD" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentsLastYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"PaymentsLifetime" => [
"inputType" => "text",
"defaultValue" => ""
],
"WriteOffsYTD" => [
"inputType" => "text",
"defaultValue" => ""
],
"WriteOffsLastYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"WriteOffsLifetime" => [
"inputType" => "text",
"defaultValue" => ""
],
"InvoicesYTD" => [
"inputType" => "text",
"defaultValue" => ""
],
"InvoicesLastYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"InvoicesLifetime" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditMemos" => [
"inputType" => "text",
"defaultValue" => ""
],
"LastCreditMemoDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditMemosYTD" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditMemosLastYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"CreditMemosLifetime" => [
"inputType" => "text",
"defaultValue" => ""
],
"RMAs" => [
"inputType" => "text",
"defaultValue" => ""
],
"LastRMADate" => [
"inputType" => "text",
"defaultValue" => ""
],
"RMAsYTD" => [
"inputType" => "text",
"defaultValue" => ""
],
"RMAsLastYear" => [
"inputType" => "text",
"defaultValue" => ""
],
"RMAsLifetime" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceName" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceSoldSince" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceLastSale" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceHighCredit" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceCurrentBalance" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferencePastDue" => [
"inputType" => "text",
"defaultValue" => ""
],
"ReferenceLateDays" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommentLineID" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommentDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"CommentType" => [
"inputType" => "text",
"defaultValue" => ""
],
"Comment" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionType" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionNumber" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"TransactionAmount" => [
"inputType" => "text",
"defaultValue" => ""
],
"CurrencyID" => [
"inputType" => "text",
"defaultValue" => ""
],
"ShipDate" => [
"inputType" => "text",
"defaultValue" => ""
],
"TrackingNumber" => [
"inputType" => "text",
"defaultValue" => ""
]
]];
public $columnNames = [

"CustomerID" => "Customer ID",
"CustomerTypeID" => "Customer Type ID",
"CustomerName" => "Customer Name",
"CustomerLogin" => "Customer Login",
"CustomerPassword" => "Customer Password",
"CustomerFirstName" => "Customer First Name",
"CustomerLastName" => "Customer Last Name",
"CustomerSalutation" => "Customer Salutation",
"CustomerAddress1" => "Customer Address 1",
"CustomerAddress2" => "Customer Address 2",
"CustomerAddress3" => "Customer Address 3",
"CustomerCity" => "Customer City",
"CustomerState" => "Customer State",
"CustomerZip" => "Customer Zip",
"CustomerCountry" => "Customer Country",
"CustomerPhone" => "Customer Phone",
"CustomerFax" => "Customer Fax",
"CustomerEmail" => "Customer Email",
"CustomerWebPage" => "Customer Web Page",
"Attention" => "Attention",
"TaxIDNo" => "Tax ID Number",
"TermsStart" => "Terms Start",
"PriceMatrix" => "Price Matrix",
"PriceMatrixCurrent" => "Price Matrix Current",
"CreditRating" => "Credit Rating",
"CreditLimit" => "Credit Limit",
"CreditComments" => "Credit Comments",
"PaymentDay" => "Payment Day",
"ApprovalDate" => "Approval Date",
"CustomerSince" => "Customer Since",
"StatementCycleCode" => "Statement Cycle Code",
"CustomerSpecialInstructions" => "Customer Special Instructions",
"RoutingInfo1" => "Routing Info 1",
"RoutingInfo2" => "Routing Info 2",
"RoutingInfo3" => "Routing Info 3",
"RoutingInfoCurrent" => "Routing Info Current",
"FreightPayment" => "Freight Payment",
"SpecialShippingInstructions" => "Special Shipping Instructions",
"RoutingNotes" => "Routing Notes",
"RebateAmount" => "Rebate Amount",
"RebateAmountNotes" => "Rebate Amount Notes",
"NewStoreDiscount" => "New Store Discount",
"NewStoreDiscountNotes" => "New Store Discount Notes",
"WarehouseAllowance" => "Warehouse Allowance",
"WarehouseAllowanceNotes" => "Warehouse Allowance Notes",
"AdvertisingDiscount" => "Advertising Discount",
"AdvertisingDiscountNotes" => "Advertising Discount Notes",
"ManualAdvertising" => "Manual Advertising",
"ManualAdvertisingNotes" => "Manual Advertising Notes",
"TradeDiscount" => "Trade Discount",
"TradeDiscountNotes" => "Trade Discount Notes",
"SpecialTerms" => "Special Terms",
"EDIQualifier" => "EDI Qualifier",
"EDIID" => "EDI ID",
"EDITestQualifier" => "EDI Test Qualifier",
"EDITestID" => "EDI Test ID",
"EDIContactName" => "EDI Contact Name",
"EDIContactAgentFax" => "EDI Contact Agent Fax",
"EDIContactAgentPhone" => "EDI Contact Agent Phone",
"EDIContactAddressLine" => "EDI Contact Address Line",
"ShipToID" => "Ship To ID",
"ShipToName" => "Name",
"ShipToAddress1" => "Address 1",
"ShipToAddress2" => "Address 2",
"ShipToAddress3" => "Address 3",
"ShipToCity" => "City",
"ShipToState" => "State",
"ShipToZip" => "Zip",
"ShipForID" => "Ship For ID",
"ShipForName" => "Name",
"ShipForAddress1" => "Address 1",
"ShipForAddress2" => "Address 2",
"ShipForAddress3" => "Address 3",
"ShipForCity" => "City",
"ShipForState" => "State",
"ShipForZip" => "Zip",
"BookedOrders" => "Booked Orders",
"AvailibleCredit" => "Available Credit",
"AverageDaytoPay" => "Average Days",
"LateDays" => "Late Days",
"LastPaymentDate" => "Last Payment Date",
"LastPaymentAmount" => "Last Payment Amount",
"PromptPerc" => "Prompt Perc",
"HighestCredit" => "Highest Credit",
"HighestBalance" => "Highest Balance",
"AdvertisingDollars" => "Advertising Dollars",
"CurrentARBalance" => "Current AR Balance",
"TotalAR" => "Total AR",
"Under30" => "Under 30",
"Over30" => "Over 30",
"Over60" => "Over 60",
"Over90" => "Over 90",
"Over120" => "Over 120",
"Over150" => "Over 150",
"Over180" => "Over 180",
"LastSalesDate" => "Last Sales Date",
"SalesYTD" => "Sales YTD",
"SalesLastYear" => "Sales Last Year",
"SalesLifetime" => "Sales Lifetime",
"PaymentsYTD" => "Payments YTD",
"PaymentsLastYear" => "Payments Last Year",
"PaymentsLifetime" => "Payments Lifetime",
"WriteOffsYTD" => "Write Offs YTD",
"WriteOffsLastYear" => "Write Offs Last Year",
"WriteOffsLifetime" => "Write Offs Lifetime",
"InvoicesYTD" => "Invoices YTD",
"InvoicesLastYear" => "Invoices Las tYear",
"InvoicesLifetime" => "Invoices Lifetime",
"CreditMemos" => "Credit Memos",
"LastCreditMemoDate" => "Last Credit Memo Date",
"CreditMemosYTD" => "Credit Memos YTD",
"CreditMemosLastYear" => "Credit Memos Last Year",
"CreditMemosLifetime" => "Credit Memos Lifetime",
"RMAs" => "RMAs",
"LastRMADate" => "Last RMA Date",
"RMAsYTD" => "RMAs YTD",
"RMAsLastYear" => "RMAs Last Year",
"RMAsLifetime" => "RMAs Lifetime",
"ReferenceID" => "Reference ID",
"ReferenceName" => "Name",
"ReferenceDate" => "Date",
"ReferenceSoldSince" => "Sold Since",
"ReferenceLastSale" => "Last Sale",
"ReferenceHighCredit" => "High Credit",
"ReferenceCurrentBalance" => "Current Balance",
"ReferencePastDue" => "Past Due",
"ReferenceLateDays" => "Late Days",
"CommentLineID" => "Line ID",
"CommentDate" => "Date",
"CommentType" => "Type",
"Comment" => "Comment",
"TransactionType" => "Transaction Type",
"TransactionNumber" => "Transaction Number",
"TransactionDate" => "Transaction Date",
"TransactionAmount" => "Transaction Amount",
"CurrencyID" => "Currency ID",
"ShipDate" => "Ship Date",
"TrackingNumber" => "Tracking Number"];
}?>
