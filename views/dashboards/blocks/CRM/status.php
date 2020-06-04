<?php
    $leadsNumbers = $data->leadsGetNumbers();
?>
<div class="row">
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-success"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("CRMHelpDesk/CRM/ViewLeads") . "&filter=newmonth\">{$leadsNumbers["newmonth"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("New Leads This Month"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-warning"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("CRMHelpDesk/CRM/ViewLeads") . "&filter=newyear\">{$leadsNumbers["newyear"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("New Leads This Year"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
       <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-danger"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("CRMHelpDesk/CRM/ViewLeads") . "&filter=inactive\">{$leadsNumbers["inactive"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Inactive Leads"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-info"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("CRMHelpDesk/CRM/ViewLeads") . "&filter=total\">{$leadsNumbers["total"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Total Leads"); ?></span>
                </div>
            </div>  
        </div>
    </div>
</div>
