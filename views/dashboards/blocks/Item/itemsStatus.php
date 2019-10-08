<?php
    $itemsNumbers = $data->itemGetItemsNumbers();
?>
<div class="row">
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-success"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("Inventory/ItemsStock/ViewInventoryItems") . "&filter=receivingstoday\">{$itemsNumbers["receivingstoday"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Receivings Today"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-warning"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("Inventory/ItemsStock/ViewInventoryItems") . "&filter=receivingsmonth\">{$itemsNumbers["receivingsmonth"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Receivings This Month"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
       <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-danger"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("Inventory/ItemsStock/ViewInventoryItems") . "&filter=transitstoday\">{$itemsNumbers["transitstoday"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Warehouse In Transits Today"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-info"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("Inventory/ItemsStock/ViewInventoryItems") . "&filter=transitstotal\">{$itemsNumbers["transitstotal"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Warehouse In Transits Total"); ?></span>
                </div>
            </div>  
        </div>
    </div>
</div>
