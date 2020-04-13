<?php
    $purchaseNumbers = $data->purchaseGetNumbers();
?>
<div class="row">
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-success"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsPayable/PurchaseProcessing/ViewPurchases") . "&filter=receivingtoday\">{$purchaseNumbers["receivingtoday"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Orders receiving today"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-warning"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsPayable/PurchaseProcessing/ViewPurchases") . "&filter=receivingthismonth\">{$purchaseNumbers["receivingthismonth"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Orders receiving this month"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-danger"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsPayable/PurchaseProcessing/ViewPurchases") . "&filter=total\">{$purchaseNumbers["totalorders"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Total purchase orders"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-info"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsPayable/PurchaseProcessing/ViewPurchases") . "&filter=total\">" . formatField(["format"=>"{0:n}"], $purchaseNumbers["totalordersamount"]) . "</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Total Purchase order amount"); ?></span>
                </div>
            </div>  
        </div>
    </div>
</div>
