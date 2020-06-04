<?php
    $supportNumbers = $data->supportGetNumbers();
?>
<div class="row">
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-success"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("CRMHelpDesk/HelpDesk/ViewSupportRequests") . "&filter=newmonth\">{$supportNumbers["newmonth"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("New Customer Support Requests This Month"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-warning"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("CRMHelpDesk/HelpDesk/ViewSupportRequests") . "&filter=newyear\">{$supportNumbers["newyear"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("New Customer Support Requests This Year"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
       <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-danger"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("CRMHelpDesk/HelpDesk/ViewSupportRequests") . "&filter=resolved\">{$supportNumbers["resolved"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Resolved Customer Support Requests"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-info"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("CRMHelpDesk/HelpDesk/ViewSupportRequests") . "&filter=total\">{$supportNumbers["total"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Total Customer Support Requests"); ?></span>
                </div>
            </div>  
        </div>
    </div>
</div>
