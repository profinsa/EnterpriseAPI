<?php
    $customersNumbers = $data->customerGetCustomersNumbers();
    $salesNumbers = $data->salesGetNumbers();
    //
?>
<div class="row">
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-success"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/OrderProcessing/ViewOrders") . "&filter=shiptoday\">{$salesNumbers["shiptoday"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Orders shipping today"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-warning"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/OrderProcessing/ViewOrders") . "&filter=shipthismonth\">{$salesNumbers["shipthismonth"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Orders shipping this month"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-danger"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/OrderProcessing/ViewOrders") . "&filter=total\">{$salesNumbers["totalorders"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Total orders"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-info"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/OrderProcessing/ViewOrders") . "&filter=total\">" . formatField(["format"=>"{0:n}"], $salesNumbers["totalordersamount"]) . "</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Total order amount"); ?></span>
                </div>
            </div>  
        </div>
    </div>
</div>
