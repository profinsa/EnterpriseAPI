<?php
    $customersNumbers = $data->customerGetCustomersNumbers();
    $vendorsNumbers = $data->vendorGetVendorsNumbers();
    $accountingNumbers = $data->accountingGetNumbers();
    //, , , 
?>
<div class="row">
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-success"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/Customers/ViewCustomers") . "&filter=newmonth\">{$customersNumbers["newmonth"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("New customers"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-warning"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsPayable/Vendors/ViewVendors") . "&filter=newmonth\">{$vendorsNumbers["newmonth"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("New Vendors"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-danger"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/OrderProcessing/ViewInvoices") . "&filter=newmonth\">{$accountingNumbers["newinvoices"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("New Invoices"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-info"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsPayable/PurchaseProcessing/ViewPurchases") . "&filter=newmonth\">{$accountingNumbers["newpurchases"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("New Purchases"); ?></span>
                </div>
            </div>  
        </div>
    </div>
</div>
