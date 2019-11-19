<?php
    $MRPNumbers = $data->MRPGetNumbers();
?>
<div class="row">
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-success"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/Customers/ViewCustomers") . "&filter=completedtoday\">{$MRPNumbers["today"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("New Clients"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-warning"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/Customers/ViewCustomers") . "&filter=completedthismonth\">{$MRPNumbers["thismonth"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Total Clients"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-danger"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/Customers/ViewCustomers") . "&filter=total\">" . formatField(["format"=>"{0:n}"], 2500.99) . "</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Average Client Amount"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-info"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/Customers/ViewCustomers") . "&filter=total\">" . formatField(["format"=>"{0:n}"], 50000.95) . "</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Total Amount Held In Trust"); ?></span>
                </div>
            </div>  
        </div>
    </div>
</div>
