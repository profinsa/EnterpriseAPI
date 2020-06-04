<?php
    $financialNumbers = $data->financialGetNumbers();
?>
<div class="row">
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-success"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsPayable/VoucherProcessing/ViewVouchers") . "&filter=duetoday\">{$financialNumbers["today"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Payments Due Today"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-warning"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsPayable/VoucherProcessing/ViewVouchers") . "&filter=duethismonth\">{$financialNumbers["thismonth"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Payments Due This Month"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-danger"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsPayable/VoucherProcessing/ViewVouchers") . "&filter=total\">{$financialNumbers["total"]}</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Total Payments"); ?></span>
                </div>
            </div>  
        </div>
    </div>
    <div class="col-md-3 col-sm-6">
        <div class="white-box">
            <div class="r-icon-stats">
                <i class="ti-user bg-info"></i>
                <div class="bodystate">
                    <h2><?php echo "<a href=\"" . $linksMaker->makeGridLink("AccountsPayable/VoucherProcessing/ViewVouchers") . "&filter=total\">" . formatField(["format"=>"{0:n}"], $financialNumbers["totalamount"]) . "</a>"; ?></h2>
                    <span class="text-muted"><?php echo $translation->translateLabel("Total Amount"); ?></span>
                </div>
            </div>  
        </div>
    </div>
</div>
