<?php
    $MRPNumbers = $data->MRPGetNumbers();
?>
<div class="row">
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-success"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("MRP/WorkOrders/ViewWorkOrders") . "&filter=completedtoday\">{$MRPNumbers["today"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Work Orders today"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-warning"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("MRP/WorkOrders/ViewWorkOrders") . "&filter=completedthismonth\">{$MRPNumbers["thismonth"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Work Orders this month"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-danger"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("MRP/WorkOrders/ViewWorkOrders") . "&filter=total\">{$MRPNumbers["totalorders"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Total Work Orders"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-info"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("MRP/WorkOrders/ViewWorkOrders") . "&filter=total\">" . formatField(["format"=>"{0:n}"], $MRPNumbers["totalordersamount"]) . "</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Total Work Orders amount"); ?></span>
                </div>
            </div>  
        </div>
    </div>
</div>
