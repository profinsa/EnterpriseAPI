<?php
    $topPurchasesPayables = $data->Top10PurchasesPayables();
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Top 10 Open Purchase Orders"); ?></h3>
    <!--  <p class="text-muted">this is the sample data</p> -->
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th><?php echo $translation->translateLabel("Purchase Number"); ?></th>
                    <th><?php echo $translation->translateLabel("Vendor"); ?></th>
                    <th><?php echo $translation->translateLabel("Ship Date"); ?></th>
                    <th><?php echo $translation->translateLabel("Amount"); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach($topPurchasesPayables["orders"] as $row)
                    echo "<tr><td width=\"25%\">" . "<a target=\"_blank\" href=\"" . $linksMaker->makeGridItemView("AccountsPayable/PurchaseProcessing/ViewPurchases", "{$user["CompanyID"]}__{$user["DivisionID"]}__{$user["DepartmentID"]}__{$row->PurchaseNumber}") . "\">{$row->PurchaseNumber}</a></td><td width=\"25%\">" . $drill->getLinkByField("VendorID", $row->VendorID) . "</td><td width=\"25%\">" . date("m/d/y", strtotime($row->PurchaseShipDate)) . "</td><td width=\"25%\">" . formatField(["format"=>"{0:n}"], $row->PurchaseTotal) . "</td></tr>";
                ?>
            </tbody>
        </table>
    </div>
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Top 10 Open Payables"); ?></h3>
    <!--  <p class="text-muted">this is the sample data</p> -->
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th><?php echo $translation->translateLabel("Payment Number"); ?></th>
                    <th><?php echo $translation->translateLabel("Vendor"); ?></th>
                    <th><?php echo $translation->translateLabel("Purchase Date"); ?></th>
                    <th><?php echo $translation->translateLabel("Amount"); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach($topPurchasesPayables["payments"] as $row)
                    echo "<tr><td width=\"25%\">" . "<a target=\"_blank\" href=\"" . $linksMaker->makeGridItemView("AccountsPayable/VoucherProcessing/ViewVouchers", "{$user["CompanyID"]}__{$user["DivisionID"]}__{$user["DepartmentID"]}__{$row->PaymentID}") . "\">{$row->PaymentID}</a></td><td width=\"25%\">" . $drill->getLinkByField("VendorID", $row->VendorID) . "</td><td width=\"25%\">" . date("m/d/y", strtotime($row->PurchaseDate)) . "</td><td width=\"25%\">" . formatField(["format"=>"{0:n}"], $row->PaymentTotal) . "</td></tr>";
                ?>
            </tbody>
        </table>
    </div>
</div>
