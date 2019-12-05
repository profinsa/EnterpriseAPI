<?php
    $departments = $data->getCompanyDailyActivityByDepartments();
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Today's Activity"); ?></h3>
    <!--       <p class="text-muted">this is the sample data</p> --> 
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th></th>
                    <th><?php echo $translation->translateLabel("New Quotes"); ?></th>
                    <th><?php echo $translation->translateLabel("Quote Totals"); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach($departments as $department)
                    foreach($department->Status["quotes"] as $row)
                    echo "<tr><td>{$department->CompanyID} / {$department->DivisionID} / {$department->DepartmentID}</td><td width=\"30%\"><a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/OrderScreens/ViewQuotes") . "&filter=last24\">{$row->Quotes}</a>" . "</td><td width=\"30%\">" . formatField(["format"=>"{0:n}"], $row->QuoteTotals) . "</td></tr>";
                ?>
            </tbody>
        </table>
    </div>
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th></th>
                    <th><?php echo $translation->translateLabel("New Orders"); ?></th>
                    <th><?php echo $translation->translateLabel("Order Totals"); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach($departments as $department)
                    foreach($department->Status["orders"] as $row)
                    echo "<tr><td>{$department->CompanyID} / {$department->DivisionID} / {$department->DepartmentID}</td><td width=\"30%\"><a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/OrderScreens/ViewOrders") . "&filter=last24\">{$row->Orders}</a>" . "</td><td width=\"30%\">" . formatField(["format"=>"{0:n}"], $row->OrderTotals) . "</td></tr>";
                ?>
            </tbody>
        </table>
    </div>
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th></th>
                    <th><?php echo $translation->translateLabel("Shipments Today"); ?></th>
                    <th><?php echo $translation->translateLabel("Shipment Totals"); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach($departments as $department)
                    foreach($department->Status["shipments"] as $row)
                    echo "<tr><td>{$department->CompanyID} / {$department->DivisionID} / {$department->DepartmentID}</td><td width=\"30%\"><a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/OrderScreens/ViewOrders") . "&filter=shiptoday\">{$row->Shipments}</a>" . "</td><td width=\"30%\">" . formatField(["format"=>"{0:n}"], $row->ShipTotals) . "</td></tr>";
                ?>
            </tbody>
        </table>
    </div>
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th></th>
                    <th><?php echo $translation->translateLabel("New Purchases"); ?></th>
                    <th><?php echo $translation->translateLabel("Purchase Totals"); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach($departments as $department)
                    foreach($department->Status["purchases"] as $row)
                    echo "<tr><td>{$department->CompanyID} / {$department->DivisionID} / {$department->DepartmentID}</td><td width=\"30%\"><a href=\"" . $linksMaker->makeGridLink("AccountsPayable/PurchaseProcessing/ViewPurchases") . "&filter=last24\">{$row->Purchases}</a>" . "</td><td width=\"30%\">" . formatField(["format"=>"{0:n}"], $row->PurchaseTotals) . "</td></tr>";
                ?>
            </tbody>
        </table>
    </div>
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th></th>
                    <th><?php echo $translation->translateLabel("Receivings Today"); ?></th>
                    <th><?php echo $translation->translateLabel("Receipt Totals"); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach($departments as $department)
                    foreach($department->Status["receivings"] as $row)
                    echo "<tr><td>{$department->CompanyID} / {$department->DivisionID} / {$department->DepartmentID}</td><td width=\"30%\"><a href=\"" . $linksMaker->makeGridLink("AccountsPayable/PurchaseProcessing/ViewPurchases") . "&filter=receivedtoday\">{$row->Receivings}</a>" . "</td><td width=\"30%\">" . formatField(["format"=>"{0:n}"], $row->ReceiptTotals) . "</td></tr>";
                ?>
            </tbody>
        </table>
    </div>
</div>
