<?php
    $rows[] = $data->adminGetCustomersStatus();
?>
<div class="row">
    <div class="col-md-4 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-success"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("SystemSetup/Admin/AppInstallations") . "&filter=new\">{$rows[0]["new"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("New Customers"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-4 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-warning"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("SystemSetup/Admin/AppInstallations") . "&filter=expiring\">{$rows[0]["expiring"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Expiring Customers"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-4 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-danger"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("SystemSetup/Admin/AppInstallations") . "&filter=expired\">{$rows[0]["expired"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Expired Customers"); ?></span>
                </div>
            </div>  
        </div>
    </div>
</div>

