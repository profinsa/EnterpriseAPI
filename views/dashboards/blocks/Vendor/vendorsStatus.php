<?php
    $vendorsNumbers = $data->vendorGetVendorsNumbers();
?>
<div class="row">
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-success"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsPayable/Vendors/ViewVendors") . "&filter=newmonth\">{$vendorsNumbers["newmonth"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("New Vendors This Month"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-warning"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsPayable/Vendors/ViewVendors") . "&filter=newyear\">{$vendorsNumbers["newyear"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("New Vendors This Year"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
       <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-danger"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsPayable/Vendors/ViewVendors") . "&filter=inactive\">{$vendorsNumbers["inactive"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Inactive Vendors"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-info"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsPayable/Vendors/ViewVendors") . "&filter=total\">{$vendorsNumbers["total"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Total Vendors"); ?></span>
                </div>
            </div>  
        </div>
    </div>
</div>
