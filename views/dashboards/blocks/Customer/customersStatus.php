<?php
    $customersNumbers = $data->customerGetCustomersNumbers();
?>
<div class="row">
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-success"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/Customers/ViewCustomers") . "&filter=newmonth\">{$customersNumbers["newmonth"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("New Customers This Month"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-warning"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/Customers/ViewCustomers") . "&filter=newyear\">{$customersNumbers["newyear"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("New Customers This Year"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
       <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-danger"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/Customers/ViewCustomers") . "&filter=inactive\">{$customersNumbers["inactive"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Inactive Customers"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-info"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/Customers/ViewCustomers") . "&filter=total\">{$customersNumbers["total"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Total Customers"); ?></span>
                </div>
            </div>  
        </div>
    </div>
</div>
