<div id="row_editor" class="row">
		       
    <?php
		       $public_prefix = '';
	$reportTypes = [
	    "Information" => ["label" => $translation->translateLabel("Information"),
			      "link" => $public_prefix . "/index#/autoreports/RptListCustomerInformation?id=1202975512&title=Customer Information",
			      "reportName" => "RptListCustomerInformation",
			      "params" => '',
			      "columns" => ''],

	    "Credit References" => ["label" => $translation->translateLabel("Credit References"),
				    "link" => $public_prefix . "/index#/autoreports/RptListCustomerCreditReferences?id=1170975398&title=Customer Credit References",
				    "reportName" => "RptListCustomerCreditReferences",
				    "params" => '',
				    "columns" => ''],

	    "Ship For Locations" => ["label" => $translation->translateLabel("Ship For Locations"),
				     "link" => $public_prefix . "/index#/autoreports/RptListCustomerShipForLocations?id=1250975683&title=Customer Ship For Locations",
				     "reportName" => "RptListCustomerShipForLocations",
				     "params" => '',
				     "columns" => ''],

	    "Ship To Locations" => ["label" => $translation->translateLabel("Ship To Locations"),
				    "link" => $public_prefix . "/index#/autoreports/RptListCustomerShipToLocations?id=1266975740&title=Customer Ship To Locations",
				    "reportName" => "RptListCustomerShipToLocations",
				    "params" => '',
				    "columns" => ''],

	    "Vehicles" => ["label" => $translation->translateLabel("Vehicles"),    
			   "link" => $public_prefix . "/index#/autoreports/RptListVehiclesHeader?id=77896561&title=Vehicles",
			   "reportName" => "RptListVehiclesHeader",
			   "params" => '',
			   "columns" => ''],

	    "Service Orders" => ["label" => $translation->translateLabel("Service Orders"),
				 "link" => $public_prefix . "/index#/autoreports/RptListServiceOrders?id=190699898&title=Service Orders",
				 "reportName" => "RptListServiceOrders",
				 "params" => '',
				 "columns" => ''],

	    "Order Headers" => ["label" => $translation->translateLabel("Order Headers"),
				"link" => $public_prefix . "/index#/autoreports/RptListOrderHeader?id=1906978020&title=Order Headers",
				"reportName" => "RptListOrderHeader",
				"params" => '',
				"columns" => ''],

	    "Order Detail" => ["label" => $translation->translateLabel("Order Detail"),
			       "link" => $public_prefix . "/index#/autoreports/RptListOrderDetail?id=1890977963&title=Order Detail Items",
			       "reportName" => "RptListOrderDetail",
			       "params" => '',
			       "columns" => ''],

	    "Order Types" => ["label" => $translation->translateLabel("Order Types"),
			      "link" => $public_prefix . "/index#/autoreports/RptListOrderTypes?id=1922978077&title=Order Types",
			      "reportName" => "RptListOrderTypes",
			      "params" => '',
			      "columns" => ''],

	    "Invoice Headers" => ["label" => $translation->translateLabel("Invoice Headers"),
				  "link" => $public_prefix . "/index#/autoreports/RptListInvoiceHeader?id=1698977279&title=Invoice Headers",
				  "reportName" => "RptListInvoiceHeader",
				  "params" => '',
				  "columns" => ''],

	    "Invoice Detail Items" => ["label" => $translation->translateLabel("Invoice Detail Items"),
				       "link" => $public_prefix . "/index#/autoreports/RptListInvoiceDetail?id=1682977222&title=Invoice Detail Items",
				       "reportName" => "RptListInvoiceDetail",
				       "params" => '',
				       "columns" => ''],

	    "Parts" => ["label" => $translation->translateLabel('Parts'),
			"link" => $public_prefix . "/index#/autoreports/RptListParts?id=1554973463&title=Parts",
			"reportName" => "RptListParts",
			"params" => '',
			"columns" => ''],

	    "Inventory By Warehouse" => ["label" => $translation->translateLabel('Inventory By Warehouse'),
					 "link" => $public_prefix . "/index#/autoreports/RptListInventoryByWarehouse?id=1554976766&title=Inventory By Warehouse",
					 "reportName" => "RptListInventoryByWarehouse",
					 "params" => '',
					 "columns" => ''],

	    "Items" => ["label" => $translation->translateLabel('Items'),
			"link" => $public_prefix . "/index#/autoreports/RptListInventoryItems?id=1031323084&title=Items",
			"reportName" => "RptListInventoryItems",
			"params" => '',
			"columns" => ''],

	    "Item Categories" => ["label" => $translation->translateLabel('Item Categories'),
				  "link" => $public_prefix . "/index#/autoreports/RptListInventoryCategories?id=1570976823&title=Item Categories",
				  "reportName" => "RptListInventoryCategories",
				  "params" => '',
				  "columns" => ''],

	    "Item Families" => ["label" => $translation->translateLabel('Item Families'),
				"link" => $public_prefix . "/index#/autoreports/RptListInventoryFamilies?id=1586976880&title=Item Families",
				"reportName" => "RptListInventoryFamilies",
				"params" => '',
				"columns" => ''],

	    "Item Types" => ["label" => $translation->translateLabel('Item Types'),
			     "link" => $public_prefix . "/index#/autoreports/RptListInventoryItemTypes?id=1602976937&title=Item Types",
			     "reportName" => "RptListInventoryItemTypes",
			     "params" => '',
			     "columns" => ''],

	    "Item Pricing Codes" => ["label" => $translation->translateLabel('Item Pricing Codes'),
				     "link" => $public_prefix . "/index#/autoreports/RptListInventoryPricingCode?id=1634977051&title=Item Pricing Codes",
				     "reportName" => "RptListInventoryPricingCode",
				     "params" => '',
				     "columns" => ''],

	    "Item Pricing Methods" => ["label" => $translation->translateLabel('Item Pricing Methods'),
				       "link" => $public_prefix . "/index#/autoreports/RptListInventoryPricingMethods?id=1650977108&title=Item Pricing Methods",
				       "reportName" => "RptListInventoryPricingMethods",
				       "params" => '',
				       "columns" => ''],

	    "Item Serial Numbers" => ["label" => $translation->translateLabel('Item Serial Numbers'),
				      "link" => $public_prefix . "/index#/autoreports/RptListInventorySerialNumbers?id=1666977165&title=Item Serial Numbers",
				      "reportName" => "RptListInventorySerialNumbers",
				      "params" => '',
				      "columns" => ''],

	    "Inventory Assemblies" => ["label" => $translation->translateLabel("Inventory Assemblies"),
				       "link" => $public_prefix . "/index#/autoreports/RptListInventoryAssemblies?id=1538976709&title=Inventory Assemblies",
				       "reportName" => "RptListInventoryAssemblies",
				       "params" => '',
				       "columns" => ''],

	    "Inventory Adjustments" => ["label" => $translation->translateLabel("Inventory Adjustments"),
					"link" => $public_prefix . "/index#/autoreports/RptListInventoryAdjustments?id=1506976595&title=Inventory Adjustments",
					"reportName" => "RptListInventoryAdjustments",
					"params" => '',
					"columns" => ''],

	    "Inventory Adjustments Detail" => ["label" => $translation->translateLabel("Inventory Adjustments Detail"),
					       "link" => $public_prefix . "/index#/autoreports/RptListInventoryAdjustmentsDetail?id=1522976652&title=Inventory Adjustments Detail",
					       "reportName" => "RptListInventoryAdjustmentsDetail",
					       "params" => '',
					       "columns" => ''],

	    "Inventory Adjustment Types" => ["label" => $translation->translateLabel("Inventory Adjustment Types"),
					     "link" => $public_prefix . "/index#/autoreports/RptListInventoryAdjustmentTypes?id=1490976538&title=Inventory Adjustment Types",
					     "reportName" => "RptListInventoryAdjustmentTypes",
					     "params" => '',
					     "columns" => ''],

	    "AR Transaction Types" => ["label" => $translation->translateLabel('AR Transaction Types'),
				       "link"=> $public_prefix . "/index#/autoreports/RptListARTransactionTypes?id=754973916&title=AR Transaction Types",
				       "reportName" => "RptListARTransactionTypes",
				       "params" => '',
				       "columns" => ''],

	    "Contract Headers" => ["label" => $translation->translateLabel('Contract Headers'),
				   "link"=> $public_prefix . "/index#/autoreports/RptListContractsHeader?id=1058974999&title=Contract Headers",
				   "reportName" => "RptListContractsHeader",
				   "params" => '',
				   "columns" => ''],

	    "Contract Detail Items" => ["label" => $translation->translateLabel('Contract Detail Items'),
					"link"=> $public_prefix . "/index#/autoreports/RptListContractsDetail?id=1042974942&title=Contract Detail Items",
					"reportName" => "RptListContractsDetail",
					"params" => '',
					"columns" => ''],

	    "Contract Types" => ["label" => $translation->translateLabel('Contract Types'),
				 "link"=> $public_prefix . "/index#/autoreports/RptListContractTypes?id=1026974885&title=Contract Types",
				 "reportName" => "RptListContractTypes",
				 "params" => '',
				 "columns" => ''],

	    "Contract Email List" => ["label" => $translation->translateLabel('Contract Email List'),
				      "link"=> $public_prefix . "/index#/autoreports/RptListAllContractEmails?id=1569648885&title=Contract Email List",
				      "reportName" => "RptListAllContractEmails",
				      "params" => '',
				      "columns" => ''],

	    "Order Headers" => ["label" => $translation->translateLabel('Order Headers'),
				"link"=> $public_prefix . "/index#/autoreports/RptListOrderHeader?id=1906978020&title=Order Headers",
				"reportName" => "RptListOrderHeader",
				"params" => '',
				"columns" => ''],

	    "Order Detail Items" => ["label" => $translation->translateLabel('Order Detail Items'),
				     "link"=> $public_prefix . "/index#/autoreports/RptListOrderDetail?id=1890977963&title=Order Detail Items",
				     "reportName" => "RptListOrderDetail",
				     "params" => '',
				     "columns" => ''],

	    "Order Types" => ["label" => $translation->translateLabel('Order Types'),
			      "link"=> $public_prefix . "/index#/autoreports/RptListOrderTypes?id=1922978077&title=Order Types",
			      "reportName" => "RptListOrderTypes",
			      "params" => '',
			      "columns" => ''],

	    "Invoice Headers" => ["label" => $translation->translateLabel('Invoice Headers'),
				  "link"=> $public_prefix . "/index#/autoreports/RptListInvoiceHeader?id=1698977279&title=Invoice Headers",
				  "reportName" => "RptListInvoiceHeader",
				  "params" => '',
				  "columns" => ''],

	    "Invoice Detail Items" => ["label" => $translation->translateLabel('Invoice Detail Items'),
				       "link"=> $public_prefix . "/index#/autoreports/RptListInvoiceDetail?id=1682977222&title=Invoice Detail Items",
				       "reportName" => "RptListInvoiceDetail",
				       "params" => '',
				       "columns" => ''],

	    "Receipts Headers" => ["label" => $translation->translateLabel('Receipts Headers'),
				   "link"=> $public_prefix . "/index#/autoreports/RptListReceiptsHeader?id=175495854&title=Receipts Headers",
				   "reportName" => "RptListReceiptsHeader",
				   "params" => '',
				   "columns" => ''],

	    "Receipt Detail Items" => ["label" => $translation->translateLabel('Receipt Detail Items'),
				       "link"=> $public_prefix . "/index#/autoreports/RptListReceiptsDetail?id=159495797&title=Receipt Detail Items",
				       "reportName" => "RptListReceiptsDetail",
				       "params" => '',
				       "columns" => ''],

	    "Receipt Classes" => ["label" => $translation->translateLabel('Receipt Classes'),
				  "link"=> $public_prefix . "/index#/autoreports/RptListReceiptClass?id=127495683&title=Receipt Classes",
				  "reportName" => "RptListReceiptClass",
				  "params" => '',
				  "columns" => ''],

	    "Receipt Types" => ["label" => $translation->translateLabel('Receipt Types'),
				"link"=> $public_prefix . "/index#/autoreports/RptListReceiptTypes?id=143495740&title=Receipt Types",
				"reportName" => "RptListReceiptTypes",
				"params" => '',
				"columns" => ''],

	    "Information" => ["label" => $translation->translateLabel('Information'),
			      "link"=> $public_prefix . "/index#/autoreports/RptListCustomerInformation?id=1202975512&title=Customer Information",
			      "reportName" => "RptListCustomerInformation",
			      "params" => '',
			      "columns" => ''],

	    "Credit References" => ["label" => $translation->translateLabel('Credit References'),
				    "link"=> $public_prefix . "/index#/autoreports/RptListCustomerCreditReferences?id=1170975398&title=Customer Credit References",
				    "reportName" => "RptListCustomerCreditReferences",
				    "params" => '',
				    "columns" => ''],

	    "Ship For Locations" => ["label" => $translation->translateLabel('Ship For Locations'),
				     "link"=> $public_prefix . "/index#/autoreports/RptListCustomerShipForLocations?id=1250975683&title=Customer Ship For Locations",
				     "reportName" => "RptListCustomerShipForLocations",
				     "params" => '',
				     "columns" => ''],

	    "Ship To Locations" => ["label" => $translation->translateLabel('Ship To Locations'),
				    "link"=> $public_prefix . "/index#/autoreports/RptListCustomerShipToLocations?id=1266975740&title=Customer Ship To Locations",
				    "reportName" => "RptListCustomerShipToLocations",
				    "params" => '',
				    "columns" => ''],

	    "Item Cross Reference" => ["label" => $translation->translateLabel('Item Cross Reference'),
				       "link"=> $public_prefix . "/index#/autoreports/RptListCustomerItemCrossReference?id=1218975569&title=Customer Item Cross Reference",
				       "reportName" => "RptListCustomerItemCrossReference",
				       "params" => '',
				       "columns" => ''],

	    "Price Cross Reference" => ["label" => $translation->translateLabel('Price Cross Reference'),
					"link"=> $public_prefix . "/index#/autoreports/RptListCustomerPriceCrossReference?id=1234975626&title=Customer Price Cross Reference",
					"reportName" => "RptListCustomerPriceCrossReference",
					"params" => '',
					"columns" => ''],

	    "Types" => ["label" => $translation->translateLabel('Types'),
			"link"=> $public_prefix . "/index#/autoreports/RptListCustomerTypes?id=1282975797&title=Customer Types",
			"reportName" => "RptListCustomerTypes",
			"params" => '',
			"columns" => ''],

	    "Account Statuses" => ["label" => $translation->translateLabel('Account Statuses'),
				   "link"=> $public_prefix . "/index#/autoreports/RptListCustomerAccountStatuses?id=1106975170&title=Customer Account Statuses",
				   "reportName" => "RptListCustomerAccountStatuses",
				   "params" => '',
				   "columns" => ''],

	    "Comments" => ["label" => $translation->translateLabel('Comments'),
			   "link"=> $public_prefix . "/index#/autoreports/RptListCustomerComments?id=1122975227&title=Customer Comments",
			   "reportName" => "RptListCustomerComments",
			   "params" => '',
			   "columns" => ''],

	    "Contact Log" => ["label" => $translation->translateLabel('Contact Log'),
			      "link"=> $public_prefix . "/index#/autoreports/RptListCustomerContactLog?id=1138975284&title=Customer Contact Log",
			      "reportName" => "RptListCustomerContactLog",
			      "params" => '',
			      "columns" => ''],

	    "Contacts" => ["label" => $translation->translateLabel('Contacts'),
			   "link"=> $public_prefix . "/index#/autoreports/RptListCustomerContacts?id=1154975341&title=Customer Contacts",
			   "reportName" => "RptListCustomerContacts",
			   "params" => '',
			   "columns" => ''],

	    "AP Transaction Types" => ["label" => $translation->translateLabel('AP Transaction Types'),
				       "link"=> $public_prefix . "/index#/autoreports/RptListAPTransactionTypes?id=738973859&title=AP Transaction Types",
				       "reportName" => "RptListAPTransactionTypes",
				       "params" => '',
				       "columns" => ''],

	    "Purchase Headers" => ["label" => $translation->translateLabel('Purchase Headers'),
				   "link"=> $public_prefix . "/index#/autoreports/RptListPurchaseHeader?id=111495626&title=Purchase Headers",
				   "reportName" => "RptListPurchaseHeader",
				   "params" => '',
				   "columns" => ''],

	    "Purchase Detail Items" => ["label" => $translation->translateLabel('Purchase Detail Items'),
					"link"=> $public_prefix . "/index#/autoreports/RptListPurchaseDetail?id=95495569&title=Purchase Detail Items",
					"reportName" => "RptListPurchaseDetail",
					"params" => '',
					"columns" => ''],

	    "Payments Headers" => ["label" => $translation->translateLabel('Payments Headers'),
				   "link"=> $public_prefix . "/index#/autoreports/RptListPaymentsHeader?id=2002978362&title=Payments Headers",
				   "reportName" => "RptListPaymentsHeader",
				   "params" => '',
				   "columns" => ''],

	    "Payment Detail Items" => ["label" => $translation->translateLabel('Payment Detail Items'),
				       "link"=> $public_prefix . "/index#/autoreports/RptListPaymentsDetail?id=1986978305&title=Payment Detail Items",
				       "reportName" => "RptListPaymentsDetail",
				       "params" => '',
				       "columns" => ''],

	    "Payment Types" => ["label" => $translation->translateLabel('Payment Types'),
				"link"=> $public_prefix . "/index#/autoreports/RptListPaymentTypes?id=1970978248&title=Payment Types",
				"reportName" => "RptListPaymentTypes",
				"params" => '',
				"columns" => ''],

	    "Payment Classes" => ["label" => $translation->translateLabel('Payment Classes'),
				  "link"=> $public_prefix . "/index#/autoreports/RptListPaymentClasses?id=1938978134&title=Payment Classes",
				  "reportName" => "RptListPaymentClasses",
				  "params" => '',
				  "columns" => ''],

	    "Payment Methods" => ["label" => $translation->translateLabel('Payment Methods'),
				  "link"=> $public_prefix . "/index#/autoreports/RptListPaymentMethods?id=1954978191&title=Payment Methods",
				  "reportName" => "RptListPaymentMethods",
				  "params" => '',
				  "columns" => ''],

	    "Information" => ["label" => $translation->translateLabel('Information'),
			      "link"=> $public_prefix . "/index#/autoreports/RptListVendorInformation?id=335496424&title=Vendor Information",
			      "reportName" => "RptListVendorInformation",
			      "params" => '',
			      "columns" => ''],

	    "Item Cross Reference" => ["label" => $translation->translateLabel('Item Cross Reference'),
				       "link"=> $public_prefix . "/index#/autoreports/RptListVendorItemCrossReference?id=351496481&title=Vendor Item Cross Reference",
				       "reportName" => "RptListVendorItemCrossReference",
				       "params" => '',
				       "columns" => ''],

	    "Price Cross Reference" => ["label" => $translation->translateLabel('Price Cross Reference'),
					"link"=> $public_prefix . "/index#/autoreports/RptListVendorPriceCrossReference?id=367496538&title=Vendor Price Cross Reference",
					"reportName" => "RptListVendorPriceCrossReference",
					"params" => '',
					"columns" => ''],

	    "Types" => ["label" => $translation->translateLabel('Types'),
			"link"=> $public_prefix . "/index#/autoreports/RptListVendorTypes?id=383496595&title=Vendor Types",
			"reportName" => "RptListVendorTypes",
			"params" => '',
			"columns" => ''],

	    "Account Statuses" => ["label" => $translation->translateLabel('Account Statuses'),
				   "link"=> $public_prefix . "/index#/autoreports/RptListVendorAccountStatuses?id=271496196&title=Vendor Account Statuses",
				   "reportName" => "RptListVendorAccountStatuses",
				   "params" => '',
				   "columns" => ''],

	    "Comments" => ["label" => $translation->translateLabel('Comments'),
			   "link"=> $public_prefix . "/index#/autoreports/RptListVendorComments?id=287496253&title=Vendor Comments",
			   "reportName" => "RptListVendorComments",
			   "params" => '',
			   "columns" => ''],

	    "Contacts" => ["label" => $translation->translateLabel('Contacts'),
			   "link"=> $public_prefix . "/index#/autoreports/RptListVendorContacts?id=303496310&title=Vendor Contacts",
			   "reportName" => "RptListVendorContacts",
			   "params" => '',
			   "columns" => ''],

	    "Chart of Accounts" => ["label" => $translation->translateLabel('Chart of Accounts'),
				    "link"=> $public_prefix . "/index#/autoreports/RptListLedgerChartOfAccounts?id=1810977678&title=Chart of Accounts",
				    "reportName" => "RptListLedgerChartOfAccounts",
				    "params" => '',
				    "columns" => ''],

	    "Ledger Transactions" => ["label" => $translation->translateLabel('Ledger Transactions'),
				      "link"=> $public_prefix . "/index#/autoreports/RptListLedgerTransactions?id=1858977849&title=Ledger Transactions",
				      "reportName" => "RptListLedgerTransactions",
				      "params" => '',
				      "columns" => ''],

	    "Ledger Transaction Details" => ["label" => $translation->translateLabel('Ledger Transaction Details'),
					     "link"=> $public_prefix . "/index#/autoreports/RptListLedgerTransactionsDetail?id=1874977906&title=Ledger Transaction Details",
					     "reportName" => "RptListLedgerTransactionsDetail",
					     "params" => '',
					     "columns" => ''],

	    "Ledger Transaction Types" => ["label" => $translation->translateLabel('Ledger Transaction Types'),
					   "link"=> $public_prefix . "/index#/autoreports/RptListLedgerTransactionTypes?id=1842977792&title=Ledger Transaction Types",
					   "reportName" => "RptListLedgerTransactionTypes",
					   "params" => '',
					   "columns" => ''],

	    "Ledger Account Types" => ["label" => $translation->translateLabel('Ledger Account Types'),
				       "link"=> $public_prefix . "/index#/autoreports/RptListLedgerAccountTypes?id=1778977564&title=Ledger Account Types",
				       "reportName" => "RptListLedgerAccountTypes",
				       "params" => '',
				       "columns" => ''],

	    "Ledger Balance Types" => ["label" => $translation->translateLabel('Ledger Balance Types'),
				       "link"=> $public_prefix . "/index#/autoreports/RptListLedgerBalanceType?id=1794977621&title=Ledger Balance Types",
				       "reportName" => "RptListLedgerBalanceType",
				       "params" => '',
				       "columns" => ''],

	    "Currency Types" => ["label" => $translation->translateLabel('Currency Types'),
				 "link"=> $public_prefix . "/index#/autoreports/RptListCurrencyTypes?id=1090975113&title=Currency Types",
				 "reportName" => "RptListCurrencyTypes",
				 "params" => '',
				 "columns" => ''],

	    "Bank Accounts" => ["label" => $translation->translateLabel('Bank Accounts'),
				"link"=> $public_prefix . "/index#/autoreports/RptListBankAccounts?id=802974087&title=Bank Accounts",
				"reportName" => "RptListBankAccounts",
				"params" => '',
				"columns" => ''],

	    "Bank Transactions" => ["label" => $translation->translateLabel('Bank Transactions'),
				    "link"=> $public_prefix . "/index#/autoreports/RptListBankTransactions?id=914974486&title=Bank Transactions",
				    "reportName" => "RptListBankTransactions",
				    "params" => '',
				    "columns" => ''],

	    "Bank Transaction Types" => ["label" => $translation->translateLabel('Bank Transaction Types'),
					 "link"=> $public_prefix . "/index#/autoreports/RptListBankTransactionTypes?id=898974429&title=Bank Transaction Types",
					 "reportName" => "RptListBankTransactionTypes",
					 "params" => '',
					 "columns" => ''],

	    "Bank Reconcilation" => ["label" => $translation->translateLabel('Bank Reconcilation'),
				     "link"=> $public_prefix . "/index#/autoreports/RptListBankReconciliation?id=818974144&title=Bank Reconcilation",
				     "reportName" => "RptListBankReconciliation",
				     "params" => '',
				     "columns" => ''],

	    "Reconcilation Summary" => ["label" => $translation->translateLabel('Reconcilation Summary'),
					"link"=> $public_prefix . "/index#/autoreports/RptListBankReconciliationSummary?id=882974372&title=Bank Reconcilation Summary",
					"reportName" => "RptListBankReconciliationSummary",
					"params" => '',
					"columns" => ''],

	    "Reconcilation Detail" => ["label" => $translation->translateLabel('Reconcilation Detail'),
				       "link"=> $public_prefix . "/index#/autoreports/RptListBankReconciliationDetail?id=834974201&title=Bank Reconcilation Detail",
				       "reportName" => "RptListBankReconciliationDetail",
				       "params" => '',
				       "columns" => ''],

	    "Reconcilation Credits" => ["label" => $translation->translateLabel('Reconcilation Credits'),
					"link"=> $public_prefix . "/index#/autoreports/RptListBankReconciliationDetailCredits?id=850974258&title=Bank Reconcilation Credits",
					"reportName" => "RptListBankReconciliationDetailCredits",
					"params" => '',
					"columns" => ''],

	    "Reconcilation Debits" => ["label" => $translation->translateLabel('Reconcilation Debits'),
				       "link"=> $public_prefix . "/index#/autoreports/RptListBankReconciliationDetailDebits?id=866974315&title=Bank Reconcilation Debits",
				       "reportName" => "RptListBankReconciliationDetailDebits",
				       "params" => '',
				       "columns" => ''],

	    "Fixed Assets" => ["label" => $translation->translateLabel('Fixed Assets'),
			       "link"=> $public_prefix . "/index#/autoreports/RptListFixedAssets?id=1474976481&title=Fixed Assets",
			       "reportName" => "RptListFixedAssets",
			       "params" => '',
			       "columns" => ''],

	    "Asset Status" => ["label" => $translation->translateLabel('Asset Status'),
			       "link"=> $public_prefix . "/index#/autoreports/RptListFixedAssetStatus?id=1442976367&title=Asset Status",
			       "reportName" => "RptListFixedAssetStatus",
			       "params" => '',
			       "columns" => ''],

	    "Asset Types" => ["label" => $translation->translateLabel('Asset Types'),
			      "link"=> $public_prefix . "/index#/autoreports/RptListFixedAssetType?id=1458976424&title=Asset Types",
			      "reportName" => "RptListFixedAssetType",
			      "params" => '',
			      "columns" => ''],

	    "Depreciation Methods" => ["label" => $translation->translateLabel('Depreciation Methods'),
				       "link"=> $public_prefix . "/index#/autoreports/RptListFixedAssetDepreciationMethods?id=1426976310&title=Depreciation Methods",
				       "reportName" => "RptListFixedAssetDepreciationMethods",
				       "params" => '',
				       "columns" => ''],

	    "Inventory By Warehouse" => ["label" => $translation->translateLabel('Inventory By Warehouse'),
					 "link"=> $public_prefix . "/index#/autoreports/RptListInventoryByWarehouse?id=1554976766&title=Inventory By Warehouse",
					 "reportName" => "RptListInventoryByWarehouse",
					 "params" => '',
					 "columns" => ''],

	    "Items" => ["label" => $translation->translateLabel('Items'),
			"link"=> $public_prefix . "/index#/autoreports/RptListInventoryItems?id=1031323084&title=Items",
			"reportName" => "RptListInventoryItems",
			"params" => '',
			"columns" => ''],

	    "Item Categories" => ["label" => $translation->translateLabel('Item Categories'),
				  "link"=> $public_prefix . "/index#/autoreports/RptListInventoryCategories?id=1570976823&title=Item Categories",
				  "reportName" => "RptListInventoryCategories",
				  "params" => '',
				  "columns" => ''],

	    "Item Families" => ["label" => $translation->translateLabel('Item Families'),
				"link"=> $public_prefix . "/index#/autoreports/RptListInventoryFamilies?id=1586976880&title=Item Families",
				"reportName" => "RptListInventoryFamilies",
				"params" => '',
				"columns" => ''],

	    "Item Types" => ["label" => $translation->translateLabel('Item Types'),
			     "link"=> $public_prefix . "/index#/autoreports/RptListInventoryItemTypes?id=1602976937&title=Item Types",
			     "reportName" => "RptListInventoryItemTypes",
			     "params" => '',
			     "columns" => ''],

	    "Item Pricing Codes" => ["label" => $translation->translateLabel('Item Pricing Codes'),
				     "link"=> $public_prefix . "/index#/autoreports/RptListInventoryPricingCode?id=1634977051&title=Item Pricing Codes",
				     "reportName" => "RptListInventoryPricingCode",
				     "params" => '',
				     "columns" => ''],

	    "Item Pricing Methods" => ["label" => $translation->translateLabel('Item Pricing Methods'),
				       "link"=> $public_prefix . "/index#/autoreports/RptListInventoryPricingMethods?id=1650977108&title=Item Pricing Methods",
				       "reportName" => "RptListInventoryPricingMethods",
				       "params" => '',
				       "columns" => ''],

	    "Item Serial Numbers" => ["label" => $translation->translateLabel('Item Serial Numbers'),
				      "link"=> $public_prefix . "/index#/autoreports/RptListInventorySerialNumbers?id=1666977165&title=Item Serial Numbers",
				      "reportName" => "RptListInventorySerialNumbers",
				      "params" => '',
				      "columns" => ''],

	    "Inventory Assemblies" => ["label" => $translation->translateLabel('Inventory Assemblies'),
				       "link"=> $public_prefix . "/index#/autoreports/RptListInventoryAssemblies?id=1538976709&title=Inventory Assemblies",
				       "reportName" => "RptListInventoryAssemblies",
				       "params" => '',
				       "columns" => ''],

	    "Inventory Adjustments" => ["label" => $translation->translateLabel('Inventory Adjustments'),
					"link"=> $public_prefix . "/index#/autoreports/RptListInventoryAdjustments?id=1506976595&title=Inventory Adjustments",
					"reportName" => "RptListInventoryAdjustments",
					"params" => '',
					"columns" => ''],

	    "Adjustments Detail" => ["label" => $translation->translateLabel('Adjustments Detail'),
				     "link"=> $public_prefix . "/index#/autoreports/RptListInventoryAdjustmentsDetail?id=1522976652&title=Inventory Adjustments Detail",
				     "reportName" => "RptListInventoryAdjustmentsDetail",
				     "params" => '',
				     "columns" => ''],

	    "Adjustment Types" => ["label" => $translation->translateLabel('Adjustment Types'),
				   "link"=> $public_prefix . "/index#/autoreports/RptListInventoryAdjustmentTypes?id=1490976538&title=Inventory Adjustment Types",
				   "reportName" => "RptListInventoryAdjustmentTypes",
				   "params" => '',
				   "columns" => ''],

	    "Lead Information" => ["label" => $translation->translateLabel('Lead Information'),
				   "link"=> $public_prefix . "/index#/autoreports/RptListLeadInformation?id=1746977450&title=Lead Information",
				   "reportName" => "RptListLeadInformation",
				   "params" => '',
				   "columns" => ''],

	    "Lead Comments" => ["label" => $translation->translateLabel('Lead Comments'),
				"link"=> $public_prefix . "/index#/autoreports/RptListLeadComments?id=1714977336&title=Lead Comments",
				"reportName" => "RptListLeadComments",
				"params" => '',
				"columns" => ''],

	    "Lead Contacts" => ["label" => $translation->translateLabel('Lead Contacts'),
				"link"=> $public_prefix . "/index#/autoreports/RptListLeadContacts?id=1730977393&title=Lead Contacts",
				"reportName" => "RptListLeadContacts",
				"params" => '',
				"columns" => ''],

	    "Lead Types" => ["label" => $translation->translateLabel('Lead Types'),
			     "link"=> $public_prefix . "/index#/autoreports/RptListLeadType?id=1762977507&title=Lead Types",
			     "reportName" => "RptListLeadType",
			     "params" => '',
			     "columns" => ''],

	    "All Lead Emails" => ["label" => $translation->translateLabel('All Lead Emails'),
				  "link"=> $public_prefix . "/index#/autoreports/RptListAllLeadEmails?id=1553648828&title=All Lead Emails",
				  "reportName" => "RptListAllLeadEmails",
				  "params" => '',
				  "columns" => ''],

	    "Weekly Lead Emails" => ["label" => $translation->translateLabel('Weekly Lead Emails'),
				     "link"=> $public_prefix . "/index#/autoreports/RptListAllWeeklyLeadEmails?id=1585648942&title=Weekly Lead Emails",
				     "reportName" => "RptListAllWeeklyLeadEmails",
				     "params" => '',
				     "columns" => ''],

	    "Payroll Setup" => ["label" => $translation->translateLabel('Payroll Setup'),
				"link"=> $public_prefix . "/index#/autoreports/RptListPayrollSetup?id=2146978875&title=Payroll Setup",
				"reportName" => "RptListPayrollSetup",
				"params" => '',
				"columns" => ''],

	    "Payroll Register" => ["label" => $translation->translateLabel('Payroll Register'),
				   "link"=> $public_prefix . "/index#/autoreports/RptListPayrollRegister?id=2114978761&title=Payroll Register",
				   "reportName" => "RptListPayrollRegister",
				   "params" => '',
				   "columns" => ''],

	    "Payroll Register Detail" => ["label" => $translation->translateLabel('Payroll Register Detail'),
					  "link"=> $public_prefix . "/index#/autoreports/RptListPayrollRegisterDetail?id=2130978818&title=Payroll Register Detail",
					  "reportName" => "RptListPayrollRegisterDetail",
					  "params" => '',
					  "columns" => ''],

	    "Payroll Items" => ["label" => $translation->translateLabel('Payroll Items'),
				"link"=> $public_prefix . "/index#/autoreports/RptListPayrollItems?id=2098978704&title=Payroll Items",
				"reportName" => "RptListPayrollItems",
				"params" => '',
				"columns" => ''],

	    "Payroll Item Types" => ["label" => $translation->translateLabel('Payroll Item Types'),
				     "link"=> $public_prefix . "/index#/autoreports/RptListPayrollItemTypes?id=2082978647&title=Payroll Item Types",
				     "reportName" => "RptListPayrollItemTypes",
				     "params" => '',
				     "columns" => ''],

	    "Payroll Check Type" => ["label" => $translation->translateLabel('Payroll Check Type'),
				     "link"=> $public_prefix . "/index#/autoreports/RptListPayrollCheckType?id=2018978419&title=Payroll Check Type",
				     "reportName" => "RptListPayrollCheckType",
				     "params" => '',
				     "columns" => ''],

	    "W2 Report" => ["label" => $translation->translateLabel('W2 Report'),
			    "link"=> $public_prefix . "/index#/autoreports/RptListPayrollW2Detail?id=15495284&title=W2 Report",
			    "reportName" => "RptListPayrollW2Detail",
			    "params" => '',
			    "columns" => ''],

	    "W3 Report" => ["label" => $translation->translateLabel('W3 Report'),
			    "link"=> $public_prefix . "/index#/autoreports/RptListPayrollW3Detail?id=31495341&title=W3 Report",
			    "reportName" => "RptListPayrollW3Detail",
			    "params" => '',
			    "columns" => ''],

	    "Employees" => ["label" => $translation->translateLabel('Employees'),
			    "link"=> $public_prefix . "/index#/autoreports/RptListPayrollEmployees?id=2050978533&title=Employees",
			    "reportName" => "RptListPayrollEmployees",
			    "params" => '',
			    "columns" => ''],

	    "Employee Details" => ["label" => $translation->translateLabel('Employee Details'),
				   "link"=> $public_prefix . "/index#/autoreports/RptListPayrollEmployeesDetail?id=2066978590&title=Employee Details",
				   "reportName" => "RptListPayrollEmployeesDetail",
				   "params" => '',
				   "columns" => ''],

	    "Employee Types" => ["label" => $translation->translateLabel('Employee Types'),
				 "link"=> $public_prefix . "/index#/autoreports/RptListPayrollEmployeeType?id=2034978476&title=Employee Types",
				 "reportName" => "RptListPayrollEmployeeType",
				 "params" => '',
				 "columns" => ''],

	    "Companies" => ["label" => $translation->translateLabel('Companies'),
			    "link"=> $public_prefix . "/index#/autoreports/RptListCompanies?id=1786645608&title=Companies",
			    "reportName" => "RptListCompanies",
			    "params" => '',
			    "columns" => ''],

	    "Divisions" => ["label" => $translation->translateLabel('Divisions'),
			    "link"=> $public_prefix . "/index#/autoreports/RptListDivisions?id=1802645665&title=Divisions",
			    "reportName" => "RptListDivisions",
			    "params" => '',
			    "columns" => ''],

	    "Departments" => ["label" => $translation->translateLabel('Departments'),
			      "link"=> $public_prefix . "/index#/autoreports/RptListDepartments?id=1298975854&title=Departments",
			      "reportName" => "RptListDepartments",
			      "params" => '',
			      "columns" => ''],

	    "Audit Trail" => ["label" => $translation->translateLabel('Audit Trail'),
			      "link"=> $public_prefix . "/index#/autoreports/RptListAuditTrail?id=786974030&title=Audit Trail",
			      "reportName" => "RptListAuditTrail",
			      "params" => '',
			      "columns" => ''],

	    "Access Permissions" => ["label" => $translation->translateLabel('Access Permissions'),
				     "link"=> $public_prefix . "/index#/autoreports/RptListAccessPermissions?id=770973973&title=Access Permissions",
				     "reportName" => "RptListAccessPermissions",
				     "params" => '',
				     "columns" => ''],

	    "Error Log" => ["label" => $translation->translateLabel('Error Log'),
			    "link"=> $public_prefix . "/index#/autoreports/RptListErrorLog?id=1410976253&title=Error Log",
			    "reportName" => "RptListErrorLog",
			    "params" => '',
			    "columns" => ''],

	    "Credit Card Types" => ["label" => $translation->translateLabel('Credit Card Types'),
				    "link"=> $public_prefix . "/index#/autoreports/RptListCreditCardTypes?id=1074975056&title=Credit Card Types",
				    "reportName" => "RptListCreditCardTypes",
				    "params" => '',
				    "columns" => ''],

	    "Terms" => ["label" => $translation->translateLabel('Terms'),
			"link"=> $public_prefix . "/index#/autoreports/RptListTerms?id=255496139&title=Terms",
			"reportName" => "RptListTerms",
			"params" => '',
			"columns" => ''],

	    "Comment Types" => ["label" => $translation->translateLabel('Comment Types'),
				"link"=> $public_prefix . "/index#/autoreports/RptListCommentTypes?id=930974543&title=Comment Types",
				"reportName" => "RptListCommentTypes",
				"params" => '',
				"columns" => ''],

	    "Warehouses" => ["label" => $translation->translateLabel('Warehouses'),
			     "link"=> $public_prefix . "/index#/autoreports/RptListWarehouses?id=399496652&title=Warehouses",
			     "reportName" => "RptListWarehouses",
			     "params" => '',
			     "columns" => ''],

	    "Shipment Methods" => ["label" => $translation->translateLabel('Shipment Methods'),
				   "link"=> $public_prefix . "/index#/autoreports/RptListShipmentMethods?id=191495911&title=Shipment Methods",
				   "reportName" => "RptListShipmentMethods",
				   "params" => '',
				   "columns" => ''],

	    "Contact Industry" => ["label" => $translation->translateLabel('Contact Industry'),
				   "link"=> $public_prefix . "/index#/autoreports/RptListContactIndustry?id=962974657&title=Contact Industry",
				   "reportName" => "RptListContactIndustry",
				   "params" => '',
				   "columns" => ''],

	    "Contact Regions" => ["label" => $translation->translateLabel('Contact Regions'),
				  "link"=> $public_prefix . "/index#/autoreports/RptListContactRegions?id=978974714&title=Contact Regions",
				  "reportName" => "RptListContactRegions",
				  "params" => '',
				  "columns" => ''],

	    "Contact Source" => ["label" => $translation->translateLabel('Contact Source'),
				 "link"=> $public_prefix . "/index#/autoreports/RptListContactSource?id=994974771&title=Contact Source",
				 "reportName" => "RptListContactSource",
				 "params" => '',
				 "columns" => ''],

	    "Contact Type" => ["label" => $translation->translateLabel('Contact Type'),
			       "link"=> $public_prefix . "/index#/autoreports/RptListContactType?id=1010974828&title=Contact Type",
			       "reportName" => "RptListContactType",
			       "params" => '',
			       "columns" => ''],

	    "Taxes" => ["label" => $translation->translateLabel('Taxes'),
			"link"=> $public_prefix . "/index#/autoreports/RptListTaxes?id=239496082&title=Taxes",
			"reportName" => "RptListTaxes",
			"params" => '',
			"columns" => ''],

	    "Tax Groups" => ["label" => $translation->translateLabel('Tax Groups'),
			     "link"=> $public_prefix . "/index#/autoreports/RptListTaxGroups?id=1054118996&title=Tax Groups",
			     "reportName" => "RptListTaxGroups",
			     "params" => '',
			     "columns" => ''],

	    "Tax Groups Detail" => ["label" => $translation->translateLabel('Tax Groups Detail'),
				    "link"=> $public_prefix . "/index#/autoreports/RptListTaxGroupDetail?id=1038118939&title=Tax Groups Detail",
				    "reportName" => "RptListTaxGroupDetail",
				    "params" => '',
				    "columns" => ''],

	    "Projects" => ["label" => $translation->translateLabel('Projects'),
			   "link"=> $public_prefix . "/index#/autoreports/RptListProjects?id=79495512&title=Projects",
			   "reportName" => "RptListProjects",
			   "params" => '',
			   "columns" => ''],

	    "Project Types" => ["label" => $translation->translateLabel('Project Types'),
				"link"=> $public_prefix . "/index#/autoreports/RptListProjectTypes?id=63495455&title=Project Types",
				"reportName" => "RptListProjectTypes",
				"params" => '',
				"columns" => ''],
	];
    ?>
    <div style="margin-top:10px;"></div>
    <select id="report-type" style="width: 400px;" onchange="onChangeReport(event);">
	<?php
	    foreach($reportTypes as $key=>$value) {
		echo "<option value=\"" . $value["link"] . "\">";
		echo $value["label"];
		echo "</option>";
	    }
	?>
    </select>
    <h3 style="margin-top:20px;">
	<?php echo $translation->translateLabel("Report Columns"); ?>
    </h3>
    <div class="table-responsive col-md-12">
	<form id="columnform">
	    <table class="table table-bordered">
		<thead>
		    <tr>
			<th></th>
			<th><?php echo $translation->translateLabel("Column Name"); ?></th>
			<th><?php echo $translation->translateLabel("Show"); ?></th>
			<th><?php echo $translation->translateLabel("Total"); ?></th>
			<th><?php echo $translation->translateLabel("Sort Order"); ?></th>
			<th><?php echo $translation->translateLabel("Sort Direction"); ?></th>
			<th><?php echo $translation->translateLabel("Search Operator"); ?></th>
			<th><?php echo $translation->translateLabel("Search Criteria"); ?></th>
		    </tr>
		</thead>
		<tbody id="table-body">
		</tbody>
	    </table>
	</form>
    </div>

    <h3 class="pull-left col-md-12" style="margin-top:20px;">
	<?php echo $translation->translateLabel("Run Report");?>
    </h3>
    <div class="col-md-12">
	<a id="getreportexplorer" class="btn btn-info" href="#" target="_blank">Reports Explorer</a>
	<a id="getreportscreen" class="btn btn-info" href="#" target="_blank">Screen</a>
	<a id="getreportpdf" class="btn btn-info" href="#" target="_blank">PDF</a>
	<a id="getreporttext"  class="btn btn-info" href="#" target="_blank">CSV</a>
	<a id="getreportexcel" class="btn btn-info" href="#" target="_blank">Excel</a>
	<a id="getreportcopy" class="btn btn-info" href="#" target="_blank">Copy</a>
	<a id="getreportchart" class="btn btn-info" href="#" target="_blank">Chart</a>
    </div>
</div>
<script>
 var autoreportsColumns = [];
 var currentEditedColumn = false;
 var currentEditedData;
 var editedColumns = {};
 var orderMax = 2;

 var getreportexplorerhref = document.getElementById("getreportexplorer").href;
 var getreportscreenhref = document.getElementById("getreportscreen").href;
 var getreportpdfhref = document.getElementById("getreportpdf").href;
 var getreporttexthref = document.getElementById("getreporttext").href;
 var getreportexcelhref = document.getElementById("getreportexcel").href;
 var getreportcopyhref = document.getElementById("getreportcopy").href;
 var getreportcharthref = document.getElementById("getreportchart").href;


 function autoreportsFillParameter(param, event){
     var params = {};

     var data = reportTypes[$('#report-type option:selected').text()]["params"];

     var keys = Object.keys(data);

     for (var i = 0; i < keys.length; i++) {
	 params[data[keys[i]].PARAMETER_NAME] = null;
     }

     params[param] = event.target.value;
     var filled = 0, plength = 0, ind;
     for(ind in params){
	 if(params[ind] != null)
	     filled++;
	 plength++;
     }
     if(filled == plength){
	 window.location = window.location.href + "&" + $.param(params);
     }
     console.log(filled, plength);
 }

 function autoreportsChangeColumn(name){
     var item, operators = <?php echo json_encode($data->getOperators()); ?>, currentOperator, ind, _html;

     if(currentEditedColumn)
	 autoreportsChangeColumnBack(currentEditedColumn, currentEditedData);

     currentEditedColumn = name;

     currentEditedData = {};
     item = document.getElementById(name + "actions");
     currentEditedData.actions = item.innerHTML;
     item.innerHTML = "<span class=\"grid-action-button glyphicon glyphicon-save\" aria-hidden=\"true\" onclick=\"autoreportsSaveColumn('" + name + "')\"></span><span class=\"grid-action-button glyphicon glyphicon-remove\" aria-hidden=\"true\" onclick=\"autoreportsCancelColumn('" + name + "')\"></span>"

     item = document.getElementById(name + "show");
     currentEditedData.show = item.innerHTML;
     item.innerHTML = "<input name=\"show\" type=\"checkbox\" " + (item.innerHTML == "True" ? "checked" : "") + "/>";

     item = document.getElementById(name + "total");
     currentEditedData.total = item.innerHTML;
     item.innerHTML = "<input name=\"total\" type=\"checkbox\" " + (item.innerHTML == "True" ? "checked" : "") + "/>";

     var curOrder = 1;
     item = document.getElementById(name + "order");
     currentEditedData.order = item.innerHTML;
     _html = "<select name=\"order\"> " + (item.innerHTML == "-1" ? "<option>-1</option>" : "<option>" + item.innerHTML + "</option><option>-1</option>");
     while(curOrder <= orderMax){
	 if(parseInt(item.innerHTML) != curOrder)
	     _html += "<option>" + curOrder + "</option>";
	 curOrder++;
     }
     _html += "</select>";
     item.innerHTML = _html;

     item = document.getElementById(name + "direction");
     currentEditedData.direction = item.innerHTML;
     item.innerHTML = "<select name=\"direction\"> " + (item.innerHTML == "ASC" ? "<option>Ascending</option><option>Descending</option>" : "<option>Descending</option><option>Ascending</option>") + "</select>";

     item = document.getElementById(name + "operator");
     currentEditedData.operator = item.innerHTML;
     currentOperator = item.innerHTML;
     _html = "<select name=\"operator\">";
     _html += "<option>" + currentOperator + "</option>";
     if(currentOperator != "None")
	 _html += "<option>None</option>";
     for(ind in operators){
	 if(currentOperator != operators[ind])
	     _html += "<option>" + operators[ind] + "</option>";
     }
     _html += "</select>";
     item.innerHTML = _html;

     item = document.getElementById(name + "criteria");
     currentEditedData.criteria = item.innerHTML;
     item.innerHTML = "<input name=\"criteria\" type=\"text\" value=\"" + currentEditedData.criteria + "\"" + " />";
     editedColumns[name] = currentEditedData;
 }


 function autoreportsChangeColumnBack(name, lastvalues){
     currentEditedColumn = false;
     var options = {}, ind, formarray;
     if(lastvalues)
	 options = lastvalues
     else{
	 formarray = $("#columnform").serializeArray();
	 for(ind in formarray)
	     options[formarray[ind].name] = formarray[ind].value;
	 if(options.hasOwnProperty("show"))
	     options.show = "True";
	 else
	     options.show = "False";
	 if(options.hasOwnProperty("total"))
	     options.total = "True";
	 else
	     options.total = "False";

	 if(options.direction == "Ascending")
	     options.direction = "ASC";
	 else
	     options.direction = "DESC";
	 
	 options.actions = "<span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\" onclick=\"autoreportsChangeColumn('" + name + "')\"></span>";
     }

     var optostr = {
	 "None" : "None",
	 ">" : "M",
	 ">=" : "MEQ",
	 "<" : "L",
	 "<=" : "LEQ",
	 "=" : "EQ",
	 "!=" : "NEQ",
	 "LIKE" : "LIKE"
     }

     for(ind in options){
	 item = document.getElementById(name + ind);
	 item.innerHTML = options[ind];
     }

     options.operator = optostr[options.operator];
     return options;
 }

 function autoreportsSaveColumn(name){
     if(name){
	 var options = autoreportsChangeColumnBack(name);
	 autoreportsColumns[name] = [options.show, options.total, options.order, options.direction, options.operator, options.criteria];
	 if(parseInt(options.order) == orderMax) {
	     orderMax++;
	 }
     }

     var params = {}, ind;
     for(ind in autoreportsColumns) {
	 params[ind] = autoreportsColumns[ind].join(",");
     }

     document.getElementById("getreportexplorer").href = getreportexplorerhref + "&" + $.param(params);
     document.getElementById("getreportscreen").href = getreportscreenhref + "&" + $.param(params);
     document.getElementById("getreportpdf").href = getreportpdfhref + "&" + $.param(params);
     document.getElementById("getreporttext").href = getreporttexthref  + "&" + $.param(params);
     document.getElementById("getreportexcel").href = getreportexcelhref + "&" + $.param(params);
     document.getElementById("getreportcopy").href = getreportcopyhref + "&" + $.param(params);
     document.getElementById("getreportchart").href = getreportcharthref + "&" + $.param(params);
 }

 function autoreportsCancelColumn(name){
     autoreportsChangeColumnBack(name, currentEditedData);
 }

 var updatePage = function () {
     var reportTypes = <?php echo json_encode($reportTypes) ?>;
     var header = <?php json_encode($_GET);?>

	 $.post("<?php echo $linksMaker->makeProcedureLink($ascope["path"], "getParametersForEnter"); ?>",{
	     "reportName" : reportTypes[$('#report-type option:selected').text()]["reportName"]
	 })
	  .success(function(data) {
	      autoreportsColumns = [];
	      currentEditedColumn = false;
	      currentEditedData;
	      editedColumns = {};
	      orderMax = 2;

	      reportTypes[$('#report-type option:selected').text()]["params"] = data;
	      if (!data.length || header[data[0].PARAMETER_NAME]) {
		  // getColumns
		  $.post("<?php echo $linksMaker->makeProcedureLink($ascope["path"], "getColumns"); ?>",{
		      "reportName" : reportTypes[$('#report-type option:selected').text()]["reportName"]
		  })
		   .success(function(data) {
		       reportTypes[$('#report-type option:selected').text()]["columns"] = data;

		       var columnsDefaults = [];
		       var colcounter = 0;

		       var keys = Object.keys(data);

		       for (var i = 0; i < keys.length; i++) {
			   columnsDefaults[keys[i]] = [
			       "True",
			       data[keys[i]]["native_type"] == "NEWDECIMAL" || data[keys[i]]["native_type"] == "DECIMAL" ? "True" : "False",
			       !colcounter ? 1 : -1,
			       "ASC",
			       "None",
			       ""
			   ];
			   colcounter++;
		       }
		       var select = document.getElementById('table-body');

		       while (select.firstChild) {
			   select.removeChild(select.firstChild);
		       }
		       var keysDefaults = Object.keys(columnsDefaults);
		       for (var i = 0; i < keysDefaults.length; i++) {
			   $('#table-body').append(
			       "<tr><td id=\"" + keysDefaults[i] + "actions\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\" onclick=\"autoreportsChangeColumn('" + keysDefaults[i] + "')\"></span></td><td>" + keysDefaults[i] + "</td><td id=\"" + keysDefaults[i] + "show\">" + columnsDefaults[keysDefaults[i]][0] + "</td><td id=\"" + keysDefaults[i] + "total\">" + columnsDefaults[keysDefaults[i]][1] + "</td><td id=\"" + keysDefaults[i] + "order\">" + columnsDefaults[keysDefaults[i]][2] + "</td><td id=\"" + keysDefaults[i] + "direction\">" + columnsDefaults[keysDefaults[i]][3] + "</td><td id=\"" + keysDefaults[i] + "operator\">" + columnsDefaults[keysDefaults[i]][4] + "</td><td id=\"" + keysDefaults[i] + "criteria\">" + columnsDefaults[keysDefaults[i]][5] + "</td></tr>"
			   );
		       }

		       var reportName = reportTypes[$('#report-type option:selected').text()]["reportName"],
			   reportTitle = $('#report-type option:selected').text();
		       document.getElementById("getreportexplorer").href = linksMaker.makeAutoreportsViewLink("explorer", reportName , "", reportTitle, "");
		       document.getElementById("getreportscreen").href = linksMaker.makeAutoreportsViewLink("screen", reportName , "", reportTitle, "");
		       document.getElementById("getreportpdf").href = linksMaker.makeAutoreportsViewLink("pdf", reportName , "", reportTitle, "");
		       document.getElementById("getreporttext").href = linksMaker.makeAutoreportsViewLink("text", reportName , "", reportTitle, "");
		       document.getElementById("getreportexcel").href = linksMaker.makeAutoreportsViewLink("excel", reportName , "", reportTitle, "");
		       document.getElementById("getreportcopy").href = linksMaker.makeAutoreportsViewLink("copy", reportName , "", reportTitle, "");
		       document.getElementById("getreportchart").href = linksMaker.makeAutoreportsViewLink("chart", reportName , "", reportTitle, "");

		       getreportexplorerhref = document.getElementById("getreportexplorer").href;
		       getreportscreenhref = document.getElementById("getreportscreen").href;
		       getreportpdfhref = document.getElementById("getreportpdf").href;
		       getreporttexthref = document.getElementById("getreporttext").href;
		       getreportexcelhref = document.getElementById("getreportexcel").href;
		       getreportcopyhref = document.getElementById("getreportcopy").href;
		       getreportcharthref = document.getElementById("getreportchart").href;
		       autoreportsSaveColumn();
		   })
		   .error(function(err){
		       alert('Something goes wrong');
		   });
	      } else {
		  reportTypes[$('#report-type option:selected').text()]["columns"] = false;
	      }
	  })
	  .error(function(err){
	      alert('Something goes wrong');
	  });		
 }

 onChangeReport  = function (event) {
     // console.log($('#report-type').val());
     // console.log($('#report-type option:selected').text());
     updatePage();
 }

 $(document).ready(function () {
     // console.log($('#report-type').val());
     // console.log($('#report-type option:selected').text());
     updatePage();
     console.log('dfdfdfd');
 });
</script>

