<?php
$menuCategories["Accounts Receivable"] = [
"type" => "submenu",
"id" => "Accounts Receivable",
"full" => $translation->translateLabel('Accounts Receivable'),
"short" => "Ac",
"data" => [

[
"id" => "Order Processing/View Orders",
"full" => $translation->translateLabel('View Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
"short" => "Vi"
],
[
"id" => "Order Processing/Pick & Pack Orders",
"full" => $translation->translateLabel('Pick & Pack Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderPickList",
"short" => "Pi"
],
[
"id" => "Order Processing/Ship Orders",
"full" => $translation->translateLabel('Ship Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderShipList",
"short" => "Sh"
],
[
"id" => "Order Processing/Invoice Shipped Orders",
"full" => $translation->translateLabel('Invoice Shipped Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderInvoiceList",
"short" => "In"
],
[
"id" => "Order Processing/View Invoices",
"full" => $translation->translateLabel('View Invoices'),
"href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderList",
"short" => "Vi"
],
[
"id" => "Order Screens/View Orders",
"full" => $translation->translateLabel('View Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
"short" => "Vi"
],
[
"id" => "Order Screens/View Closed Orders",
"full" => $translation->translateLabel('View Closed Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderClosedList",
"short" => "Vi"
],
[
"id" => "Order Screens/View Orders History",
"full" => $translation->translateLabel('View Orders History'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "Order Screens/View Orders on Hold",
"full" => $translation->translateLabel('View Orders on Hold'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderHoldList",
"short" => "Vi"
],
[
"id" => "Order Screens/View Orders Tracking",
"full" => $translation->translateLabel('View Orders Tracking'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderTrackingHeaderList",
"short" => "Vi"
],
[
"id" => "Order Screens/View Backorders",
"full" => $translation->translateLabel('View Backorders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderBackList",
"short" => "Vi"
],
[
"id" => "Order Screens/Pick & Pack Orders",
"full" => $translation->translateLabel('Pick & Pack Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderPickList",
"short" => "Pi"
],
[
"id" => "Order Screens/Ship Orders",
"full" => $translation->translateLabel('Ship Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderShipList",
"short" => "Sh"
],
[
"id" => "Order Screens/Invoice Shipped Orders",
"full" => $translation->translateLabel('Invoice Shipped Orders'),
"href"=> "EnterpriseASPAR/OrderProcessing/OrderHeaderInvoiceList",
"short" => "In"
],
[
"id" => "Order Screens/View Invoices",
"full" => $translation->translateLabel('View Invoices'),
"href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderList",
"short" => "Vi"
],
[
"id" => "Order Screens/View Closed Invoices",
"full" => $translation->translateLabel('View Closed Invoices'),
"href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderClosedList",
"short" => "Vi"
],
[
"id" => "Order Screens/View Invoices History",
"full" => $translation->translateLabel('View Invoices History'),
"href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "Order Screens/View Invoices Tracking",
"full" => $translation->translateLabel('View Invoices Tracking'),
"href"=> "EnterpriseASPAR/OrderProcessing/InvoiceTrackingHeaderList",
"short" => "Vi"
],
[
"id" => "Order Screens/Store Invoices",
"full" => $translation->translateLabel('Store Invoices'),
"href"=> "EnterpriseASPAR/OrderProcessing/InvoiceHeaderStoreList",
"short" => "St"
],
[
"id" => "Order Screens/View Quotes",
"full" => $translation->translateLabel('View Quotes'),
"href"=> "EnterpriseASPAR/OrderProcessing/QuoteHeaderList",
"short" => "Vi"
],
[
"id" => "Order Screens/View Quotes Tracking",
"full" => $translation->translateLabel('View Quotes Tracking'),
"href"=> "EnterpriseASPAR/OrderProcessing/QuoteTrackingHeaderList",
"short" => "Vi"
],
[
"id" => "Service Processing/View Service Orders",
"full" => $translation->translateLabel('View Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",
"short" => "Vi"
],
[
"id" => "Service Processing/Fulfill Service Orders",
"full" => $translation->translateLabel('Fulfill Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderPickList",
"short" => "Fu"
],
[
"id" => "Service Processing/Perform Service Orders",
"full" => $translation->translateLabel('Perform Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderShipList",
"short" => "Pe"
],
[
"id" => "Service Processing/Invoice Service Orders",
"full" => $translation->translateLabel('Invoice Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderInvoiceList",
"short" => "In"
],
[
"id" => "Service Processing/View Service Invoices",
"full" => $translation->translateLabel('View Service Invoices'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderList",
"short" => "Vi"
],
[
"id" => "Service Screens/View Service Orders",
"full" => $translation->translateLabel('View Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",
"short" => "Vi"
],
[
"id" => "Service Screens/Service Orders on Hold",
"full" => $translation->translateLabel('Service Orders on Hold'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderHoldList",
"short" => "Se"
],
[
"id" => "Service Screens/Closed Service Orders",
"full" => $translation->translateLabel('Closed Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderClosedList",
"short" => "Cl"
],
[
"id" => "Service Screens/Service Order History",
"full" => $translation->translateLabel('Service Order History'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderHistoryList",
"short" => "Se"
],
[
"id" => "Service Screens/Store Service Orders",
"full" => $translation->translateLabel('Store Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderStoreList",
"short" => "St"
],
[
"id" => "Service Screens/Fulfill Service Orders",
"full" => $translation->translateLabel('Fulfill Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderPickList",
"short" => "Fu"
],
[
"id" => "Service Screens/Perform Service Orders",
"full" => $translation->translateLabel('Perform Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderShipList",
"short" => "Pe"
],
[
"id" => "Service Screens/Invoice Service Orders",
"full" => $translation->translateLabel('Invoice Service Orders'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderInvoiceList",
"short" => "In"
],
[
"id" => "Service Screens/View Service Invoices",
"full" => $translation->translateLabel('View Service Invoices'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderList",
"short" => "Vi"
],
[
"id" => "Service Screens/Closed Service Invoices",
"full" => $translation->translateLabel('Closed Service Invoices'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderClosedList",
"short" => "Cl"
],
[
"id" => "Service Screens/Service Invoice History",
"full" => $translation->translateLabel('Service Invoice History'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderHistoryList",
"short" => "Se"
],
[
"id" => "Service Screens/Store Service Invoices",
"full" => $translation->translateLabel('Store Service Invoices'),
"href"=> "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderStoreList",
"short" => "St"
],
[
"id" => "Projects & Jobs/View Projects",
"full" => $translation->translateLabel('View Projects'),
"href"=> "EnterpriseASPAR/Projects/ProjectsList",
"short" => "Vi"
],
[
"id" => "Projects & Jobs/Project Types",
"full" => $translation->translateLabel('Project Types'),
"href"=> "EnterpriseASPAR/Projects/ProjectTypesList",
"short" => "Pr"
],
[
"id" => "Credit Memos/View Credit Memos",
"full" => $translation->translateLabel('View Credit Memos'),
"href"=> "EnterpriseASPAR/CreditMemos/CreditMemoHeaderList",
"short" => "Vi"
],
[
"id" => "Credit Memos/View Closed Credit Memos",
"full" => $translation->translateLabel('View Closed Credit Memos'),
"href"=> "EnterpriseASPAR/CreditMemos/CreditMemoHeaderClosedList",
"short" => "Vi"
],
[
"id" => "Credit Memos/View Credit Memo History",
"full" => $translation->translateLabel('View Credit Memo History'),
"href"=> "EnterpriseASPAR/CreditMemos/CreditMemoHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "Credit Memos/Store Credit Memos",
"full" => $translation->translateLabel('Store Credit Memos'),
"href"=> "EnterpriseASPAR/CreditMemos/CreditMemoHeaderStoreList",
"short" => "St"
],
[
"id" => "Credit Memos/Issue Payments for Credit Memos",
"full" => $translation->translateLabel('Issue Payments for Credit Memos'),
"href"=> "EnterpriseASPAR/CreditMemos/CreditMemoIssuePaymentsList",
"short" => "Is"
],
[
"id" => "RMA Processing/View RMA",
"full" => $translation->translateLabel('View RMA'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderList",
"short" => "Vi"
],
[
"id" => "RMA Processing/Approve RMA",
"full" => $translation->translateLabel('Approve RMA'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderApproveList",
"short" => "Ap"
],
[
"id" => "RMA Processing/Receive RMA",
"full" => $translation->translateLabel('Receive RMA'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderReceiveList",
"short" => "Re"
],
[
"id" => "RMA Processing/Received RMAs",
"full" => $translation->translateLabel('Received RMA\'s'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderReceivedList",
"short" => "Re"
],
[
"id" => "RMA Screens/View RMA",
"full" => $translation->translateLabel('View RMA'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderList",
"short" => "Vi"
],
[
"id" => "RMA Screens/View Closed RMAs",
"full" => $translation->translateLabel('View Closed RMA\'s'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderClosedList",
"short" => "Vi"
],
[
"id" => "RMA Screens/View RMA History",
"full" => $translation->translateLabel('View RMA History'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "RMA Screens/Store RMAs",
"full" => $translation->translateLabel('Store RMA\'s'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderStoreList",
"short" => "St"
],
[
"id" => "RMA Screens/Approve RMA",
"full" => $translation->translateLabel('Approve RMA'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderApproveList",
"short" => "Ap"
],
[
"id" => "RMA Screens/Receive RMA",
"full" => $translation->translateLabel('Receive RMA'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderReceiveList",
"short" => "Re"
],
[
"id" => "RMA Screens/Received RMAs",
"full" => $translation->translateLabel('Received RMA\'s'),
"href"=> "EnterpriseASPAR/RMA/RMAHeaderReceivedList",
"short" => "Re"
],
[
"id" => "Cash Receipts Processing/View Cash Receipts",
"full" => $translation->translateLabel('View Cash Receipts'),
"href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderList",
"short" => "Vi"
],
[
"id" => "Cash Receipts Processing/Process Cash Receipts",
"full" => $translation->translateLabel('Process Cash Receipts'),
"href"=> "EnterpriseASPAR/CashReceipts/CashReceiptCustomerList",
"short" => "Pr"
],
[
"id" => "Cash Receipts Screens/View Cash Receipts",
"full" => $translation->translateLabel('View Cash Receipts'),
"href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderList",
"short" => "Vi"
],
[
"id" => "Cash Receipts Screens/View Closed Cash Receipts",
"full" => $translation->translateLabel('View Closed Cash Receipts'),
"href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderClosedList",
"short" => "Vi"
],
[
"id" => "Cash Receipts Screens/View Cash Receipts History",
"full" => $translation->translateLabel('View Cash Receipts History'),
"href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "Cash Receipts Screens/Store Cash Receipts",
"full" => $translation->translateLabel('Store Cash Receipts'),
"href"=> "EnterpriseASPAR/CashReceipts/ReceiptsHeaderStoreList",
"short" => "St"
],
[
"id" => "Cash Receipts Screens/Process Cash Receipts",
"full" => $translation->translateLabel('Process Cash Receipts'),
"href"=> "EnterpriseASPAR/CashReceipts/CashReceiptCustomerList",
"short" => "Pr"
],
[
"id" => "Customers/View Customers",
"full" => $translation->translateLabel('View Customers'),
"href"=> "EnterpriseASPAR/Customers/CustomerInformationList",
"short" => "Vi"
],
[
"id" => "Customers/View Customer Financials",
"full" => $translation->translateLabel('View Customer Financials'),
"href"=> "EnterpriseASPAR/Customers/CustomerFinancialsList",
"short" => "Vi"
],
[
"id" => "Customers/View Ship To Locations",
"full" => $translation->translateLabel('View Ship To Locations'),
"href"=> "EnterpriseASPAR/Customers/CustomerShipToLocationsList",
"short" => "Vi"
],
[
"id" => "Customers/View Ship For Locations",
"full" => $translation->translateLabel('View Ship For Locations'),
"href"=> "EnterpriseASPAR/Customers/CustomerShipForLocationsList",
"short" => "Vi"
],
[
"id" => "Customers/View Credit References",
"full" => $translation->translateLabel('View Credit References'),
"href"=> "EnterpriseASPAR/Customers/CustomerCreditReferencesList",
"short" => "Vi"
],
[
"id" => "Customers/View Customer Contacts",
"full" => $translation->translateLabel('View Customer Contacts'),
"href"=> "EnterpriseASPAR/Customers/CustomerContactsList",
"short" => "Vi"
],
[
"id" => "Customers/View Contact Log",
"full" => $translation->translateLabel('View Contact Log'),
"href"=> "EnterpriseASPAR/Customers/CustomerContactLogList",
"short" => "Vi"
],
[
"id" => "Customers/View Comments",
"full" => $translation->translateLabel('View Comments'),
"href"=> "EnterpriseASPAR/Customers/CustomerCommentsList",
"short" => "Vi"
],
[
"id" => "Customers/View Comment Types",
"full" => $translation->translateLabel('View Comment Types'),
"href"=> "EnterpriseASPAR/Customers/CommentTypesList",
"short" => "Vi"
],
[
"id" => "Customers/View Account Status",
"full" => $translation->translateLabel('View Account Status'),
"href"=> "EnterpriseASPAR/Customers/CustomerAccountStatusesList",
"short" => "Vi"
],
[
"id" => "Customers/View Item Xref",
"full" => $translation->translateLabel('View Item Xref'),
"href"=> "EnterpriseASPAR/Customers/CustomerItemCrossReferenceList",
"short" => "Vi"
],
[
"id" => "Customers/View Price Xref",
"full" => $translation->translateLabel('View Price Xref'),
"href"=> "EnterpriseASPAR/Customers/CustomerPriceCrossReferenceList",
"short" => "Vi"
],
[
"id" => "Customers/View Customer References",
"full" => $translation->translateLabel('View Customer References'),
"href"=> "EnterpriseASPAR/Customers/CustomerReferencesList",
"short" => "Vi"
],
[
"id" => "Customers/View Customer Satisfactions",
"full" => $translation->translateLabel('View Customer Satisfactions'),
"href"=> "EnterpriseASPAR/Customers/CustomerSatisfactionList",
"short" => "Vi"
],
[
"id" => "Customers/View Customer Types",
"full" => $translation->translateLabel('View Customer Types'),
"href"=> "EnterpriseASPAR/Customers/CustomerTypesList",
"short" => "Vi"
]
]
];
$menuCategories["Accounts Payable"] = [
"type" => "submenu",
"id" => "Accounts Payable",
"full" => $translation->translateLabel('Accounts Payable'),
"short" => "Ac",
"data" => [

[
"id" => "Purchase Processing/View Purchases",
"full" => $translation->translateLabel('View Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderList",
"short" => "Vi"
],
[
"id" => "Purchase Processing/Approve Purchases",
"full" => $translation->translateLabel('Approve Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderApproveList",
"short" => "Ap"
],
[
"id" => "Purchase Processing/Receive Purchases",
"full" => $translation->translateLabel('Receive Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderReceiveList",
"short" => "Re"
],
[
"id" => "Purchase Processing/View Received Purchases",
"full" => $translation->translateLabel('View Received Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderReceivedList",
"short" => "Vi"
],
[
"id" => "Purchase Screens/View Purchases",
"full" => $translation->translateLabel('View Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderList",
"short" => "Vi"
],
[
"id" => "Purchase Screens/View Closed Purchases",
"full" => $translation->translateLabel('View Closed Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderClosedList",
"short" => "Vi"
],
[
"id" => "Purchase Screens/View Purchases History",
"full" => $translation->translateLabel('View Purchases History'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "Purchase Screens/Store Purchases",
"full" => $translation->translateLabel('Store Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderStoreList",
"short" => "St"
],
[
"id" => "Purchase Screens/Approve Purchases",
"full" => $translation->translateLabel('Approve Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderApproveList",
"short" => "Ap"
],
[
"id" => "Purchase Screens/Receive Purchases",
"full" => $translation->translateLabel('Receive Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderReceiveList",
"short" => "Re"
],
[
"id" => "Purchase Screens/View Received Purchases",
"full" => $translation->translateLabel('View Received Purchases'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseHeaderReceivedList",
"short" => "Vi"
],
[
"id" => "Purchase Contracts/View Purchases Tracking",
"full" => $translation->translateLabel('View Purchases Tracking'),
"href"=> "EnterpriseASPAP/Purchases/PurchaseTrackingHeaderList",
"short" => "Vi"
],
[
"id" => "Purchase Contracts/View Purchase Contracts",
"full" => $translation->translateLabel('View Purchase Contracts'),
"href"=> "EnterpriseASPAP/PurchaseContract/PurchaseContractHeaderList",
"short" => "Vi"
],
[
"id" => "Purchase Contracts/View Purchase Contracts History",
"full" => $translation->translateLabel('View Purchase Contracts History'),
"href"=> "EnterpriseASPAP/PurchaseContract/PurchaseContractHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "Purchase Contracts/View Purchase Contract Ledger",
"full" => $translation->translateLabel('View Purchase Contract Ledger'),
"href"=> "EnterpriseASPAP/PurchaseContract/PurchaseContractLedgerList",
"short" => "Vi"
],
[
"id" => "Purchase Contracts/View Purchase Contract Ledger History",
"full" => $translation->translateLabel('View Purchase Contract Ledger History'),
"href"=> "EnterpriseASPAP/PurchaseContract/PurchaseContractLedgerHistoryList",
"short" => "Vi"
],
[
"id" => "Voucher Processing /View Vouchers",
"full" => $translation->translateLabel('View Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderList",
"short" => "Vi"
],
[
"id" => "Voucher Processing /Approve Vouchers",
"full" => $translation->translateLabel('Approve Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderApproveList",
"short" => "Ap"
],
[
"id" => "Voucher Processing /Issue Vouchers",
"full" => $translation->translateLabel('Issue Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderIssueList",
"short" => "Is"
],
[
"id" => "Voucher Processing /Issue Credit Memos for Vouchers",
"full" => $translation->translateLabel('Issue Credit Memos for Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderIssueCreditMemoList",
"short" => "Is"
],
[
"id" => "Voucher Processing /Three Way Matching",
"full" => $translation->translateLabel('Three Way Matching'),
"href"=> "EnterpriseASPAP/Payments/PaymentsMatching",
"short" => "Th"
],
[
"id" => "Voucher Screens /View Vouchers",
"full" => $translation->translateLabel('View Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderList",
"short" => "Vi"
],
[
"id" => "Voucher Screens /Void Vouchers",
"full" => $translation->translateLabel('Void Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderVoidList",
"short" => "Vo"
],
[
"id" => "Voucher Screens /View Voided Vouchers History",
"full" => $translation->translateLabel('View Voided Vouchers History'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderVoidHistoryList",
"short" => "Vi"
],
[
"id" => "Voucher Screens /View Closed Vouchers",
"full" => $translation->translateLabel('View Closed Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderClosedList",
"short" => "Vi"
],
[
"id" => "Voucher Screens /View Vocuhers History",
"full" => $translation->translateLabel('View Vocuhers History'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "Voucher Screens /Store Vocuhers",
"full" => $translation->translateLabel('Store Vocuhers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderStoreList",
"short" => "St"
],
[
"id" => "Voucher Screens /Approve Vouchers",
"full" => $translation->translateLabel('Approve Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderApproveList",
"short" => "Ap"
],
[
"id" => "Voucher Screens /Issue Payments for Vouchers",
"full" => $translation->translateLabel('Issue Payments for Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderIssueList",
"short" => "Is"
],
[
"id" => "Voucher Screens /Issue Credit Memos for Vouchers",
"full" => $translation->translateLabel('Issue Credit Memos for Vouchers'),
"href"=> "EnterpriseASPAP/Payments/PaymentsHeaderIssueCreditMemoList",
"short" => "Is"
],
[
"id" => "Debit Memos/View Debit Memos",
"full" => $translation->translateLabel('View Debit Memos'),
"href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderList",
"short" => "Vi"
],
[
"id" => "Debit Memos/View Closed Debit Memo",
"full" => $translation->translateLabel('View Closed Debit Memo'),
"href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderClosedList",
"short" => "Vi"
],
[
"id" => "Debit Memos/View Store Debit Memo",
"full" => $translation->translateLabel('View Store Debit Memo'),
"href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderStoreList",
"short" => "Vi"
],
[
"id" => "Debit Memos/View Debit Memo History",
"full" => $translation->translateLabel('View Debit Memo History'),
"href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "Debit Memos/Apply Debit Memos to Payments",
"full" => $translation->translateLabel('Apply Debit Memos to Payments'),
"href"=> "EnterpriseASPAP/DebitMemos/DebitMemoHeaderPaymentsList",
"short" => "Ap"
],
[
"id" => "Return to Vendor Processing/View Returns",
"full" => $translation->translateLabel('View Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
"short" => "Vi"
],
[
"id" => "Return to Vendor Processing/Pick & Pack Returns",
"full" => $translation->translateLabel('Pick & Pack Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderPickList",
"short" => "Pi"
],
[
"id" => "Return to Vendor Processing/Ship Returns",
"full" => $translation->translateLabel('Ship Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderShipList",
"short" => "Sh"
],
[
"id" => "Return to Vendor Processing/Invoice Shipped Returns",
"full" => $translation->translateLabel('Invoice Shipped Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderInvoiceList",
"short" => "In"
],
[
"id" => "Return to Vendor Processing/View Return Invoices",
"full" => $translation->translateLabel('View Return Invoices'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderList",
"short" => "Vi"
],
[
"id" => "Return to Vendor Processing/View Return Cash Receipts",
"full" => $translation->translateLabel('View Return Cash Receipts'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnReceiptsHeaderList",
"short" => "Vi"
],
[
"id" => "Return to Vendor Processing/Process Returns Cash Receipt",
"full" => $translation->translateLabel('Process Returns Cash Receipt'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnCashReceiptVendorList",
"short" => "Pr"
],
[
"id" => "Return to Vendor Screens/View Returns",
"full" => $translation->translateLabel('View Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
"short" => "Vi"
],
[
"id" => "Return to Vendor Screens/View Closed Returns",
"full" => $translation->translateLabel('View Closed Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderClosedList",
"short" => "Vi"
],
[
"id" => "Return to Vendor Screens/View Return History",
"full" => $translation->translateLabel('View Return History'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "Return to Vendor Screens/View Shipped Returns",
"full" => $translation->translateLabel('View Shipped Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderShippedList",
"short" => "Vi"
],
[
"id" => "Return to Vendor Screens/View Store Returns",
"full" => $translation->translateLabel('View Store Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderStoreList",
"short" => "Vi"
],
[
"id" => "Return to Vendor Screens/Pick & Pack Returns",
"full" => $translation->translateLabel('Pick & Pack Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderPickList",
"short" => "Pi"
],
[
"id" => "Return to Vendor Screens/Ship Returns",
"full" => $translation->translateLabel('Ship Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderShipList",
"short" => "Sh"
],
[
"id" => "Return to Vendor Screens/Invoice Shipped Returns",
"full" => $translation->translateLabel('Invoice Shipped Returns'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnHeaderInvoiceList",
"short" => "In"
],
[
"id" => "Return to Vendor Screens/View Return Invoices",
"full" => $translation->translateLabel('View Return Invoices'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderList",
"short" => "Vi"
],
[
"id" => "Return to Vendor Screens/View Store Return Invoices",
"full" => $translation->translateLabel('View Store Return Invoices'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderStoreList",
"short" => "Vi"
],
[
"id" => "Return to Vendor Screens/View Return Cash Receipts",
"full" => $translation->translateLabel('View Return Cash Receipts'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnReceiptsHeaderList",
"short" => "Vi"
],
[
"id" => "Return to Vendor Screens/Process Returns Cash Receipt",
"full" => $translation->translateLabel('Process Returns Cash Receipt'),
"href"=> "EnterpriseASPAP/ReturnToVendor/ReturnCashReceiptVendorList",
"short" => "Pr"
],
[
"id" => "Vendors/View Vendors",
"full" => $translation->translateLabel('View Vendors'),
"href"=> "EnterpriseASPAP/Vendors/VendorInformationList",
"short" => "Vi"
],
[
"id" => "Vendors/View Vendor Financials",
"full" => $translation->translateLabel('View Vendor Financials'),
"href"=> "EnterpriseASPAP/Vendors/VendorFinancialsList",
"short" => "Vi"
],
[
"id" => "Vendors/View Contacts",
"full" => $translation->translateLabel('View Contacts'),
"href"=> "EnterpriseASPAP/Vendors/VendorContactsList",
"short" => "Vi"
],
[
"id" => "Vendors/View Comments",
"full" => $translation->translateLabel('View Comments'),
"href"=> "EnterpriseASPAP/Vendors/VendorCommentsList",
"short" => "Vi"
],
[
"id" => "Vendors/View Account Status",
"full" => $translation->translateLabel('View Account Status'),
"href"=> "EnterpriseASPAP/Vendors/VendorAccountStatusesList",
"short" => "Vi"
],
[
"id" => "Vendors/View Account Types",
"full" => $translation->translateLabel('View Account Types'),
"href"=> "EnterpriseASPAP/Vendors/VendorTypesList",
"short" => "Vi"
],
[
"id" => "Vendors/View Item Xref",
"full" => $translation->translateLabel('View Item Xref'),
"href"=> "EnterpriseASPAP/Vendors/VendorItemCrossReferenceList",
"short" => "Vi"
],
[
"id" => "Vendors/View Price Xref",
"full" => $translation->translateLabel('View Price Xref'),
"href"=> "EnterpriseASPAP/Vendors/VendorPriceCrossReferenceList",
"short" => "Vi"
]
]
];
$menuCategories["General Ledger"] = [
"type" => "submenu",
"id" => "General Ledger",
"full" => $translation->translateLabel('General Ledger'),
"short" => "Ge",
"data" => [

[
"id" => "Ledger/View Chart of Accounts",
"full" => $translation->translateLabel('View Chart of Accounts'),
"href"=> "EnterpriseASPGL/Ledger/LedgerChartOfAccountsList",
"short" => "Vi"
],
[
"id" => "Ledger/View Ledger Account Group",
"full" => $translation->translateLabel('View Ledger Account Group'),
"href"=> "EnterpriseASPGL/Ledger/LedgerAccountGroupList",
"short" => "Vi"
],
[
"id" => "Ledger/View GL Transactions",
"full" => $translation->translateLabel('View GL Transactions'),
"href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsList",
"short" => "Vi"
],
[
"id" => "Ledger/View Closed GL Transactions",
"full" => $translation->translateLabel('View Closed GL Transactions'),
"href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsClosedList",
"short" => "Vi"
],
[
"id" => "Ledger/View GL Transactions History",
"full" => $translation->translateLabel('View GL Transactions History'),
"href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsHistoryList",
"short" => "Vi"
],
[
"id" => "Ledger/Store GL Transactions",
"full" => $translation->translateLabel('Store GL Transactions'),
"href"=> "EnterpriseASPGL/Ledger/LedgerTransactionsStoreList",
"short" => "St"
],
[
"id" => "Ledger/View Budgets",
"full" => $translation->translateLabel('View Budgets'),
"href"=> "EnterpriseASPGL/Ledger/LedgerChartOfAccountsBudgetsList",
"short" => "Vi"
],
[
"id" => "Ledger/View Prior Fiscal Year",
"full" => $translation->translateLabel('View Prior Fiscal Year'),
"href"=> "EnterpriseASPGL/Ledger/LedgerChartOfAccountsPriorYearsList",
"short" => "Vi"
],
[
"id" => "Ledger/Ledger Treeview Sample1",
"full" => $translation->translateLabel('Ledger Treeview Sample1'),
"href"=> "EnterpriseASPGL/Ledger/GLCOATreeView",
"short" => "Le"
],
[
"id" => "Ledger/Ledger Treeview Sample2",
"full" => $translation->translateLabel('Ledger Treeview Sample2'),
"href"=> "EnterpriseASPGL/Ledger/GLCOATreeViewSample2",
"short" => "Le"
],
[
"id" => "Banking/View Bank Accounts",
"full" => $translation->translateLabel('View Bank Accounts'),
"href"=> "EnterpriseASPGL/Banking/BankAccountsList",
"short" => "Vi"
],
[
"id" => "Banking/View Bank Accounts Contacts",
"full" => $translation->translateLabel('View Bank Accounts Contacts'),
"href"=> "EnterpriseASPGL/Banking/BankAccountsContactsList",
"short" => "Vi"
],
[
"id" => "Banking/View Bank Transactions",
"full" => $translation->translateLabel('View Bank Transactions'),
"href"=> "EnterpriseASPGL/Banking/BankTransactionsList",
"short" => "Vi"
],
[
"id" => "Banking/Reconcile Bank Accounts",
"full" => $translation->translateLabel('Reconcile Bank Accounts'),
"href"=> "EnterpriseASPGL/Banking/BankReconciliationList",
"short" => "Re"
],
[
"id" => "Banking/View Bank Reconciliations",
"full" => $translation->translateLabel('View Bank Reconciliations'),
"href"=> "EnterpriseASPGL/Banking/BankReconciliationSummaryList",
"short" => "Vi"
],
[
"id" => "Ledger Setup/Currencies",
"full" => $translation->translateLabel('Currencies'),
"href"=> "EnterpriseASPSystem/CompanySetup/CurrencyTypesList",
"short" => "Cu"
],
[
"id" => "Ledger Setup/Close Period",
"full" => $translation->translateLabel('Close Period'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerPeriodCloseDetail",
"short" => "Cl"
],
[
"id" => "Ledger Setup/Close Year",
"full" => $translation->translateLabel('Close Year'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerYearCloseDetail",
"short" => "Cl"
],
[
"id" => "Ledger Setup/Ledger Transaction Types",
"full" => $translation->translateLabel('Ledger Transaction Types'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerTransactionTypesList",
"short" => "Le"
],
[
"id" => "Ledger Setup/Ledger Balance Types",
"full" => $translation->translateLabel('Ledger Balance Types'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerBalanceTypeList",
"short" => "Le"
],
[
"id" => "Ledger Setup/Ledger Account Types",
"full" => $translation->translateLabel('Ledger Account Types'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerAccountTypesList",
"short" => "Le"
],
[
"id" => "Ledger Setup/Bank Transaction Types",
"full" => $translation->translateLabel('Bank Transaction Types'),
"href"=> "EnterpriseASPSystem/LedgerSetup/BankTransactionTypesList",
"short" => "Ba"
],
[
"id" => "Ledger Setup/Asset Type",
"full" => $translation->translateLabel('Asset Type'),
"href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetTypeList",
"short" => "As"
],
[
"id" => "Ledger Setup/Asset Status",
"full" => $translation->translateLabel('Asset Status'),
"href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetStatusList",
"short" => "As"
],
[
"id" => "Ledger Setup/Depreciation Methods",
"full" => $translation->translateLabel('Depreciation Methods'),
"href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetDepreciationMethodsList",
"short" => "De"
]
]
];
$menuCategories["Inventory"] = [
"type" => "submenu",
"id" => "Inventory",
"full" => $translation->translateLabel('Inventory'),
"short" => "In",
"data" => [

[
"id" => "Items & Stock /View Inventory On-Hand",
"full" => $translation->translateLabel('View Inventory On-Hand'),
"href"=> "EnterpriseASPInv/ItemsStock/InventoryByWarehouseList",
"short" => "Vi"
],
[
"id" => "Items & Stock /View Inventory Items",
"full" => $translation->translateLabel('View Inventory Items'),
"href"=> "EnterpriseASPInv/ItemsStock/InventoryItemsList",
"short" => "Vi"
],
[
"id" => "Items & Stock /View Item Categories",
"full" => $translation->translateLabel('View Item Categories'),
"href"=> "EnterpriseASPInv/ItemsStock/InventoryCategoriesList",
"short" => "Vi"
],
[
"id" => "Items & Stock /View Item Families",
"full" => $translation->translateLabel('View Item Families'),
"href"=> "EnterpriseASPInv/ItemsStock/InventoryFamiliesList",
"short" => "Vi"
],
[
"id" => "Items & Stock /View Item Types",
"full" => $translation->translateLabel('View Item Types'),
"href"=> "EnterpriseASPInv/ItemsStock/InventoryItemTypesList",
"short" => "Vi"
],
[
"id" => "Items & Stock /View Serial Numbers",
"full" => $translation->translateLabel('View Serial Numbers'),
"href"=> "EnterpriseASPInv/ItemsStock/InventorySerialNumbersList",
"short" => "Vi"
],
[
"id" => "Items & Stock /View Pricing Codes",
"full" => $translation->translateLabel('View Pricing Codes'),
"href"=> "EnterpriseASPInv/ItemsStock/InventoryPricingCodeList",
"short" => "Vi"
],
[
"id" => "Items & Stock /View Pricing Methods",
"full" => $translation->translateLabel('View Pricing Methods'),
"href"=> "EnterpriseASPInv/ItemsStock/InventoryPricingMethodsList",
"short" => "Vi"
],
[
"id" => "Inventory Adjustments /View Adjustments",
"full" => $translation->translateLabel('View Adjustments'),
"href"=> "EnterpriseASPInv/InventoryAdjustments/InventoryAdjustmentsList",
"short" => "Vi"
],
[
"id" => "Inventory Adjustments /Inventory Adjustment Types",
"full" => $translation->translateLabel('Inventory Adjustment Types'),
"href"=> "EnterpriseASPInv/InventoryAdjustments/InventoryAdjustmentTypesList",
"short" => "In"
],
[
"id" => "Warehouse Transits/Warehouse Transits",
"full" => $translation->translateLabel('Warehouse Transits'),
"href"=> "EnterpriseASPInv/WarehouseTransit/WarehouseTransitHeaderList",
"short" => "Wa"
],
[
"id" => "Warehouse Transits/Warehouse Transits History",
"full" => $translation->translateLabel('Warehouse Transits History'),
"href"=> "EnterpriseASPInv/WarehouseTransit/WarehouseTransitHeaderHistoryList",
"short" => "Wa"
],
[
"id" => "Shopping Cart Setup/Cart Items Setup",
"full" => $translation->translateLabel('Cart Items Setup'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryCartDetail",
"short" => "Ca"
],
[
"id" => "Shopping Cart Setup/Categories Languages",
"full" => $translation->translateLabel('Categories Languages'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryCategoriesDisplayLangList",
"short" => "Ca"
],
[
"id" => "Shopping Cart Setup/Families Languages",
"full" => $translation->translateLabel('Families Languages'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryFamiliesDisplayLangList",
"short" => "Fa"
],
[
"id" => "Shopping Cart Setup/Items Languages",
"full" => $translation->translateLabel('Items Languages'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryItemsDisplayLangList",
"short" => "It"
],
[
"id" => "Shopping Cart Setup/Items Cross Sell",
"full" => $translation->translateLabel('Items Cross Sell'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryCrossSellingList",
"short" => "It"
],
[
"id" => "Shopping Cart Setup/Items Noticifations",
"full" => $translation->translateLabel('Items Noticifations'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryNoticifationsList",
"short" => "It"
],
[
"id" => "Shopping Cart Setup/Items Relations",
"full" => $translation->translateLabel('Items Relations'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryRelationsList",
"short" => "It"
],
[
"id" => "Shopping Cart Setup/Items Reviews",
"full" => $translation->translateLabel('Items Reviews'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryReviewsList",
"short" => "It"
],
[
"id" => "Shopping Cart Setup/Items Subsitiutions",
"full" => $translation->translateLabel('Items Subsitiutions'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventorySubstitutionsList",
"short" => "It"
],
[
"id" => "Shopping Cart Setup/Items Wish List",
"full" => $translation->translateLabel('Items Wish List'),
"href"=> "EnterpriseASPInv/ShoppingCartSetup/InventoryWishListList",
"short" => "It"
]
]
];
$menuCategories["MRP"] = [
"type" => "submenu",
"id" => "MRP",
"full" => $translation->translateLabel('MRP'),
"short" => "MR",
"data" => [

[
"id" => "Bill of Materials/View Bill Of Materials",
"full" => $translation->translateLabel('View Bill Of Materials'),
"href"=> "EnterpriseASPInv/BillOfMaterials/InventoryAssembliesList",
"short" => "Vi"
],
[
"id" => "Bill of Materials/View Build Instructions",
"full" => $translation->translateLabel('View Build Instructions'),
"href"=> "EnterpriseASPInv/BillOfMaterials/InventoryAssembliesInstructionsList",
"short" => "Vi"
],
[
"id" => "Bill of Materials/Create Inventory",
"full" => $translation->translateLabel('Create Inventory'),
"href"=> "EnterpriseASPInv/BillOfMaterials/InventoryCreateAssembly",
"short" => "Cr"
],
[
"id" => "Work Orders/View Work Orders",
"full" => $translation->translateLabel('View Work Orders'),
"href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderList",
"short" => "Vi"
],
[
"id" => "Work Orders/View Closed Work Orders",
"full" => $translation->translateLabel('View Closed Work Orders'),
"href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderClosedList",
"short" => "Vi"
],
[
"id" => "Work Orders/View Work Orders History",
"full" => $translation->translateLabel('View Work Orders History'),
"href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderHistoryList",
"short" => "Vi"
],
[
"id" => "Work Orders/Store Work Orders",
"full" => $translation->translateLabel('Store Work Orders'),
"href"=> "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderStoreList",
"short" => "St"
],
[
"id" => "MRP Setup/In Progress Types",
"full" => $translation->translateLabel('In Progress Types'),
"href"=> "EnterpriseASPInv/MRPSetup/WorkOrderInProgressList",
"short" => "In"
],
[
"id" => "MRP Setup/Priority Types",
"full" => $translation->translateLabel('Priority Types'),
"href"=> "EnterpriseASPInv/MRPSetup/WorkOrderPriorityList",
"short" => "Pr"
],
[
"id" => "MRP Setup/Work Order Statuses",
"full" => $translation->translateLabel('Work Order Statuses'),
"href"=> "EnterpriseASPInv/MRPSetup/WorkOrderStatusList",
"short" => "Wo"
],
[
"id" => "MRP Setup/Work Order Types",
"full" => $translation->translateLabel('Work Order Types'),
"href"=> "EnterpriseASPInv/MRPSetup/WorkOrderTypesList",
"short" => "Wo"
]
]
];
$menuCategories["Fund Accounting"] = [
"type" => "submenu",
"id" => "Fund Accounting",
"full" => $translation->translateLabel('Fund Accounting'),
"short" => "Fu",
"data" => [
]
];
$menuCategories["CRM & Help Desk"] = [
"type" => "submenu",
"id" => "CRM & Help Desk",
"full" => $translation->translateLabel('CRM & Help Desk'),
"short" => "CR",
"data" => [

[
"id" => "CRM/View Leads",
"full" => $translation->translateLabel('View Leads'),
"href"=> "EnterpriseASPHelpDesk/CRM/LeadInformationList",
"short" => "Vi"
],
[
"id" => "CRM/View Lead Contacts",
"full" => $translation->translateLabel('View Lead Contacts'),
"href"=> "EnterpriseASPHelpDesk/CRM/LeadContactsList",
"short" => "Vi"
],
[
"id" => "CRM/View Lead Comments",
"full" => $translation->translateLabel('View Lead Comments'),
"href"=> "EnterpriseASPHelpDesk/CRM/LeadCommentsList",
"short" => "Vi"
],
[
"id" => "CRM/View Lead Satisfactions",
"full" => $translation->translateLabel('View Lead Satisfactions'),
"href"=> "EnterpriseASPHelpDesk/CRM/LeadSatisfactionList",
"short" => "Vi"
],
[
"id" => "CRM/View Lead Types",
"full" => $translation->translateLabel('View Lead Types'),
"href"=> "EnterpriseASPHelpDesk/CRM/LeadTypeList",
"short" => "Vi"
],
[
"id" => "Help Desk/View News Items",
"full" => $translation->translateLabel('View News Items'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpNewsBoardList",
"short" => "Vi"
],
[
"id" => "Help Desk/View Release Dates",
"full" => $translation->translateLabel('View Release Dates'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpReleaseDatesList",
"short" => "Vi"
],
[
"id" => "Help Desk/View Headings",
"full" => $translation->translateLabel('View Headings'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpMessageHeadingList",
"short" => "Vi"
],
[
"id" => "Help Desk/View Topics",
"full" => $translation->translateLabel('View Topics'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpMessageTopicList",
"short" => "Vi"
],
[
"id" => "Help Desk/View Problem Reports",
"full" => $translation->translateLabel('View Problem Reports'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpProblemReportList",
"short" => "Vi"
],
[
"id" => "Help Desk/View Support Requests",
"full" => $translation->translateLabel('View Support Requests'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSupportRequestList",
"short" => "Vi"
],
[
"id" => "Help Desk/View Resources",
"full" => $translation->translateLabel('View Resources'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpResourcesList",
"short" => "Vi"
],
[
"id" => "Help Desk/View Priorities",
"full" => $translation->translateLabel('View Priorities'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpPriorityList",
"short" => "Vi"
],
[
"id" => "Help Desk/View Problem Types",
"full" => $translation->translateLabel('View Problem Types'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpProblemTypeList",
"short" => "Vi"
],
[
"id" => "Help Desk/View Request Methods",
"full" => $translation->translateLabel('View Request Methods'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpRequestMethodList",
"short" => "Vi"
],
[
"id" => "Help Desk/View Resource Types",
"full" => $translation->translateLabel('View Resource Types'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpResourceTypeList",
"short" => "Vi"
],
[
"id" => "Help Desk/View Severities",
"full" => $translation->translateLabel('View Severities'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSeverityList",
"short" => "Vi"
],
[
"id" => "Help Desk/View Statuses",
"full" => $translation->translateLabel('View Statuses'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpStatusList",
"short" => "Vi"
],
[
"id" => "Help Desk/View Support Types",
"full" => $translation->translateLabel('View Support Types'),
"href"=> "EnterpriseASPHelpDesk/HelpDesk/HelpSupportRequestTypeList",
"short" => "Vi"
]
]
];
$menuCategories["Payroll"] = [
"type" => "submenu",
"id" => "Payroll",
"full" => $translation->translateLabel('Payroll'),
"short" => "Pa",
"data" => [

[
"id" => "Employee Management/View Employees",
"full" => $translation->translateLabel('View Employees'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesList",
"short" => "Vi"
],
[
"id" => "Employee Management/Employee Security",
"full" => $translation->translateLabel('Employee Security'),
"href"=> "EnterpriseASPSystem/CompanySetup/AccessPermissionsList",
"short" => "Em"
],
[
"id" => "Employee Management/Employee Login History",
"full" => $translation->translateLabel('Employee Login History'),
"href"=> "EnterpriseASPSystem/CompanySetup/AuditLoginHistoryList",
"short" => "Em"
],
[
"id" => "Employee Expenses/Expense Reports",
"full" => $translation->translateLabel('Expense Reports'),
"href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportHeaderList",
"short" => "Ex"
],
[
"id" => "Employee Expenses/Expense Reports History",
"full" => $translation->translateLabel('Expense Reports History'),
"href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportHeaderHistoryList",
"short" => "Ex"
],
[
"id" => "Employee Expenses/Expense Report Items",
"full" => $translation->translateLabel('Expense Report Items'),
"href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportItemsList",
"short" => "Ex"
],
[
"id" => "Employee Expenses/Expense Report Reasons",
"full" => $translation->translateLabel('Expense Report Reasons'),
"href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportReasonsList",
"short" => "Ex"
],
[
"id" => "Employee Expenses/Expense Report Types",
"full" => $translation->translateLabel('Expense Report Types'),
"href"=> "EnterpriseASPAP/ExpenseReports/ExpenseReportTypesList",
"short" => "Ex"
],
[
"id" => "Employee Setup/View Employees",
"full" => $translation->translateLabel('View Employees'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesList",
"short" => "Vi"
],
[
"id" => "Employee Setup/Employee Types",
"full" => $translation->translateLabel('Employee Types'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeTypeList",
"short" => "Em"
],
[
"id" => "Employee Setup/Employee Pay Type",
"full" => $translation->translateLabel('Employee Pay Type'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeePayTypeList",
"short" => "Em"
],
[
"id" => "Employee Setup/Employee Pay Frequency",
"full" => $translation->translateLabel('Employee Pay Frequency'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeePayFrequencyList",
"short" => "Em"
],
[
"id" => "Employee Setup/Employee Status",
"full" => $translation->translateLabel('Employee Status'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeStatusList",
"short" => "Em"
],
[
"id" => "Employee Setup/Employee Department",
"full" => $translation->translateLabel('Employee Department'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeDepartmentList",
"short" => "Em"
],
[
"id" => "Employee Setup/View Task List",
"full" => $translation->translateLabel('View Task List'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesTaskHeaderList",
"short" => "Vi"
],
[
"id" => "Employee Setup/View Task Priorities",
"full" => $translation->translateLabel('View Task Priorities'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesTaskPriorityList",
"short" => "Vi"
],
[
"id" => "Employee Setup/View Task Types",
"full" => $translation->translateLabel('View Task Types'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesTaskTypeList",
"short" => "Vi"
],
[
"id" => "Employee Setup/Employee Status Types",
"full" => $translation->translateLabel('Employee Status Types'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeeStatusTypeList",
"short" => "Em"
],
[
"id" => "Employee Setup/View Employee Accruals",
"full" => $translation->translateLabel('View Employee Accruals'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesAccrualList",
"short" => "Vi"
],
[
"id" => "Employee Setup/View Accrual Frequencies",
"full" => $translation->translateLabel('View Accrual Frequencies'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesAccrualFrequencyList",
"short" => "Vi"
],
[
"id" => "Employee Setup/View Accrual Types",
"full" => $translation->translateLabel('View Accrual Types'),
"href"=> "EnterpriseASPPayroll/EmployeeSetup/PayrollEmployeesAccrualTypesList",
"short" => "Vi"
],
[
"id" => "Employee Setup/View Payroll Emails",
"full" => $translation->translateLabel('View Payroll Emails'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmailMessagesList",
"short" => "Vi"
],
[
"id" => "Employee Setup/View Payroll Instant Messages",
"full" => $translation->translateLabel('View Payroll Instant Messages'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollInstantMessagesList",
"short" => "Vi"
],
[
"id" => "Employee Setup/View Employee Emails",
"full" => $translation->translateLabel('View Employee Emails'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeeEmailMessageList",
"short" => "Vi"
],
[
"id" => "Employee Setup/View Employee Instant Messages",
"full" => $translation->translateLabel('View Employee Instant Messages'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeeInstantMessageList",
"short" => "Vi"
],
[
"id" => "Employee Setup/View Employees Calendar",
"full" => $translation->translateLabel('View Employees Calendar'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesCalendarList",
"short" => "Vi"
],
[
"id" => "Employee Setup/View Employees Currently On",
"full" => $translation->translateLabel('View Employees Currently On'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesCurrentlyOnList",
"short" => "Vi"
],
[
"id" => "Employee Setup/View Employees Events",
"full" => $translation->translateLabel('View Employees Events'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesEventsList",
"short" => "Vi"
],
[
"id" => "Employee Setup/View Employees Event Types",
"full" => $translation->translateLabel('View Employees Event Types'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesEventTypesList",
"short" => "Vi"
],
[
"id" => "Employee Setup/View Employees Timesheets",
"full" => $translation->translateLabel('View Employees Timesheets'),
"href"=> "EnterpriseASPPayroll/EmployeeTools/PayrollEmployeesTimesheetHeaderList",
"short" => "Vi"
],
[
"id" => "Payroll Processing/Pay Employees",
"full" => $translation->translateLabel('Pay Employees'),
"href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollPayEmployees",
"short" => "Pa"
],
[
"id" => "Payroll Processing/Payroll Register",
"full" => $translation->translateLabel('Payroll Register'),
"href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollRegisterList",
"short" => "Pa"
],
[
"id" => "Payroll Processing/Payroll Checks",
"full" => $translation->translateLabel('Payroll Checks'),
"href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollChecksList",
"short" => "Pa"
],
[
"id" => "Payroll Processing/Payroll Check Types",
"full" => $translation->translateLabel('Payroll Check Types'),
"href"=> "EnterpriseASPPayroll/PayrollProcessing/PayrollCheckTypeList",
"short" => "Pa"
],
[
"id" => "Payroll Taxes/Payroll Items Master",
"full" => $translation->translateLabel('Payroll Items Master'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollItemsMasterList",
"short" => "Pa"
],
[
"id" => "Payroll Taxes/Payroll Fed Tax",
"full" => $translation->translateLabel('Payroll Fed Tax'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollFedTaxList",
"short" => "Pa"
],
[
"id" => "Payroll Taxes/Payroll Fed Tax Tables",
"full" => $translation->translateLabel('Payroll Fed Tax Tables'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollFedTaxTablesList",
"short" => "Pa"
],
[
"id" => "Payroll Taxes/Payroll State Tax",
"full" => $translation->translateLabel('Payroll State Tax'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollStateTaxList",
"short" => "Pa"
],
[
"id" => "Payroll Taxes/Payroll State Tax Tables",
"full" => $translation->translateLabel('Payroll State Tax Tables'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollStateTaxTablesList",
"short" => "Pa"
],
[
"id" => "Payroll Taxes/Payroll County Tax",
"full" => $translation->translateLabel('Payroll County Tax'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCountyTaxList",
"short" => "Pa"
],
[
"id" => "Payroll Taxes/Payroll County Tax Tables",
"full" => $translation->translateLabel('Payroll County Tax Tables'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCountyTaxTablesList",
"short" => "Pa"
],
[
"id" => "Payroll Taxes/Payroll City Tax",
"full" => $translation->translateLabel('Payroll City Tax'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCityTaxList",
"short" => "Pa"
],
[
"id" => "Payroll Taxes/Payroll City Tax Tables",
"full" => $translation->translateLabel('Payroll City Tax Tables'),
"href"=> "EnterpriseASPPayroll/PayrollTaxes/PayrollCityTaxTablesList",
"short" => "Pa"
],
[
"id" => "Payroll Setup/Payroll Setup",
"full" => $translation->translateLabel('Payroll Setup'),
"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollSetupList",
"short" => "Pa"
],
[
"id" => "Payroll Setup/Payroll Items",
"full" => $translation->translateLabel('Payroll Items'),
"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollItemsList",
"short" => "Pa"
],
[
"id" => "Payroll Setup/Payroll Item Types",
"full" => $translation->translateLabel('Payroll Item Types'),
"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollItemTypesList",
"short" => "Pa"
],
[
"id" => "Payroll Setup/Payroll Item Basis",
"full" => $translation->translateLabel('Payroll Item Basis'),
"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollItemBasisList",
"short" => "Pa"
],
[
"id" => "Payroll Setup/W2 Details",
"full" => $translation->translateLabel('W2 Details'),
"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollW2DetailList",
"short" => "W2"
],
[
"id" => "Payroll Setup/W3 Details",
"full" => $translation->translateLabel('W3 Details'),
"href"=> "EnterpriseASPPayroll/PayrollSetup/PayrollW3DetailList",
"short" => "W3"
]
]
];
$menuCategories["System Setup"] = [
"type" => "submenu",
"id" => "System Setup",
"full" => $translation->translateLabel('System Setup'),
"short" => "Sy",
"data" => [

[
"id" => "Company Setup/Company Setup",
"full" => $translation->translateLabel('Company Setup'),
"href"=> "EnterpriseASPSystem/CompanySetup/CompaniesList",
"short" => "Co"
],
[
"id" => "Company Setup/Company Display Languages",
"full" => $translation->translateLabel('Company Display Languages'),
"href"=> "EnterpriseASPSystem/CompanySetup/CompaniesDisplayLangList",
"short" => "Co"
],
[
"id" => "Company Setup/System Wide Message",
"full" => $translation->translateLabel('System Wide Message'),
"href"=> "EnterpriseASPSystem/CompanySetup/CompaniesSystemWideMessageDetail",
"short" => "Sy"
],
[
"id" => "Company Setup/Company Workflow By Employees",
"full" => $translation->translateLabel('Company Workflow By Employees'),
"href"=> "EnterpriseASPSystem/CompanySetup/CompaniesWorkflowByEmployeesList",
"short" => "Co"
],
[
"id" => "Company Setup/Company Workflow Types",
"full" => $translation->translateLabel('Company Workflow Types'),
"href"=> "EnterpriseASPSystem/CompanySetup/CompaniesWorkFlowTypesList",
"short" => "Co"
],
[
"id" => "Company Setup/Division Setup",
"full" => $translation->translateLabel('Division Setup'),
"href"=> "EnterpriseASPSystem/CompanySetup/DivisionsList",
"short" => "Di"
],
[
"id" => "Company Setup/Department Setup",
"full" => $translation->translateLabel('Department Setup'),
"href"=> "EnterpriseASPSystem/CompanySetup/DepartmentsList",
"short" => "De"
],
[
"id" => "Company Setup/Company ID Numbers",
"full" => $translation->translateLabel('Company ID Numbers'),
"href"=> "EnterpriseASPSystem/CompanySetup/CompaniesNextNumbersList",
"short" => "Co"
],
[
"id" => "Company Setup/Credit Card Types",
"full" => $translation->translateLabel('Credit Card Types'),
"href"=> "EnterpriseASPSystem/CompanySetup/CreditCardTypesList",
"short" => "Cr"
],
[
"id" => "Company Setup/Currencies",
"full" => $translation->translateLabel('Currencies'),
"href"=> "EnterpriseASPSystem/CompanySetup/CurrencyTypesList",
"short" => "Cu"
],
[
"id" => "Company Setup/Tax Items",
"full" => $translation->translateLabel('Tax Items'),
"href"=> "EnterpriseASPSystem/CompanySetup/TaxesList",
"short" => "Ta"
],
[
"id" => "Company Setup/Tax Group Details",
"full" => $translation->translateLabel('Tax Group Details'),
"href"=> "EnterpriseASPSystem/CompanySetup/TaxGroupDetailList",
"short" => "Ta"
],
[
"id" => "Company Setup/Tax Groups",
"full" => $translation->translateLabel('Tax Groups'),
"href"=> "EnterpriseASPSystem/CompanySetup/TaxGroupsList",
"short" => "Ta"
],
[
"id" => "Company Setup/Terms",
"full" => $translation->translateLabel('Terms'),
"href"=> "EnterpriseASPSystem/CompanySetup/TermsList",
"short" => "Te"
],
[
"id" => "Company Setup/POS Setup",
"full" => $translation->translateLabel('POS Setup'),
"href"=> "EnterpriseASPSystem/CompanySetup/POSSetupDetail",
"short" => "PO"
],
[
"id" => "Company Setup/Shipment Methods",
"full" => $translation->translateLabel('Shipment Methods'),
"href"=> "EnterpriseASPSystem/CompanySetup/ShipmentMethodsList",
"short" => "Sh"
],
[
"id" => "Company Setup/Warehouses",
"full" => $translation->translateLabel('Warehouses'),
"href"=> "EnterpriseASPSystem/CompanySetup/WarehousesList",
"short" => "Wa"
],
[
"id" => "Company Setup/Warehouse Bins",
"full" => $translation->translateLabel('Warehouse Bins'),
"href"=> "EnterpriseASPSystem/CompanySetup/WarehouseBinsList",
"short" => "Wa"
],
[
"id" => "Company Setup/Warehouse Bin Types",
"full" => $translation->translateLabel('Warehouse Bin Types'),
"href"=> "EnterpriseASPSystem/CompanySetup/WarehouseBinTypesList",
"short" => "Wa"
],
[
"id" => "Company Setup/Warehouse Bin Zones",
"full" => $translation->translateLabel('Warehouse Bin Zones'),
"href"=> "EnterpriseASPSystem/CompanySetup/WarehouseBinZonesList",
"short" => "Wa"
],
[
"id" => "Company Setup/Warehouse Contacts",
"full" => $translation->translateLabel('Warehouse Contacts'),
"href"=> "EnterpriseASPSystem/CompanySetup/WarehousesContactsList",
"short" => "Wa"
],
[
"id" => "Company Setup/Contact Industries",
"full" => $translation->translateLabel('Contact Industries'),
"href"=> "EnterpriseASPSystem/CompanySetup/ContactIndustryList",
"short" => "Co"
],
[
"id" => "Company Setup/Contact Regions",
"full" => $translation->translateLabel('Contact Regions'),
"href"=> "EnterpriseASPSystem/CompanySetup/ContactRegionsList",
"short" => "Co"
],
[
"id" => "Company Setup/Contact Sources",
"full" => $translation->translateLabel('Contact Sources'),
"href"=> "EnterpriseASPSystem/CompanySetup/ContactSourceList",
"short" => "Co"
],
[
"id" => "Company Setup/Contact Types",
"full" => $translation->translateLabel('Contact Types'),
"href"=> "EnterpriseASPSystem/CompanySetup/ContactTypeList",
"short" => "Co"
],
[
"id" => "Company Setup/Translation Table",
"full" => $translation->translateLabel('Translation Table'),
"href"=> "EnterpriseASPSystem/CompanySetup/Translation",
"short" => "Tr"
],
[
"id" => "Company Setup/Time Units",
"full" => $translation->translateLabel('Time Units'),
"href"=> "EnterpriseASPSystem/CompanySetup/TimeUnitsList",
"short" => "Ti"
],
[
"id" => "Security Setup/Security Setup",
"full" => $translation->translateLabel('Security Setup'),
"href"=> "EnterpriseASPSystem/CompanySetup/AccessPermissionsList",
"short" => "Se"
],
[
"id" => "Security Setup/Unlock Records",
"full" => $translation->translateLabel('Unlock Records'),
"href"=> "EnterpriseASPSystem/CompanySetup/Unlock",
"short" => "Un"
],
[
"id" => "Security Setup/System Error Log",
"full" => $translation->translateLabel('System Error Log'),
"href"=> "EnterpriseASPSystem/CompanySetup/ErrorLogList",
"short" => "Sy"
],
[
"id" => "Security Setup/Audit Description",
"full" => $translation->translateLabel('Audit Description'),
"href"=> "EnterpriseASPSystem/CompanySetup/AuditTablesDescriptionList",
"short" => "Au"
],
[
"id" => "Security Setup/Audit Trail",
"full" => $translation->translateLabel('Audit Trail'),
"href"=> "EnterpriseASPSystem/CompanySetup/AuditTrailList",
"short" => "Au"
],
[
"id" => "Security Setup/Audit Trail History",
"full" => $translation->translateLabel('Audit Trail History'),
"href"=> "EnterpriseASPSystem/CompanySetup/AuditTrailHistoryList",
"short" => "Au"
],
[
"id" => "Security Setup/Audit Login",
"full" => $translation->translateLabel('Audit Login'),
"href"=> "EnterpriseASPSystem/CompanySetup/AuditLoginList",
"short" => "Au"
],
[
"id" => "Security Setup/Audit Login History",
"full" => $translation->translateLabel('Audit Login History'),
"href"=> "EnterpriseASPSystem/CompanySetup/AuditLoginHistoryList",
"short" => "Au"
],
[
"id" => "Ledger Setup/Currencies",
"full" => $translation->translateLabel('Currencies'),
"href"=> "EnterpriseASPSystem/CompanySetup/CurrencyTypesList",
"short" => "Cu"
],
[
"id" => "Ledger Setup/Close Period",
"full" => $translation->translateLabel('Close Period'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerPeriodCloseDetail",
"short" => "Cl"
],
[
"id" => "Ledger Setup/Close Year",
"full" => $translation->translateLabel('Close Year'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerYearCloseDetail",
"short" => "Cl"
],
[
"id" => "Ledger Setup/Ledger Transaction Types",
"full" => $translation->translateLabel('Ledger Transaction Types'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerTransactionTypesList",
"short" => "Le"
],
[
"id" => "Ledger Setup/Ledger Balance Types",
"full" => $translation->translateLabel('Ledger Balance Types'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerBalanceTypeList",
"short" => "Le"
],
[
"id" => "Ledger Setup/Ledger Account Types",
"full" => $translation->translateLabel('Ledger Account Types'),
"href"=> "EnterpriseASPSystem/LedgerSetup/LedgerAccountTypesList",
"short" => "Le"
],
[
"id" => "Ledger Setup/Bank Transaction Types",
"full" => $translation->translateLabel('Bank Transaction Types'),
"href"=> "EnterpriseASPSystem/LedgerSetup/BankTransactionTypesList",
"short" => "Ba"
],
[
"id" => "Ledger Setup/Asset Type",
"full" => $translation->translateLabel('Asset Type'),
"href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetTypeList",
"short" => "As"
],
[
"id" => "Ledger Setup/Asset Status",
"full" => $translation->translateLabel('Asset Status'),
"href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetStatusList",
"short" => "As"
],
[
"id" => "Ledger Setup/Depreciation Methods",
"full" => $translation->translateLabel('Depreciation Methods'),
"href"=> "EnterpriseASPSystem/LedgerSetup/FixedAssetDepreciationMethodsList",
"short" => "De"
],
[
"id" => "Accounts Receivable Setup/AR Transaction Types",
"full" => $translation->translateLabel('AR Transaction Types'),
"href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ARTransactionTypesList",
"short" => "AR"
],
[
"id" => "Accounts Receivable Setup/Contract Types",
"full" => $translation->translateLabel('Contract Types'),
"href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ContractTypesList",
"short" => "Co"
],
[
"id" => "Accounts Receivable Setup/Order Types",
"full" => $translation->translateLabel('Order Types'),
"href"=> "EnterpriseASPSystem/AccountsReceivableSetup/OrderTypesList",
"short" => "Or"
],
[
"id" => "Accounts Receivable Setup/Receipt Types",
"full" => $translation->translateLabel('Receipt Types'),
"href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ReceiptTypesList",
"short" => "Re"
],
[
"id" => "Accounts Receivable Setup/Receipt Classes",
"full" => $translation->translateLabel('Receipt Classes'),
"href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ReceiptClassList",
"short" => "Re"
],
[
"id" => "Accounts Receivable Setup/Receipt Methods",
"full" => $translation->translateLabel('Receipt Methods'),
"href"=> "EnterpriseASPSystem/AccountsReceivableSetup/ReceiptMethodsList",
"short" => "Re"
],
[
"id" => "Accounts Receivable Setup/Sales Groups",
"full" => $translation->translateLabel('Sales Groups'),
"href"=> "EnterpriseASPSystem/AccountsReceivableSetup/SalesGroupList",
"short" => "Sa"
],
[
"id" => "Accounts Payable Setup/AP Transaction Types",
"full" => $translation->translateLabel('AP Transaction Types'),
"href"=> "EnterpriseASPSystem/AccountsPayableSetup/APTransactionTypesList",
"short" => "AP"
],
[
"id" => "Accounts Payable Setup/Payment Classes",
"full" => $translation->translateLabel('Payment Classes'),
"href"=> "EnterpriseASPSystem/AccountsPayableSetup/PaymentClassesList",
"short" => "Pa"
],
[
"id" => "Accounts Payable Setup/Payment Types",
"full" => $translation->translateLabel('Payment Types'),
"href"=> "EnterpriseASPSystem/AccountsPayableSetup/PaymentTypesList",
"short" => "Pa"
],
[
"id" => "Accounts Payable Setup/Payment Methods",
"full" => $translation->translateLabel('Payment Methods'),
"href"=> "EnterpriseASPSystem/AccountsPayableSetup/PaymentMethodsList",
"short" => "Pa"
],
[
"id" => "EDI Setup /EDI Setup",
"full" => $translation->translateLabel('EDI Setup'),
"href"=> "EnterpriseASPSystem/EDISetup/EDISetupList",
"short" => "ED"
],
[
"id" => "EDI Setup /EDI Document Types",
"full" => $translation->translateLabel('EDI Document Types'),
"href"=> "EnterpriseASPSystem/EDISetup/EDIDocumentTypesList",
"short" => "ED"
],
[
"id" => "EDI Setup /EDI Document Directions",
"full" => $translation->translateLabel('EDI Document Directions'),
"href"=> "EnterpriseASPSystem/EDISetup/EDIDirectionList",
"short" => "ED"
],
[
"id" => "EDI Setup /EDI Exceptions",
"full" => $translation->translateLabel('EDI Exceptions'),
"href"=> "EnterpriseASPSystem/EDISetup/EDIExceptionsList",
"short" => "ED"
],
[
"id" => "EDI Setup /EDI Exception Types",
"full" => $translation->translateLabel('EDI Exception Types'),
"href"=> "EnterpriseASPSystem/EDISetup/EDIExceptionTypesList",
"short" => "ED"
]
]
];
$menuCategories["Reports"] = [
"type" => "submenu",
"id" => "Reports",
"full" => $translation->translateLabel('Reports'),
"short" => "Re",
"data" => [

[
"id" => "Financials/Excel Worksheets",
"full" => $translation->translateLabel('Excel Worksheets'),
"href"=> "reports/Worksheets/Worksheet",
"short" => "Ex"
]
]
];
?>