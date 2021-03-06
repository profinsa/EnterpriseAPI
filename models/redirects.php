<?php
/*
  Name of Page: Redirects provider

  Method: model contains redirects for models and views

  Date created: Nikita Zaharov, 24.01.2020

  Use: 
  Input parameters:

  Output parameters:
  $redirectModel
  $redirectViews

  Called from:
  + controllers/grid.php

  Calls:
  nothing

  Last Modified: 24.01.2020
  Last Modified by: Nikita Zaharov
*/

class redirects {
    public static $Models = [
        "EnterpriseASPAR/OrderProcessing/OrderHeaderSimpleList" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "EnterpriseASPAR/OrderProcessing/OrderHeaderMemorizedList" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "EnterpriseASPAR/OrderProcessing/OrderHeaderClosedList" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "EnterpriseASPAR/OrderProcessing/OrderHeaderBackList" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "EnterpriseASPAR/OrderProcessing/OrderHeaderPickList" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "EnterpriseASPAR/OrderProcessing/OrderHeaderShipList" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "EnterpriseASPAR/OrderProcessing/OrderHeaderShipStep2List" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "EnterpriseASPAR/OrderProcessing/OrderHeaderInvoiceList" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "EnterpriseASPAR/OrderProcessing/OrderHeaderHoldList" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "EnterpriseASPAR/OrderProcessing/OrderHeaderShipDateList" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList",
        "EnterpriseASPAR/OrderProcessing/QuoteHeaderMemorizedList" => "EnterpriseASPAR/OrderProcessing/QuoteHeaderList",

        "EnterpriseASPAR/OrderProcessing/InvoiceHeaderSimpleList" => "EnterpriseASPAR/OrderProcessing/InvoiceHeaderList",
        "EnterpriseASPAR/OrderProcessing/InvoiceHeaderClosedList" => "EnterpriseASPAR/OrderProcessing/InvoiceHeaderList",
        "EnterpriseASPAR/OrderProcessing/InvoiceHeaderMemorizedList" => "EnterpriseASPAR/OrderProcessing/InvoiceHeaderList",

        "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderHoldList" => "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",
        "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderClosedList" => "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",
        "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderPickList" => "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",
        "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderShipList" => "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",
        "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderInvoiceList" => "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList",

        "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderClosedList" => "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderList",

        "EnterpriseASPAR/CreditMemos/CreditMemoHeaderClosedList" => "EnterpriseASPAR/CreditMemos/CreditMemoHeaderList",
        "EnterpriseASPAR/CreditMemos/CreditMemoIssuePaymentsList" => "EnterpriseASPAR/CreditMemos/CreditMemoHeaderList",

        "EnterpriseASPAR/CashReceipts/ReceiptsHeaderClosedList" => "EnterpriseASPAR/CashReceipts/ReceiptsHeaderList",

        "EnterpriseASPAR/RMA/RMAHeaderClosedList" => "EnterpriseASPAR/RMA/RMAHeaderList",
        "EnterpriseASPAR/RMA/RMAHeaderApproveList" => "EnterpriseASPAR/RMA/RMAHeaderList",
        "EnterpriseASPAR/RMA/RMAHeaderReceiveList" => "EnterpriseASPAR/RMA/RMAHeaderList",
        "EnterpriseASPAR/RMA/RMAHeaderReceivedList" => "EnterpriseASPAR/RMA/RMAHeaderList",

        "EnterpriseASPAP/Purchases/PurchaseDetail" => "EnterpriseASPAP/Purchases/PurchaseDetail",
        "EnterpriseASPAP/Purchases/PurchaseHeaderSimpleList" => "EnterpriseASPAP/Purchases/PurchaseHeaderList",
        "EnterpriseASPAP/Purchases/PurchaseHeaderMemorizedList" => "EnterpriseASPAP/Purchases/PurchaseHeaderList",
        "EnterpriseASPAP/Purchases/PurchaseHeaderClosedList" => "EnterpriseASPAP/Purchases/PurchaseHeaderList",
        "EnterpriseASPAP/Purchases/PurchaseHeaderApproveList" => "EnterpriseASPAP/Purchases/PurchaseHeaderList",
        "EnterpriseASPAP/Purchases/PurchaseHeaderReceiveList" => "EnterpriseASPAP/Purchases/PurchaseHeaderList",
        "EnterpriseASPAP/Purchases/PurchaseHeaderReceivedList" => "EnterpriseASPAP/Purchases/PurchaseHeaderList",

        "EnterpriseASPAP/DebitMemos/DebitMemoHeaderClosedList" => "EnterpriseASPAP/DebitMemos/DebitMemoHeaderList",
        "EnterpriseASPAP/DebitMemos/DebitMemoHeaderPaymentsList" => "EnterpriseASPAP/DebitMemos/DebitMemoHeaderList",

        "EnterpriseASPAP/Payments/PaymentsHeaderVoidList" => "EnterpriseASPAP/Payments/PaymentsHeaderList",
        "EnterpriseASPAP/Payments/PaymentsHeaderClosedList" => "EnterpriseASPAP/Payments/PaymentsHeaderList",
        "EnterpriseASPAP/Payments/PaymentsHeaderApproveList" => "EnterpriseASPAP/Payments/PaymentsHeaderList",
        "EnterpriseASPAP/Payments/PaymentsHeaderIssueCreditMemoList" => "EnterpriseASPAP/Payments/PaymentsHeaderList",
        "EnterpriseASPAP/Payments/PaymentsHeaderIssueList" => "EnterpriseASPAP/Payments/PaymentsHeaderList",

        "EnterpriseASPAP/ReturnToVendor/ReturnHeaderPickList" => "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
        "EnterpriseASPAP/ReturnToVendor/ReturnHeaderShipList" => "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
        "EnterpriseASPAP/ReturnToVendor/ReturnHeaderInvoiceList" => "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList",
        "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderClosedList" => "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderList",
        "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderShippedList" => "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderList",
        
        "EnterpriseASPGL/Ledger/LedgerTransactionsClosedList" => "EnterpriseASPGL/Ledger/LedgerTransactionsList",
        "EnterpriseASPGL/Ledger/LedgerTransactionsMemorizedList" => "EnterpriseASPGL/Ledger/LedgerTransactionsList",
        "EnterpriseASPGL/Ledger/LedgerTransactionsHistoryList" => "EnterpriseASPGL/Ledger/LedgerTransactionsList"
    ];

    public static $Views = [
        "EnterpriseASPAR/OrderProcessing/OrderHeaderSimpleList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/simple/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/simple/"
        ],
        "EnterpriseASPAR/OrderProcessing/OrderHeaderMemorizedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/OrderProcessing/OrderHeaderClosedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/OrderProcessing/OrderHeaderHistoryList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/OrderProcessing/OrderHeaderPickList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/OrderProcessing/OrderHeaderShipList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/OrderProcessing/OrderHeaderInvoiceList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/OrderProcessing/OrderHeaderHoldList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/OrderProcessing/OrderHeaderShipDateList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/OrderProcessing/OrderHeaderBackList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/OrderProcessing/QuoteHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/OrderProcessing/QuoteHeaderMemorizedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/OrderProcessing/InvoiceHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/OrderProcessing/InvoiceHeaderSimpleList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/simple/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/simple/"
        ],
        "EnterpriseASPAR/OrderProcessing/InvoiceHeaderMemorizedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/OrderProcessing/InvoiceHeaderClosedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderClosedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderHoldList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderShipList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderPickList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/ServiceProcessing/ServiceOrderHeaderInvoiceList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/OrderProcessing/InvoiceHeaderHistoryList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderClosedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/ServiceProcessing/ServiceInvoiceHeaderHistoryList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/CreditMemos/CreditMemoHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/CreditMemos/CreditMemoHeaderClosedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/CreditMemos/CreditMemoHeaderHistoryList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/RMA/RMAHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/RMA/RMAHeaderClosedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        /*                    "EnterpriseASPAR/RMA/RMAHeaderReceiveList/" => [
                              "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
                              "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
                              ],*/
        "EnterpriseASPAR/RMA/RMAHeaderReceivedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/CashReceipts/ReceiptsHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/CashReceipts/ReceiptsHeaderClosedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAR/CashReceipts/ReceiptsHeaderHistoryList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
            
        "EnterpriseASPAP/Purchases/PurchaseHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/Purchases/PurchaseHeaderSimpleList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/simple/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/simple/"
        ],
        "EnterpriseASPAP/Purchases/PurchaseHeaderMemorizedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/Purchases/PurchaseHeaderClosedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        /*"EnterpriseASPAP/Purchases/PurchaseHeaderReceiveList/" => [
          "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
          "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
          ],*/
        "EnterpriseASPAP/Purchases/PurchaseHeaderReceivedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/PurchaseContract/PurchaseContractHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
            
        "EnterpriseASPAP/DebitMemos/DebitMemoHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/DebitMemos/DebitMemoHeaderClosedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/DebitMemos/DebitMemoHeaderHistoryList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],

        "EnterpriseASPAP/ReturnToVendor/ReturnHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/ReturnToVendor/ReturnHeaderPickList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/ReturnToVendor/ReturnHeaderShipList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/ReturnToVendor/ReturnHeaderInvoiceList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderClosedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderShippedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/ReturnToVendor/ReturnInvoiceHeaderHistoryList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/ReturnToVendor/ReturnReceiptsHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/Payments/PaymentsHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/Payments/PaymentsHeaderVoidList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/Payments/PaymentsHeaderClosedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/Payments/PaymentsHeaderVoidHistoryList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPAP/Payments/PaymentsHeaderHistoryList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],

        "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderClosedList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPInv/WorkOrders/InventoryWorkOrderHeaderHistoryList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPSystem/EDISetup/EDIInvoiceHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPSystem/EDISetup/EDIOrderHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ] ,
        "EnterpriseASPSystem/EDISetup/EDIReceiptsHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPSystem/EDISetup/EDIPurchaseHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ],
        "EnterpriseASPSystem/EDISetup/EDIPaymentsHeaderList/" => [
            "view" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/",
            "edit" => "EnterpriseASPAR/OrderProcessing/OrderHeaderList/"
        ]
    ];
}

?>