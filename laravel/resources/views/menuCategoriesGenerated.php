<?php 
 $menuCategories["AccountsReceivable"] = [
"type" => "submenu",
"id" => "AccountsReceivable",
"full" => $translation->translateLabel('Accounts Receivable'),
"short" => "Ac",
"data" => [

[
"id" => "OrderProcessing/ViewOrders",
"full" => $translation->translateLabel('View Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
"short" => "Vi"
],
[
"id" => "OrderProcessing/Pick& Pack Orders",
"full" => $translation->translateLabel('Pick & Pack Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderPickList",
"short" => "Pi"
],
[
"id" => "OrderProcessing/ShipOrders",
"full" => $translation->translateLabel('Ship Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderShipList",
"short" => "Sh"
],
[
"id" => "OrderProcessing/InvoiceShipped Orders",
"full" => $translation->translateLabel('Invoice Shipped Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderInvoiceList",
"short" => "In"
],
[
"id" => "OrderProcessing/ViewInvoices",
"full" => $translation->translateLabel('View Invoices'),
"href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderList",
"short" => "Vi"
],
[
"id" => "OrderScreens/ViewOrders",
"full" => $translation->translateLabel('View Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
"short" => "Vi"
],
[
"id" => "OrderScreens/ViewClosed Orders",
"full" => $translation->translateLabel('View Closed Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderClosedList",
"short" => "Vi"
],
[
"id" => "OrderScreens/ViewOrders History",
"full" => $translation->translateLabel('View Orders History'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "OrderScreens/ViewOrders on Hold",
"full" => $translation->translateLabel('View Orders on Hold'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderHoldList",
"short" => "Vi"
],
[
"id" => "OrderScreens/ViewOrders Tracking",
"full" => $translation->translateLabel('View Orders Tracking'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderTrackingHeaderList",
"short" => "Vi"
],
[
"id" => "OrderScreens/ViewBackorders",
"full" => $translation->translateLabel('View Backorders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderBackList",
"short" => "Vi"
],
[
"id" => "OrderScreens/Pick& Pack Orders",
"full" => $translation->translateLabel('Pick & Pack Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderPickList",
"short" => "Pi"
],
[
"id" => "OrderScreens/ShipOrders",
"full" => $translation->translateLabel('Ship Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderShipList",
"short" => "Sh"
],
[
"id" => "OrderScreens/InvoiceShipped Orders",
"full" => $translation->translateLabel('Invoice Shipped Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderInvoiceList",
"short" => "In"
],
[
"id" => "OrderScreens/ViewInvoices",
"full" => $translation->translateLabel('View Invoices'),
"href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderList",
"short" => "Vi"
],
[
"id" => "OrderScreens/ViewClosed Invoices",
"full" => $translation->translateLabel('View Closed Invoices'),
"href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderClosedList",
"short" => "Vi"
],
[
"id" => "OrderScreens/ViewInvoices History",
"full" => $translation->translateLabel('View Invoices History'),
"href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "OrderScreens/ViewInvoices Tracking",
"full" => $translation->translateLabel('View Invoices Tracking'),
"href"=> "EnterpriseASPAR/OrderProcessing/InvoiceTrackingHeaderList",
"short" => "Vi"
],
[
"id" => "OrderScreens/StoreInvoices",
"full" => $translation->translateLabel('Store Invoices'),
"href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderStoreList",
"short" => "St"
],
[
"id" => "OrderScreens/ViewQuotes",
"full" => $translation->translateLabel('View Quotes'),
"href"=> "EnterpriseASPAR/OrderProcessing/QuoteHeaderList",
"short" => "Vi"
],
[
"id" => "OrderScreens/ViewQuotes Tracking",
"full" => $translation->translateLabel('View Quotes Tracking'),
"href"=> "EnterpriseASPAR/OrderProcessing/QuoteTrackingHeaderList",
"short" => "Vi"
],
[
"id" => "ServiceProcessing/ViewService Orders",
"full" => $translation->translateLabel('View Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",
"short" => "Vi"
],
[
"id" => "ServiceProcessing/FulfillService Orders",
"full" => $translation->translateLabel('Fulfill Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderPickList",
"short" => "Fu"
],
[
"id" => "ServiceProcessing/PerformService Orders",
"full" => $translation->translateLabel('Perform Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderShipList",
"short" => "Pe"
],
[
"id" => "ServiceProcessing/InvoiceService Orders",
"full" => $translation->translateLabel('Invoice Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderInvoiceList",
"short" => "In"
],
[
"id" => "ServiceProcessing/ViewService Invoices",
"full" => $translation->translateLabel('View Service Invoices'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderList",
"short" => "Vi"
],
[
"id" => "ServiceScreens/ViewService Orders",
"full" => $translation->translateLabel('View Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",
"short" => "Vi"
],
[
"id" => "ServiceScreens/ServiceOrders on Hold",
"full" => $translation->translateLabel('Service Orders on Hold'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderHoldList",
"short" => "Se"
],
[
"id" => "ServiceScreens/ClosedService Orders",
"full" => $translation->translateLabel('Closed Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderClosedList",
"short" => "Cl"
],
[
"id" => "ServiceScreens/ServiceOrder History",
"full" => $translation->translateLabel('Service Order History'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderHistoryList",
"short" => "Se"
],
[
"id" => "ServiceScreens/StoreService Orders",
"full" => $translation->translateLabel('Store Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderStoreList",
"short" => "St"
],
[
"id" => "ServiceScreens/FulfillService Orders",
"full" => $translation->translateLabel('Fulfill Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderPickList",
"short" => "Fu"
],
[
"id" => "ServiceScreens/PerformService Orders",
"full" => $translation->translateLabel('Perform Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderShipList",
"short" => "Pe"
],
[
"id" => "ServiceScreens/InvoiceService Orders",
"full" => $translation->translateLabel('Invoice Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderInvoiceList",
"short" => "In"
],
[
"id" => "ServiceScreens/ViewService Invoices",
"full" => $translation->translateLabel('View Service Invoices'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderList",
"short" => "Vi"
],
[
"id" => "ServiceScreens/ClosedService Invoices",
"full" => $translation->translateLabel('Closed Service Invoices'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderClosedList",
"short" => "Cl"
],
[
"id" => "ServiceScreens/ServiceInvoice History",
"full" => $translation->translateLabel('Service Invoice History'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderHistoryList",
"short" => "Se"
],
[
"id" => "ServiceScreens/StoreService Invoices",
"full" => $translation->translateLabel('Store Service Invoices'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderStoreList",
"short" => "St"
],
[
"id" => "Projects& Jobs/ViewProjects",
"full" => $translation->translateLabel('View Projects'),
"href"=> "EnterpriseASPAR/Projects/ProjectsList",
"short" => "Vi"
],
[
"id" => "Projects& Jobs/ProjectTypes",
"full" => $translation->translateLabel('Project Types'),
"href"=> "EnterpriseASPAR/Projects/ProjectTypesList",
"short" => "Pr"
],
[
"id" => "CreditMemos/ViewCredit Memos",
"full" => $translation->translateLabel('View Credit Memos'),
"href"=> "EnterpriseASPAR/CreditMemos/CreditMemoHeaderList",
"short" => "Vi"
],
[
"id" => "CreditMemos/ViewClosed Credit Memos",
"full" => $translation->translateLabel('View Closed Credit Memos'),
"href"=> "EnterpriseASPAR/CreditMemos/CreditMemoHeaderClosedList",
"short" => "Vi"
],
[
"id" => "CreditMemos/ViewCredit Memo History",
"full" => $translation->translateLabel('View Credit Memo History'),
"href"=> "EnterpriseASPAR/CreditMemos/CreditMemoHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "CreditMemos/StoreCredit Memos",
"full" => $translation->translateLabel('Store Credit Memos'),
"href"=> "EnterpriseASPAR/CreditMemos/CreditMemoHeaderStoreList",
"short" => "St"
],
[
"id" => "CreditMemos/IssuePayments for Credit Memos",
"full" => $translation->translateLabel('Issue Payments for Credit Memos'),
"href"=> "EnterpriseASPAR/CreditMemos/CreditMemoIssuePaymentsList",
"short" => "Is"
],
[
"id" => "RMAProcessing/ViewRMA",
"full" => $translation->translateLabel('View RMA'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderList",
"short" => "Vi"
],
[
"id" => "RMAProcessing/ApproveRMA",
"full" => $translation->translateLabel('Approve RMA'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderApproveList",
"short" => "Ap"
],
[
"id" => "RMAProcessing/ReceiveRMA",
"full" => $translation->translateLabel('Receive RMA'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderReceiveList",
"short" => "Re"
],
[
"id" => "RMAProcessing/ReceivedRMAs",
"full" => $translation->translateLabel('Received RMA\'s'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderReceivedList",
"short" => "Re"
],
[
"id" => "RMAScreens/ViewRMA",
"full" => $translation->translateLabel('View RMA'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderList",
"short" => "Vi"
],
[
"id" => "RMAScreens/ViewClosed RMAs",
"full" => $translation->translateLabel('View Closed RMA\'s'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderClosedList",
"short" => "Vi"
],
[
"id" => "RMAScreens/ViewRMA History",
"full" => $translation->translateLabel('View RMA History'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "RMAScreens/StoreRMAs",
"full" => $translation->translateLabel('Store RMA\'s'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderStoreList",
"short" => "St"
],
[
"id" => "RMAScreens/ApproveRMA",
"full" => $translation->translateLabel('Approve RMA'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderApproveList",
"short" => "Ap"
],
[
"id" => "RMAScreens/ReceiveRMA",
"full" => $translation->translateLabel('Receive RMA'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderReceiveList",
"short" => "Re"
],
[
"id" => "RMAScreens/ReceivedRMAs",
"full" => $translation->translateLabel('Received RMA\'s'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderReceivedList",
"short" => "Re"
],
[
"id" => "CashReceipts Processing/ViewCash Receipts",
"full" => $translation->translateLabel('View Cash Receipts'),
"href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderList",
"short" => "Vi"
],
[
"id" => "CashReceipts Processing/ProcessCash Receipts",
"full" => $translation->translateLabel('Process Cash Receipts'),
"href"=> "EnterpriseASPAR/CashReceipts/CashReceiptCustomerList",
"short" => "Pr"
],
[
"id" => "CashReceipts Screens/ViewCash Receipts",
"full" => $translation->translateLabel('View Cash Receipts'),
"href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderList",
"short" => "Vi"
],
[
"id" => "CashReceipts Screens/ViewClosed Cash Receipts",
"full" => $translation->translateLabel('View Closed Cash Receipts'),
"href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderClosedList",
"short" => "Vi"
],
[
"id" => "CashReceipts Screens/ViewCash Receipts History",
"full" => $translation->translateLabel('View Cash Receipts History'),
"href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "CashReceipts Screens/StoreCash Receipts",
"full" => $translation->translateLabel('Store Cash Receipts'),
"href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderStoreList",
"short" => "St"
],
[
"id" => "CashReceipts Screens/ProcessCash Receipts",
"full" => $translation->translateLabel('Process Cash Receipts'),
"href"=> "EnterpriseASPAR/CashReceipts/CashReceiptCustomerList",
"short" => "Pr"
],
[
"id" => "Customers/ViewCustomers",
"full" => $translation->translateLabel('View Customers'),
"href"=> "EnterpriseASPAR/Customers/CustomerInformationList",
"short" => "Vi"
],
[
"id" => "Customers/ViewCustomer Financials",
"full" => $translation->translateLabel('View Customer Financials'),
"href"=> "EnterpriseASPAR/Customers/CustomerFinancialsList",
"short" => "Vi"
],
[
"id" => "Customers/ViewShip To Locations",
"full" => $translation->translateLabel('View Ship To Locations'),
"href"=> "EnterpriseASPAR/Customers/CustomerShipToLocationsList",
"short" => "Vi"
],
[
"id" => "Customers/ViewShip For Locations",
"full" => $translation->translateLabel('View Ship For Locations'),
"href"=> "EnterpriseASPAR/Customers/CustomerShipForLocationsList",
"short" => "Vi"
],
[
"id" => "Customers/ViewCredit References",
"full" => $translation->translateLabel('View Credit References'),
"href"=> "EnterpriseASPAR/Customers/CustomerCreditReferencesList",
"short" => "Vi"
],
[
"id" => "Customers/ViewCustomer Contacts",
"full" => $translation->translateLabel('View Customer Contacts'),
"href"=> "EnterpriseASPAR/Customers/CustomerContactsList",
"short" => "Vi"
],
[
"id" => "Customers/ViewContact Log",
"full" => $translation->translateLabel('View Contact Log'),
"href"=> "EnterpriseASPAR/Customers/CustomerContactLogList",
"short" => "Vi"
],
[
"id" => "Customers/ViewComments",
"full" => $translation->translateLabel('View Comments'),
"href"=> "EnterpriseASPAR/Customers/CustomerCommentsList",
"short" => "Vi"
],
[
"id" => "Customers/ViewComment Types",
"full" => $translation->translateLabel('View Comment Types'),
"href"=> "EnterpriseASPAR/Customers/CommentTypesList",
"short" => "Vi"
],
[
"id" => "Customers/ViewAccount Status",
"full" => $translation->translateLabel('View Account Status'),
"href"=> "EnterpriseASPAR/Customers/CustomerAccountStatusesList",
"short" => "Vi"
],
[
"id" => "Customers/ViewItem Xref",
"full" => $translation->translateLabel('View Item Xref'),
"href"=> "EnterpriseASPAR/Customers/CustomerItemCrossReferenceList",
"short" => "Vi"
],
[
"id" => "Customers/ViewPrice Xref",
"full" => $translation->translateLabel('View Price Xref'),
"href"=> "EnterpriseASPAR/Customers/CustomerPriceCrossReferenceList",
"short" => "Vi"
],
[
"id" => "Customers/ViewCustomer References",
"full" => $translation->translateLabel('View Customer References'),
"href"=> "EnterpriseASPAR/Customers/CustomerReferencesList",
"short" => "Vi"
],
[
"id" => "Customers/ViewCustomer Satisfactions",
"full" => $translation->translateLabel('View Customer Satisfactions'),
"href"=> "EnterpriseASPAR/Customers/CustomerSatisfactionList",
"short" => "Vi"
],
[
"id" => "Customers/ViewCustomer Types",
"full" => $translation->translateLabel('View Customer Types'),
"href"=> "EnterpriseASPAR/Customers/CustomerTypesList",
"short" => "Vi"
]
]
];
 ?><?php 
 $menuCategories["AccountsPayable"] = [
"type" => "submenu",
"id" => "AccountsPayable",
"full" => $translation->translateLabel('Accounts Payable'),
"short" => "Ac",
"data" => [

[
"id" => "PurchaseProcessing/ViewPurchases",
"full" => $translation->translateLabel('View Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderList",
"short" => "Vi"
],
[
"id" => "PurchaseProcessing/ApprovePurchases",
"full" => $translation->translateLabel('Approve Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderApproveList",
"short" => "Ap"
],
[
"id" => "PurchaseProcessing/ReceivePurchases",
"full" => $translation->translateLabel('Receive Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderReceiveList",
"short" => "Re"
],
[
"id" => "PurchaseProcessing/ViewReceived Purchases",
"full" => $translation->translateLabel('View Received Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderReceivedList",
"short" => "Vi"
],
[
"id" => "PurchaseScreens/ViewPurchases",
"full" => $translation->translateLabel('View Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderList",
"short" => "Vi"
],
[
"id" => "PurchaseScreens/ViewClosed Purchases",
"full" => $translation->translateLabel('View Closed Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderClosedList",
"short" => "Vi"
],
[
"id" => "PurchaseScreens/ViewPurchases History",
"full" => $translation->translateLabel('View Purchases History'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "PurchaseScreens/StorePurchases",
"full" => $translation->translateLabel('Store Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderStoreList",
"short" => "St"
],
[
"id" => "PurchaseScreens/ApprovePurchases",
"full" => $translation->translateLabel('Approve Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderApproveList",
"short" => "Ap"
],
[
"id" => "PurchaseScreens/ReceivePurchases",
"full" => $translation->translateLabel('Receive Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderReceiveList",
"short" => "Re"
],
[
"id" => "PurchaseScreens/ViewReceived Purchases",
"full" => $translation->translateLabel('View Received Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderReceivedList",
"short" => "Vi"
],
[
"id" => "PurchaseContracts/ViewPurchases Tracking",
"full" => $translation->translateLabel('View Purchases Tracking'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseTrackingHeaderList",
"short" => "Vi"
],
[
"id" => "PurchaseContracts/ViewPurchase Contracts",
"full" => $translation->translateLabel('View Purchase Contracts'),
"href"=> "EnterpriseASPAP/PurchaseContract/PurchaseContractHeaderList",
"short" => "Vi"
],
[
"id" => "PurchaseContracts/ViewPurchase Contracts History",
"full" => $translation->translateLabel('View Purchase Contracts History'),
"href"=> "EnterpriseASPAP/PurchaseContract/PurchaseContractHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "PurchaseContracts/ViewPurchase Contract Ledger",
"full" => $translation->translateLabel('View Purchase Contract Ledger'),
"href"=> "EnterpriseASPAP/PurchaseContract/PurchaseContractLedgerList",
"short" => "Vi"
],
[
"id" => "PurchaseContracts/ViewPurchase Contract Ledger History",
"full" => $translation->translateLabel('View Purchase Contract Ledger History'),
"href"=> "EnterpriseASPAP/PurchaseContract/PurchaseContractLedgerHistoryList",
"short" => "Vi"
],
[
"id" => "VoucherProcessing /ViewVouchers",
"full" => $translation->translateLabel('View Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderList",
"short" => "Vi"
],
[
"id" => "VoucherProcessing /ApproveVouchers",
"full" => $translation->translateLabel('Approve Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderApproveList",
"short" => "Ap"
],
[
"id" => "VoucherProcessing /IssueVouchers",
"full" => $translation->translateLabel('Issue Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderIssueList",
"short" => "Is"
],
[
"id" => "VoucherProcessing /IssueCredit Memos for Vouchers",
"full" => $translation->translateLabel('Issue Credit Memos for Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderIssueCreditMemoList",
"short" => "Is"
],
[
"id" => "VoucherProcessing /ThreeWay Matching",
"full" => $translation->translateLabel('Three Way Matching'),
"href"=> "EnterpriseASPAP/Payments/PaymentsMatching",
"short" => "Th"
],
[
"id" => "VoucherScreens /ViewVouchers",
"full" => $translation->translateLabel('View Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderList",
"short" => "Vi"
],
[
"id" => "VoucherScreens /VoidVouchers",
"full" => $translation->translateLabel('Void Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderVoidList",
"short" => "Vo"
],
[
"id" => "VoucherScreens /ViewVoided Vouchers History",
"full" => $translation->translateLabel('View Voided Vouchers History'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderVoidHistoryList",
"short" => "Vi"
],
[
"id" => "VoucherScreens /ViewClosed Vouchers",
"full" => $translation->translateLabel('View Closed Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderClosedList",
"short" => "Vi"
],
[
"id" => "VoucherScreens /ViewVocuhers History",
"full" => $translation->translateLabel('View Vocuhers History'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "VoucherScreens /StoreVocuhers",
"full" => $translation->translateLabel('Store Vocuhers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderStoreList",
"short" => "St"
],
[
"id" => "VoucherScreens /ApproveVouchers",
"full" => $translation->translateLabel('Approve Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderApproveList",
"short" => "Ap"
],
[
"id" => "VoucherScreens /IssuePayments for Vouchers",
"full" => $translation->translateLabel('Issue Payments for Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderIssueList",
"short" => "Is"
],
[
"id" => "VoucherScreens /IssueCredit Memos for Vouchers",
"full" => $translation->translateLabel('Issue Credit Memos for Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderIssueCreditMemoList",
"short" => "Is"
],
[
"id" => "DebitMemos/ViewDebit Memos",
"full" => $translation->translateLabel('View Debit Memos'),
"href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderList",
"short" => "Vi"
],
[
"id" => "DebitMemos/ViewClosed Debit Memo",
"full" => $translation->translateLabel('View Closed Debit Memo'),
"href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderClosedList",
"short" => "Vi"
],
[
"id" => "DebitMemos/ViewStore Debit Memo",
"full" => $translation->translateLabel('View Store Debit Memo'),
"href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderStoreList",
"short" => "Vi"
],
[
"id" => "DebitMemos/ViewDebit Memo History",
"full" => $translation->translateLabel('View Debit Memo History'),
"href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "DebitMemos/ApplyDebit Memos to Payments",
"full" => $translation->translateLabel('Apply Debit Memos to Payments'),
"href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderPaymentsList",
"short" => "Ap"
],
[
"id" => "Returnto Vendor Processing/ViewReturns",
"full" => $translation->translateLabel('View Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
"short" => "Vi"
],
[
"id" => "Returnto Vendor Processing/Pick& Pack Returns",
"full" => $translation->translateLabel('Pick & Pack Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderPickList",
"short" => "Pi"
],
[
"id" => "Returnto Vendor Processing/ShipReturns",
"full" => $translation->translateLabel('Ship Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderShipList",
"short" => "Sh"
],
[
"id" => "Returnto Vendor Processing/InvoiceShipped Returns",
"full" => $translation->translateLabel('Invoice Shipped Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderInvoiceList",
"short" => "In"
],
[
"id" => "Returnto Vendor Processing/ViewReturn Invoices",
"full" => $translation->translateLabel('View Return Invoices'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderList",
"short" => "Vi"
],
[
"id" => "Returnto Vendor Processing/ViewReturn Cash Receipts",
"full" => $translation->translateLabel('View Return Cash Receipts'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnReceiptsHeaderList",
"short" => "Vi"
],
[
"id" => "Returnto Vendor Processing/ProcessReturns Cash Receipt",
"full" => $translation->translateLabel('Process Returns Cash Receipt'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnCashReceiptVendorList",
"short" => "Pr"
],
[
"id" => "Returnto Vendor Screens/ViewReturns",
"full" => $translation->translateLabel('View Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
"short" => "Vi"
],
[
"id" => "Returnto Vendor Screens/ViewClosed Returns",
"full" => $translation->translateLabel('View Closed Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderClosedList",
"short" => "Vi"
],
[
"id" => "Returnto Vendor Screens/ViewReturn History",
"full" => $translation->translateLabel('View Return History'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "Returnto Vendor Screens/ViewShipped Returns",
"full" => $translation->translateLabel('View Shipped Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderShippedList",
"short" => "Vi"
],
[
"id" => "Returnto Vendor Screens/ViewStore Returns",
"full" => $translation->translateLabel('View Store Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderStoreList",
"short" => "Vi"
],
[
"id" => "Returnto Vendor Screens/Pick& Pack Returns",
"full" => $translation->translateLabel('Pick & Pack Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderPickList",
"short" => "Pi"
],
[
"id" => "Returnto Vendor Screens/ShipReturns",
"full" => $translation->translateLabel('Ship Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderShipList",
"short" => "Sh"
],
[
"id" => "Returnto Vendor Screens/InvoiceShipped Returns",
"full" => $translation->translateLabel('Invoice Shipped Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderInvoiceList",
"short" => "In"
],
[
"id" => "Returnto Vendor Screens/ViewReturn Invoices",
"full" => $translation->translateLabel('View Return Invoices'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderList",
"short" => "Vi"
],
[
"id" => "Returnto Vendor Screens/ViewStore Return Invoices",
"full" => $translation->translateLabel('View Store Return Invoices'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderStoreList",
"short" => "Vi"
],
[
"id" => "Returnto Vendor Screens/ViewReturn Cash Receipts",
"full" => $translation->translateLabel('View Return Cash Receipts'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnReceiptsHeaderList",
"short" => "Vi"
],
[
"id" => "Returnto Vendor Screens/ProcessReturns Cash Receipt",
"full" => $translation->translateLabel('Process Returns Cash Receipt'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnCashReceiptVendorList",
"short" => "Pr"
],
[
"id" => "Vendors/ViewVendors",
"full" => $translation->translateLabel('View Vendors'),
"href"=> "EnterpriseASPAP/Vendors/VendorInformationList",
"short" => "Vi"
],
[
"id" => "Vendors/ViewVendor Financials",
"full" => $translation->translateLabel('View Vendor Financials'),
"href"=> "EnterpriseASPAP/Vendors/VendorFinancialsList",
"short" => "Vi"
],
[
"id" => "Vendors/ViewContacts",
"full" => $translation->translateLabel('View Contacts'),
"href"=> "EnterpriseASPAP/Vendors/VendorContactsList",
"short" => "Vi"
],
[
"id" => "Vendors/ViewComments",
"full" => $translation->translateLabel('View Comments'),
"href"=> "EnterpriseASPAP/Vendors/VendorCommentsList",
"short" => "Vi"
],
[
"id" => "Vendors/ViewAccount Status",
"full" => $translation->translateLabel('View Account Status'),
"href"=> "EnterpriseASPAP/Vendors/VendorAccountStatusesList",
"short" => "Vi"
],
[
"id" => "Vendors/ViewAccount Types",
"full" => $translation->translateLabel('View Account Types'),
"href"=> "EnterpriseASPAP/Vendors/VendorTypesList",
"short" => "Vi"
],
[
"id" => "Vendors/ViewItem Xref",
"full" => $translation->translateLabel('View Item Xref'),
"href"=> "EnterpriseASPAP/Vendors/VendorItemCrossReferenceList",
"short" => "Vi"
],
[
"id" => "Vendors/ViewPrice Xref",
"full" => $translation->translateLabel('View Price Xref'),
"href"=> "EnterpriseASPAP/Vendors/VendorPriceCrossReferenceList",
"short" => "Vi"
]
]
];
 ?><?php 
 $menuCategories["GeneralLedger"] = [
"type" => "submenu",
"id" => "GeneralLedger",
"full" => $translation->translateLabel('General Ledger'),
"short" => "Ge",
"data" => [

[
"id" => "Ledger/ViewChart of Accounts",
"full" => $translation->translateLabel('View Chart of Accounts'),
"href"=> "EnterpriseASPGL/Ledger/LedgerChartOfAccountsList",
"short" => "Vi"
],
[
"id" => "Ledger/ViewLedger Account Group",
"full" => $translation->translateLabel('View Ledger Account Group'),
"href"=> "EnterpriseASPGL/Ledger/LedgerAccountGroupList",
"short" => "Vi"
],
[
"id" => "Ledger/ViewGL Transactions",
"full" => $translation->translateLabel('View GL Transactions'),
"href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsList",
"short" => "Vi"
],
[
"id" => "Ledger/ViewClosed GL Transactions",
"full" => $translation->translateLabel('View Closed GL Transactions'),
"href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsClosedList",
"short" => "Vi"
],
[
"id" => "Ledger/ViewGL Transactions History",
"full" => $translation->translateLabel('View GL Transactions History'),
"href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsHistoryList",
"short" => "Vi"
],
[
"id" => "Ledger/StoreGL Transactions",
"full" => $translation->translateLabel('Store GL Transactions'),
"href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsStoreList",
"short" => "St"
],
[
"id" => "Ledger/ViewBudgets",
"full" => $translation->translateLabel('View Budgets'),
"href"=> "EnterpriseASPGL/Ledger/LedgerChartOfAccountsBudgetsList",
"short" => "Vi"
],
[
"id" => "Ledger/ViewPrior Fiscal Year",
"full" => $translation->translateLabel('View Prior Fiscal Year'),
"href"=> "EnterpriseASPGL/Ledger/LedgerChartOfAccountsPriorYearsList",
"short" => "Vi"
],
[
"id" => "Ledger/LedgerTreeview Sample1",
"full" => $translation->translateLabel('Ledger Treeview Sample1'),
"href"=> "EnterpriseASPGL/Ledger/GLCOATreeView",
"short" => "Le"
],
[
"id" => "Ledger/LedgerTreeview Sample2",
"full" => $translation->translateLabel('Ledger Treeview Sample2'),
"href"=> "EnterpriseASPGL/Ledger/GLCOATreeViewSample2",
"short" => "Le"
],
[
"id" => "Banking/ViewBank Accounts",
"full" => $translation->translateLabel('View Bank Accounts'),
"href"=> "EnterpriseASPGL/Banking/BankAccountsList",
"short" => "Vi"
],
[
"id" => "Banking/ViewBank Accounts Contacts",
"full" => $translation->translateLabel('View Bank Accounts Contacts'),
"href"=> "EnterpriseASPGL/Banking/BankAccountsContactsList",
"short" => "Vi"
],
[
"id" => "Banking/ViewBank Transactions",
"full" => $translation->translateLabel('View Bank Transactions'),
"href"=> "EnterpriseASPGL/Banking/BankTransactionsList",
"short" => "Vi"
],
[
"id" => "Banking/ReconcileBank Accounts",
"full" => $translation->translateLabel('Reconcile Bank Accounts'),
"href"=> "EnterpriseASPGL/Banking/BankReconciliationList",
"short" => "Re"
],
[
"id" => "Banking/ViewBank Reconciliations",
"full" => $translation->translateLabel('View Bank Reconciliations'),
"href"=> "EnterpriseASPGL/Banking/BankReconciliationSummaryList",
"short" => "Vi"
],
[
"id" => "LedgerSetup/Currencies",
"full" => $translation->translateLabel('Currencies'),
"href"=> "EnterpriseASPSystem/CompanySetup/CurrencyTypesList",
"short" => "Cu"
],
[
"id" => "LedgerSetup/ClosePeriod",
"full" => $translation->translateLabel('Close Period'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerPeriodCloseDetail",
"short" => "Cl"
],
[
"id" => "LedgerSetup/CloseYear",
"full" => $translation->translateLabel('Close Year'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerYearCloseDetail",
"short" => "Cl"
],
[
"id" => "LedgerSetup/LedgerTransaction Types",
"full" => $translation->translateLabel('Ledger Transaction Types'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerTransactionTypesList",
"short" => "Le"
],
[
"id" => "LedgerSetup/LedgerBalance Types",
"full" => $translation->translateLabel('Ledger Balance Types'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerBalanceTypeList",
"short" => "Le"
],
[
"id" => "LedgerSetup/LedgerAccount Types",
"full" => $translation->translateLabel('Ledger Account Types'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerAccountTypesList",
"short" => "Le"
],
[
"id" => "LedgerSetup/BankTransaction Types",
"full" => $translation->translateLabel('Bank Transaction Types'),
"href"=> "EnterpriseASPSystem/LedgerSetup/BankTransactionTypesList",
"short" => "Ba"
],
[
"id" => "LedgerSetup/AssetType",
"full" => $translation->translateLabel('Asset Type'),
"href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetTypeList",
"short" => "As"
],
[
"id" => "LedgerSetup/AssetStatus",
"full" => $translation->translateLabel('Asset Status'),
"href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetStatusList",
"short" => "As"
],
[
"id" => "LedgerSetup/DepreciationMethods",
"full" => $translation->translateLabel('Depreciation Methods'),
"href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetDepreciationMethodsList",
"short" => "De"
]
]
];
 ?><?php 
 $menuCategories["Inventory"] = [
"type" => "submenu",
"id" => "Inventory",
"full" => $translation->translateLabel('Inventory'),
"short" => "In",
"data" => [

[
"id" => "Items& Stock /ViewInventory On-Hand",
"full" => $translation->translateLabel('View Inventory On-Hand'),
"href"=> "EnterpriseASPInv/ItemsStock/InventoryByWarehouseList",
"short" => "Vi"
],
[
"id" => "Items& Stock /ViewInventory Items",
"full" => $translation->translateLabel('View Inventory Items'),
"href"=> "EnterpriseASPInv/ItemsStock/InventoryItemsList",
"short" => "Vi"
],
[
"id" => "Items& Stock /ViewItem Categories",
"full" => $translation->translateLabel('View Item Categories'),
"href"=> "EnterpriseASPInv/ItemsStock/InventoryCategoriesList",
"short" => "Vi"
],
[
"id" => "Items& Stock /ViewItem Families",
"full" => $translation->translateLabel('View Item Families'),
"href"=> "EnterpriseASPInv/ItemsStock/InventoryFamiliesList",
"short" => "Vi"
],
[
"id" => "Items& Stock /ViewItem Types",
"full" => $translation->translateLabel('View Item Types'),
"href"=> "EnterpriseASPInv/ItemsStock/InventoryItemTypesList",
"short" => "Vi"
],
[
"id" => "Items& Stock /ViewSerial Numbers",
"full" => $translation->translateLabel('View Serial Numbers'),
"href"=> "EnterpriseASPInv/ItemsStock/InventorySerialNumbersList",
"short" => "Vi"
],
[
"id" => "Items& Stock /ViewPricing Codes",
"full" => $translation->translateLabel('View Pricing Codes'),
"href"=> "EnterpriseASPInv/ItemsStock/InventoryPricingCodeList",
"short" => "Vi"
],
[
"id" => "Items& Stock /ViewPricing Methods",
"full" => $translation->translateLabel('View Pricing Methods'),
"href"=> "EnterpriseASPInv/ItemsStock/InventoryPricingMethodsList",
"short" => "Vi"
],
[
"id" => "InventoryAdjustments /ViewAdjustments",
"full" => $translation->translateLabel('View Adjustments'),
"href"=> "EnterpriseASPInv/InventoryAdjustments/InventoryAdjustmentsList",
"short" => "Vi"
],
[
"id" => "InventoryAdjustments /InventoryAdjustment Types",
"full" => $translation->translateLabel('Inventory Adjustment Types'),
"href"=> "EnterpriseASPInv/InventoryAdjustments/InventoryAdjustmentTypesList",
"short" => "In"
],
[
"id" => "WarehouseTransits/WarehouseTransits",
"full" => $translation->translateLabel('Warehouse Transits'),
"href"=> "EnterpriseASPInv/WarehouseTransit/WarehouseTransitHeaderList",
"short" => "Wa"
],
[
"id" => "WarehouseTransits/WarehouseTransits History",
"full" => $translation->translateLabel('Warehouse Transits History'),
"href"=> "EnterpriseASPInv/WarehouseTransit/WarehouseTransitHeaderHistoryList",
"short" => "Wa"
],
[
"id" => "ShoppingCart Setup/CartItems Setup",
"full" => $translation->translateLabel('Cart Items Setup'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryCartDetail",
"short" => "Ca"
],
[
"id" => "ShoppingCart Setup/CategoriesLanguages",
"full" => $translation->translateLabel('Categories Languages'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryCategoriesDisplayLangList",
"short" => "Ca"
],
[
"id" => "ShoppingCart Setup/FamiliesLanguages",
"full" => $translation->translateLabel('Families Languages'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryFamiliesDisplayLangList",
"short" => "Fa"
],
[
"id" => "ShoppingCart Setup/ItemsLanguages",
"full" => $translation->translateLabel('Items Languages'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryItemsDisplayLangList",
"short" => "It"
],
[
"id" => "ShoppingCart Setup/ItemsCross Sell",
"full" => $translation->translateLabel('Items Cross Sell'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryCrossSellingList",
"short" => "It"
],
[
"id" => "ShoppingCart Setup/ItemsNoticifations",
"full" => $translation->translateLabel('Items Noticifations'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryNoticifationsList",
"short" => "It"
],
[
"id" => "ShoppingCart Setup/ItemsRelations",
"full" => $translation->translateLabel('Items Relations'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryRelationsList",
"short" => "It"
],
[
"id" => "ShoppingCart Setup/ItemsReviews",
"full" => $translation->translateLabel('Items Reviews'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryReviewsList",
"short" => "It"
],
[
"id" => "ShoppingCart Setup/ItemsSubsitiutions",
"full" => $translation->translateLabel('Items Subsitiutions'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventorySubstitutionsList",
"short" => "It"
],
[
"id" => "ShoppingCart Setup/ItemsWish List",
"full" => $translation->translateLabel('Items Wish List'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryWishListList",
"short" => "It"
]
]
];
 ?><?php 
 $menuCategories["MRP"] = [
"type" => "submenu",
"id" => "MRP",
"full" => $translation->translateLabel('MRP'),
"short" => "MR",
"data" => [

[
"id" => "Billof Materials/ViewBill Of Materials",
"full" => $translation->translateLabel('View Bill Of Materials'),
"href"=> "EnterpriseASPInv/BillOfMaterials/InventoryAssembliesList",
"short" => "Vi"
],
[
"id" => "Billof Materials/ViewBuild Instructions",
"full" => $translation->translateLabel('View Build Instructions'),
"href"=> "EnterpriseASPInv/BillOfMaterials/InventoryAssembliesInstructionsList",
"short" => "Vi"
],
[
"id" => "Billof Materials/CreateInventory",
"full" => $translation->translateLabel('Create Inventory'),
"href"=> "EnterpriseASPInv/BillOfMaterials/InventoryCreateAssembly",
"short" => "Cr"
],
[
"id" => "WorkOrders/ViewWork Orders",
"full" => $translation->translateLabel('View Work Orders'),
"href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderList",
"short" => "Vi"
],
[
"id" => "WorkOrders/ViewClosed Work Orders",
"full" => $translation->translateLabel('View Closed Work Orders'),
"href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderClosedList",
"short" => "Vi"
],
[
"id" => "WorkOrders/ViewWork Orders History",
"full" => $translation->translateLabel('View Work Orders History'),
"href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "WorkOrders/StoreWork Orders",
"full" => $translation->translateLabel('Store Work Orders'),
"href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderStoreList",
"short" => "St"
],
[
"id" => "MRPSetup/InProgress Types",
"full" => $translation->translateLabel('In Progress Types'),
"href"=> "EnterpriseASPInv/MRPSetup/WorkOrderInProgressList",
"short" => "In"
],
[
"id" => "MRPSetup/PriorityTypes",
"full" => $translation->translateLabel('Priority Types'),
"href"=> "EnterpriseASPInv/MRPSetup/WorkOrderPriorityList",
"short" => "Pr"
],
[
"id" => "MRPSetup/WorkOrder Statuses",
"full" => $translation->translateLabel('Work Order Statuses'),
"href"=> "EnterpriseASPInv/MRPSetup/WorkOrderStatusList",
"short" => "Wo"
],
[
"id" => "MRPSetup/WorkOrder Types",
"full" => $translation->translateLabel('Work Order Types'),
"href"=> "EnterpriseASPInv/MRPSetup/WorkOrderTypesList",
"short" => "Wo"
]
]
];
 ?><?php 
 $menuCategories["FundAccounting"] = [
"type" => "submenu",
"id" => "FundAccounting",
"full" => $translation->translateLabel('Fund Accounting'),
"short" => "Fu",
"data" => [
]
];
 ?><?php 
 $menuCategories["CRM&HelpDesk"] = [
"type" => "submenu",
"id" => "CRMHelpDesk",
"full" => $translation->translateLabel('CRM & Help Desk'),
"short" => "CR",
"data" => [

[
"id" => "CRM/ViewLeads",
"full" => $translation->translateLabel('View Leads'),
"href"=> "EnterpriseASPHelpDesk/CRM/LeadInformationList",
"short" => "Vi"
],
[
"id" => "CRM/ViewLead Contacts",
"full" => $translation->translateLabel('View Lead Contacts'),
"href"=> "EnterpriseASPHelpDesk/CRM/LeadContactsList",
"short" => "Vi"
],
[
"id" => "CRM/ViewLead Comments",
"full" => $translation->translateLabel('View Lead Comments'),
"href"=> "EnterpriseASPHelpDesk/CRM/LeadCommentsList",
"short" => "Vi"
],
[
"id" => "CRM/ViewLead Satisfactions",
"full" => $translation->translateLabel('View Lead Satisfactions'),
"href"=> "EnterpriseASPHelpDesk/CRM/LeadSatisfactionList",
"short" => "Vi"
],
[
"id" => "CRM/ViewLead Types",
"full" => $translation->translateLabel('View Lead Types'),
"href"=> "EnterpriseASPHelpDesk/CRM/LeadTypeList",
"short" => "Vi"
],
[
"id" => "HelpDesk/ViewNews Items",
"full" => $translation->translateLabel('View News Items'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpNewsBoardList",
"short" => "Vi"
],
[
"id" => "HelpDesk/ViewRelease Dates",
"full" => $translation->translateLabel('View Release Dates'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpReleaseDatesList",
"short" => "Vi"
],
[
"id" => "HelpDesk/ViewHeadings",
"full" => $translation->translateLabel('View Headings'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpMessageHeadingList",
"short" => "Vi"
],
[
"id" => "HelpDesk/ViewTopics",
"full" => $translation->translateLabel('View Topics'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpMessageTopicList",
"short" => "Vi"
],
[
"id" => "HelpDesk/ViewProblem Reports",
"full" => $translation->translateLabel('View Problem Reports'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpProblemReportList",
"short" => "Vi"
],
[
"id" => "HelpDesk/ViewSupport Requests",
"full" => $translation->translateLabel('View Support Requests'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSupportRequestList",
"short" => "Vi"
],
[
"id" => "HelpDesk/ViewResources",
"full" => $translation->translateLabel('View Resources'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpResourcesList",
"short" => "Vi"
],
[
"id" => "HelpDesk/ViewPriorities",
"full" => $translation->translateLabel('View Priorities'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpPriorityList",
"short" => "Vi"
],
[
"id" => "HelpDesk/ViewProblem Types",
"full" => $translation->translateLabel('View Problem Types'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpProblemTypeList",
"short" => "Vi"
],
[
"id" => "HelpDesk/ViewRequest Methods",
"full" => $translation->translateLabel('View Request Methods'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpRequestMethodList",
"short" => "Vi"
],
[
"id" => "HelpDesk/ViewResource Types",
"full" => $translation->translateLabel('View Resource Types'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpResourceTypeList",
"short" => "Vi"
],
[
"id" => "HelpDesk/ViewSeverities",
"full" => $translation->translateLabel('View Severities'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSeverityList",
"short" => "Vi"
],
[
"id" => "HelpDesk/ViewStatuses",
"full" => $translation->translateLabel('View Statuses'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpStatusList",
"short" => "Vi"
],
[
"id" => "HelpDesk/ViewSupport Types",
"full" => $translation->translateLabel('View Support Types'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSupportRequestTypeList",
"short" => "Vi"
]
]
];
 ?><?php 
 $menuCategories["Payroll"] = [
"type" => "submenu",
"id" => "Payroll",
"full" => $translation->translateLabel('Payroll'),
"short" => "Pa",
"data" => [

[
"id" => "EmployeeManagement/ViewEmployees",
"full" => $translation->translateLabel('View Employees'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesList",
"short" => "Vi"
],
[
"id" => "EmployeeManagement/EmployeeSecurity",
"full" => $translation->translateLabel('Employee Security'),
"href"=> "EnterpriseASPSystem/CompanySetup/AccessPermissionsList",
"short" => "Em"
],
[
"id" => "EmployeeManagement/EmployeeLogin History",
"full" => $translation->translateLabel('Employee Login History'),
"href"=> "EnterpriseASPSystem/CompanySetup/AuditLoginHistoryList",
"short" => "Em"
],
[
"id" => "EmployeeExpenses/ExpenseReports",
"full" => $translation->translateLabel('Expense Reports'),
"href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportHeaderList",
"short" => "Ex"
],
[
"id" => "EmployeeExpenses/ExpenseReports History",
"full" => $translation->translateLabel('Expense Reports History'),
"href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportHeaderHistoryList",
"short" => "Ex"
],
[
"id" => "EmployeeExpenses/ExpenseReport Items",
"full" => $translation->translateLabel('Expense Report Items'),
"href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportItemsList",
"short" => "Ex"
],
[
"id" => "EmployeeExpenses/ExpenseReport Reasons",
"full" => $translation->translateLabel('Expense Report Reasons'),
"href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportReasonsList",
"short" => "Ex"
],
[
"id" => "EmployeeExpenses/ExpenseReport Types",
"full" => $translation->translateLabel('Expense Report Types'),
"href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportTypesList",
"short" => "Ex"
],
[
"id" => "EmployeeSetup/ViewEmployees",
"full" => $translation->translateLabel('View Employees'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesList",
"short" => "Vi"
],
[
"id" => "EmployeeSetup/EmployeeTypes",
"full" => $translation->translateLabel('Employee Types'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeTypeList",
"short" => "Em"
],
[
"id" => "EmployeeSetup/EmployeePay Type",
"full" => $translation->translateLabel('Employee Pay Type'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeePayTypeList",
"short" => "Em"
],
[
"id" => "EmployeeSetup/EmployeePay Frequency",
"full" => $translation->translateLabel('Employee Pay Frequency'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeePayFrequencyList",
"short" => "Em"
],
[
"id" => "EmployeeSetup/EmployeeStatus",
"full" => $translation->translateLabel('Employee Status'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeStatusList",
"short" => "Em"
],
[
"id" => "EmployeeSetup/EmployeeDepartment",
"full" => $translation->translateLabel('Employee Department'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeDepartmentList",
"short" => "Em"
],
[
"id" => "EmployeeSetup/ViewTask List",
"full" => $translation->translateLabel('View Task List'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesTaskHeaderList",
"short" => "Vi"
],
[
"id" => "EmployeeSetup/ViewTask Priorities",
"full" => $translation->translateLabel('View Task Priorities'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesTaskPriorityList",
"short" => "Vi"
],
[
"id" => "EmployeeSetup/ViewTask Types",
"full" => $translation->translateLabel('View Task Types'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesTaskTypeList",
"short" => "Vi"
],
[
"id" => "EmployeeSetup/EmployeeStatus Types",
"full" => $translation->translateLabel('Employee Status Types'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeStatusTypeList",
"short" => "Em"
],
[
"id" => "EmployeeSetup/ViewEmployee Accruals",
"full" => $translation->translateLabel('View Employee Accruals'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesAccrualList",
"short" => "Vi"
],
[
"id" => "EmployeeSetup/ViewAccrual Frequencies",
"full" => $translation->translateLabel('View Accrual Frequencies'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesAccrualFrequencyList",
"short" => "Vi"
],
[
"id" => "EmployeeSetup/ViewAccrual Types",
"full" => $translation->translateLabel('View Accrual Types'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesAccrualTypesList",
"short" => "Vi"
],
[
"id" => "EmployeeSetup/ViewPayroll Emails",
"full" => $translation->translateLabel('View Payroll Emails'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmailMessagesList",
"short" => "Vi"
],
[
"id" => "EmployeeSetup/ViewPayroll Instant Messages",
"full" => $translation->translateLabel('View Payroll Instant Messages'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollInstantMessagesList",
"short" => "Vi"
],
[
"id" => "EmployeeSetup/ViewEmployee Emails",
"full" => $translation->translateLabel('View Employee Emails'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeeEmailMessageList",
"short" => "Vi"
],
[
"id" => "EmployeeSetup/ViewEmployee Instant Messages",
"full" => $translation->translateLabel('View Employee Instant Messages'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeeInstantMessageList",
"short" => "Vi"
],
[
"id" => "EmployeeSetup/ViewEmployees Calendar",
"full" => $translation->translateLabel('View Employees Calendar'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesCalendarList",
"short" => "Vi"
],
[
"id" => "EmployeeSetup/ViewEmployees Currently On",
"full" => $translation->translateLabel('View Employees Currently On'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesCurrentlyOnList",
"short" => "Vi"
],
[
"id" => "EmployeeSetup/ViewEmployees Events",
"full" => $translation->translateLabel('View Employees Events'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesEventsList",
"short" => "Vi"
],
[
"id" => "EmployeeSetup/ViewEmployees Event Types",
"full" => $translation->translateLabel('View Employees Event Types'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesEventTypesList",
"short" => "Vi"
],
[
"id" => "EmployeeSetup/ViewEmployees Timesheets",
"full" => $translation->translateLabel('View Employees Timesheets'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesTimesheetHeaderList",
"short" => "Vi"
],
[
"id" => "PayrollProcessing/PayEmployees",
"full" => $translation->translateLabel('Pay Employees'),
"href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollPayEmployees",
"short" => "Pa"
],
[
"id" => "PayrollProcessing/PayrollRegister",
"full" => $translation->translateLabel('Payroll Register'),
"href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollRegisterList",
"short" => "Pa"
],
[
"id" => "PayrollProcessing/PayrollChecks",
"full" => $translation->translateLabel('Payroll Checks'),
"href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollChecksList",
"short" => "Pa"
],
[
"id" => "PayrollProcessing/PayrollCheck Types",
"full" => $translation->translateLabel('Payroll Check Types'),
"href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollCheckTypeList",
"short" => "Pa"
],
[
"id" => "PayrollTaxes/PayrollItems Master",
"full" => $translation->translateLabel('Payroll Items Master'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollItemsMasterList",
"short" => "Pa"
],
[
"id" => "PayrollTaxes/PayrollFed Tax",
"full" => $translation->translateLabel('Payroll Fed Tax'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollFedTaxList",
"short" => "Pa"
],
[
"id" => "PayrollTaxes/PayrollFed Tax Tables",
"full" => $translation->translateLabel('Payroll Fed Tax Tables'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollFedTaxTablesList",
"short" => "Pa"
],
[
"id" => "PayrollTaxes/PayrollState Tax",
"full" => $translation->translateLabel('Payroll State Tax'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollStateTaxList",
"short" => "Pa"
],
[
"id" => "PayrollTaxes/PayrollState Tax Tables",
"full" => $translation->translateLabel('Payroll State Tax Tables'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollStateTaxTablesList",
"short" => "Pa"
],
[
"id" => "PayrollTaxes/PayrollCounty Tax",
"full" => $translation->translateLabel('Payroll County Tax'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCountyTaxList",
"short" => "Pa"
],
[
"id" => "PayrollTaxes/PayrollCounty Tax Tables",
"full" => $translation->translateLabel('Payroll County Tax Tables'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCountyTaxTablesList",
"short" => "Pa"
],
[
"id" => "PayrollTaxes/PayrollCity Tax",
"full" => $translation->translateLabel('Payroll City Tax'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCityTaxList",
"short" => "Pa"
],
[
"id" => "PayrollTaxes/PayrollCity Tax Tables",
"full" => $translation->translateLabel('Payroll City Tax Tables'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCityTaxTablesList",
"short" => "Pa"
],
[
"id" => "PayrollSetup/PayrollSetup",
"full" => $translation->translateLabel('Payroll Setup'),
"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollSetupList",
"short" => "Pa"
],
[
"id" => "PayrollSetup/PayrollItems",
"full" => $translation->translateLabel('Payroll Items'),
"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollItemsList",
"short" => "Pa"
],
[
"id" => "PayrollSetup/PayrollItem Types",
"full" => $translation->translateLabel('Payroll Item Types'),
"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollItemTypesList",
"short" => "Pa"
],
[
"id" => "PayrollSetup/PayrollItem Basis",
"full" => $translation->translateLabel('Payroll Item Basis'),
"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollItemBasisList",
"short" => "Pa"
],
[
"id" => "PayrollSetup/W2Details",
"full" => $translation->translateLabel('W2 Details'),
"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollW2DetailList",
"short" => "W2"
],
[
"id" => "PayrollSetup/W3Details",
"full" => $translation->translateLabel('W3 Details'),
"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollW3DetailList",
"short" => "W3"
]
]
];
 ?><?php 
 $menuCategories["SystemSetup"] = [
"type" => "submenu",
"id" => "SystemSetup",
"full" => $translation->translateLabel('System Setup'),
"short" => "Sy",
"data" => [

[
"id" => "CompanySetup/CompanySetup",
"full" => $translation->translateLabel('Company Setup'),
"href"=> "EnterpriseASPSystem/CompanySetup/CompaniesList",
"short" => "Co"
],
[
"id" => "CompanySetup/CompanyDisplay Languages",
"full" => $translation->translateLabel('Company Display Languages'),
"href"=> "EnterpriseASPSystem/CompanySetup/CompaniesDisplayLangList",
"short" => "Co"
],
[
"id" => "CompanySetup/SystemWide Message",
"full" => $translation->translateLabel('System Wide Message'),
"href"=> "EnterpriseASPSystem/CompanySetup/CompaniesSystemWideMessageDetail",
"short" => "Sy"
],
[
"id" => "CompanySetup/CompanyWorkflow By Employees",
"full" => $translation->translateLabel('Company Workflow By Employees'),
"href"=> "EnterpriseASPSystem/CompanySetup/CompaniesWorkflowByEmployeesList",
"short" => "Co"
],
[
"id" => "CompanySetup/CompanyWorkflow Types",
"full" => $translation->translateLabel('Company Workflow Types'),
"href"=> "EnterpriseASPSystem/CompanySetup/CompaniesWorkFlowTypesList",
"short" => "Co"
],
[
"id" => "CompanySetup/DivisionSetup",
"full" => $translation->translateLabel('Division Setup'),
"href"=> "EnterpriseASPSystem/CompanySetup/DivisionsList",
"short" => "Di"
],
[
"id" => "CompanySetup/DepartmentSetup",
"full" => $translation->translateLabel('Department Setup'),
"href"=> "EnterpriseASPSystem/CompanySetup/DepartmentsList",
"short" => "De"
],
[
"id" => "CompanySetup/CompanyID Numbers",
"full" => $translation->translateLabel('Company ID Numbers'),
"href"=> "EnterpriseASPSystem/CompanySetup/CompaniesNextNumbersList",
"short" => "Co"
],
[
"id" => "CompanySetup/CreditCard Types",
"full" => $translation->translateLabel('Credit Card Types'),
"href"=> "EnterpriseASPSystem/CompanySetup/CreditCardTypesList",
"short" => "Cr"
],
[
"id" => "CompanySetup/Currencies",
"full" => $translation->translateLabel('Currencies'),
"href"=> "EnterpriseASPSystem/CompanySetup/CurrencyTypesList",
"short" => "Cu"
],
[
"id" => "CompanySetup/TaxItems",
"full" => $translation->translateLabel('Tax Items'),
"href"=> "EnterpriseASPSystem/CompanySetup/TaxesList",
"short" => "Ta"
],
[
"id" => "CompanySetup/TaxGroup Details",
"full" => $translation->translateLabel('Tax Group Details'),
"href"=> "EnterpriseASPSystem/CompanySetup/TaxGroupDetailList",
"short" => "Ta"
],
[
"id" => "CompanySetup/TaxGroups",
"full" => $translation->translateLabel('Tax Groups'),
"href"=> "EnterpriseASPSystem/CompanySetup/TaxGroupsList",
"short" => "Ta"
],
[
"id" => "CompanySetup/Terms",
"full" => $translation->translateLabel('Terms'),
"href"=> "EnterpriseASPSystem/CompanySetup/TermsList",
"short" => "Te"
],
[
"id" => "CompanySetup/POSSetup",
"full" => $translation->translateLabel('POS Setup'),
"href"=> "EnterpriseASPSystem/CompanySetup/POSSetupDetail",
"short" => "PO"
],
[
"id" => "CompanySetup/ShipmentMethods",
"full" => $translation->translateLabel('Shipment Methods'),
"href"=> "EnterpriseASPSystem/CompanySetup/ShipmentMethodsList",
"short" => "Sh"
],
[
"id" => "CompanySetup/Warehouses",
"full" => $translation->translateLabel('Warehouses'),
"href"=> "EnterpriseASPSystem/CompanySetup/WarehousesList",
"short" => "Wa"
],
[
"id" => "CompanySetup/WarehouseBins",
"full" => $translation->translateLabel('Warehouse Bins'),
"href"=> "EnterpriseASPSystem/CompanySetup/WarehouseBinsList",
"short" => "Wa"
],
[
"id" => "CompanySetup/WarehouseBin Types",
"full" => $translation->translateLabel('Warehouse Bin Types'),
"href"=> "EnterpriseASPSystem/CompanySetup/WarehouseBinTypesList",
"short" => "Wa"
],
[
"id" => "CompanySetup/WarehouseBin Zones",
"full" => $translation->translateLabel('Warehouse Bin Zones'),
"href"=> "EnterpriseASPSystem/CompanySetup/WarehouseBinZonesList",
"short" => "Wa"
],
[
"id" => "CompanySetup/WarehouseContacts",
"full" => $translation->translateLabel('Warehouse Contacts'),
"href"=> "EnterpriseASPSystem/CompanySetup/WarehousesContactsList",
"short" => "Wa"
],
[
"id" => "CompanySetup/ContactIndustries",
"full" => $translation->translateLabel('Contact Industries'),
"href"=> "EnterpriseASPSystem/CompanySetup/ContactIndustryList",
"short" => "Co"
],
[
"id" => "CompanySetup/ContactRegions",
"full" => $translation->translateLabel('Contact Regions'),
"href"=> "EnterpriseASPSystem/CompanySetup/ContactRegionsList",
"short" => "Co"
],
[
"id" => "CompanySetup/ContactSources",
"full" => $translation->translateLabel('Contact Sources'),
"href"=> "EnterpriseASPSystem/CompanySetup/ContactSourceList",
"short" => "Co"
],
[
"id" => "CompanySetup/ContactTypes",
"full" => $translation->translateLabel('Contact Types'),
"href"=> "EnterpriseASPSystem/CompanySetup/ContactTypeList",
"short" => "Co"
],
[
"id" => "CompanySetup/TranslationTable",
"full" => $translation->translateLabel('Translation Table'),
"href"=> "EnterpriseASPSystem/CompanySetup/Translation",
"short" => "Tr"
],
[
"id" => "CompanySetup/TimeUnits",
"full" => $translation->translateLabel('Time Units'),
"href"=> "EnterpriseASPSystem/CompanySetup/TimeUnitsList",
"short" => "Ti"
],
[
"id" => "SecuritySetup/SecuritySetup",
"full" => $translation->translateLabel('Security Setup'),
"href"=> "EnterpriseASPSystem/CompanySetup/AccessPermissionsList",
"short" => "Se"
],
[
"id" => "SecuritySetup/UnlockRecords",
"full" => $translation->translateLabel('Unlock Records'),
"href"=> "EnterpriseASPSystem/CompanySetup/Unlock",
"short" => "Un"
],
[
"id" => "SecuritySetup/SystemError Log",
"full" => $translation->translateLabel('System Error Log'),
"href"=> "EnterpriseASPSystem/CompanySetup/ErrorLogList",
"short" => "Sy"
],
[
"id" => "SecuritySetup/AuditDescription",
"full" => $translation->translateLabel('Audit Description'),
"href"=> "EnterpriseASPSystem/CompanySetup/AuditTablesDescriptionList",
"short" => "Au"
],
[
"id" => "SecuritySetup/AuditTrail",
"full" => $translation->translateLabel('Audit Trail'),
"href"=> "EnterpriseASPSystem/CompanySetup/AuditTrailList",
"short" => "Au"
],
[
"id" => "SecuritySetup/AuditTrail History",
"full" => $translation->translateLabel('Audit Trail History'),
"href"=> "EnterpriseASPSystem/CompanySetup/AuditTrailHistoryList",
"short" => "Au"
],
[
"id" => "SecuritySetup/AuditLogin",
"full" => $translation->translateLabel('Audit Login'),
"href"=> "EnterpriseASPSystem/CompanySetup/AuditLoginList",
"short" => "Au"
],
[
"id" => "SecuritySetup/AuditLogin History",
"full" => $translation->translateLabel('Audit Login History'),
"href"=> "EnterpriseASPSystem/CompanySetup/AuditLoginHistoryList",
"short" => "Au"
],
[
"id" => "LedgerSetup/Currencies",
"full" => $translation->translateLabel('Currencies'),
"href"=> "EnterpriseASPSystem/CompanySetup/CurrencyTypesList",
"short" => "Cu"
],
[
"id" => "LedgerSetup/ClosePeriod",
"full" => $translation->translateLabel('Close Period'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerPeriodCloseDetail",
"short" => "Cl"
],
[
"id" => "LedgerSetup/CloseYear",
"full" => $translation->translateLabel('Close Year'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerYearCloseDetail",
"short" => "Cl"
],
[
"id" => "LedgerSetup/LedgerTransaction Types",
"full" => $translation->translateLabel('Ledger Transaction Types'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerTransactionTypesList",
"short" => "Le"
],
[
"id" => "LedgerSetup/LedgerBalance Types",
"full" => $translation->translateLabel('Ledger Balance Types'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerBalanceTypeList",
"short" => "Le"
],
[
"id" => "LedgerSetup/LedgerAccount Types",
"full" => $translation->translateLabel('Ledger Account Types'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerAccountTypesList",
"short" => "Le"
],
[
"id" => "LedgerSetup/BankTransaction Types",
"full" => $translation->translateLabel('Bank Transaction Types'),
"href"=> "EnterpriseASPSystem/LedgerSetup/BankTransactionTypesList",
"short" => "Ba"
],
[
"id" => "LedgerSetup/AssetType",
"full" => $translation->translateLabel('Asset Type'),
"href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetTypeList",
"short" => "As"
],
[
"id" => "LedgerSetup/AssetStatus",
"full" => $translation->translateLabel('Asset Status'),
"href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetStatusList",
"short" => "As"
],
[
"id" => "LedgerSetup/DepreciationMethods",
"full" => $translation->translateLabel('Depreciation Methods'),
"href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetDepreciationMethodsList",
"short" => "De"
],
[
"id" => "AccountsReceivable Setup/ARTransaction Types",
"full" => $translation->translateLabel('AR Transaction Types'),
"href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ARTransactionTypesList",
"short" => "AR"
],
[
"id" => "AccountsReceivable Setup/ContractTypes",
"full" => $translation->translateLabel('Contract Types'),
"href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ContractTypesList",
"short" => "Co"
],
[
"id" => "AccountsReceivable Setup/OrderTypes",
"full" => $translation->translateLabel('Order Types'),
"href"=> "EnterpriseASPSystem/AccountsReceivableSetup/OrderTypesList",
"short" => "Or"
],
[
"id" => "AccountsReceivable Setup/ReceiptTypes",
"full" => $translation->translateLabel('Receipt Types'),
"href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ReceiptTypesList",
"short" => "Re"
],
[
"id" => "AccountsReceivable Setup/ReceiptClasses",
"full" => $translation->translateLabel('Receipt Classes'),
"href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ReceiptClassList",
"short" => "Re"
],
[
"id" => "AccountsReceivable Setup/ReceiptMethods",
"full" => $translation->translateLabel('Receipt Methods'),
"href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ReceiptMethodsList",
"short" => "Re"
],
[
"id" => "AccountsReceivable Setup/SalesGroups",
"full" => $translation->translateLabel('Sales Groups'),
"href"=> "EnterpriseASPSystem/AccountsReceivableSetup/SalesGroupList",
"short" => "Sa"
],
[
"id" => "AccountsPayable Setup/APTransaction Types",
"full" => $translation->translateLabel('AP Transaction Types'),
"href"=> "EnterpriseASPSystem/AccountsPayableSetup/APTransactionTypesList",
"short" => "AP"
],
[
"id" => "AccountsPayable Setup/PaymentClasses",
"full" => $translation->translateLabel('Payment Classes'),
"href"=> "EnterpriseASPSystem/AccountsPayableSetup/PaymentClassesList",
"short" => "Pa"
],
[
"id" => "AccountsPayable Setup/PaymentTypes",
"full" => $translation->translateLabel('Payment Types'),
"href"=> "EnterpriseASPSystem/AccountsPayableSetup/PaymentTypesList",
"short" => "Pa"
],
[
"id" => "AccountsPayable Setup/PaymentMethods",
"full" => $translation->translateLabel('Payment Methods'),
"href"=> "EnterpriseASPSystem/AccountsPayableSetup/PaymentMethodsList",
"short" => "Pa"
],
[
"id" => "EDISetup /EDISetup",
"full" => $translation->translateLabel('EDI Setup'),
"href"=> "EnterpriseASPSystem/EDISetup/EDISetupList",
"short" => "ED"
],
[
"id" => "EDISetup /EDIDocument Types",
"full" => $translation->translateLabel('EDI Document Types'),
"href"=> "EnterpriseASPSystem/EDISetup/EDIDocumentTypesList",
"short" => "ED"
],
[
"id" => "EDISetup /EDIDocument Directions",
"full" => $translation->translateLabel('EDI Document Directions'),
"href"=> "EnterpriseASPSystem/EDISetup/EDIDirectionList",
"short" => "ED"
],
[
"id" => "EDISetup /EDIExceptions",
"full" => $translation->translateLabel('EDI Exceptions'),
"href"=> "EnterpriseASPSystem/EDISetup/EDIExceptionsList",
"short" => "ED"
],
[
"id" => "EDISetup /EDIException Types",
"full" => $translation->translateLabel('EDI Exception Types'),
"href"=> "EnterpriseASPSystem/EDISetup/EDIExceptionTypesList",
"short" => "ED"
]
]
];
 ?><?php 
 $menuCategories["Reports"] = [
"type" => "submenu",
"id" => "Reports",
"full" => $translation->translateLabel('Reports'),
"short" => "Re",
"data" => [

[
"id" => "Financials/ExcelWorksheets",
"full" => $translation->translateLabel('Excel Worksheets'),
"href"=> "reports/Worksheets/Worksheet",
"short" => "Ex"
]
]
];
 ?>