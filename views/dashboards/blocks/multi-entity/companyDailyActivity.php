<?php
    $divisions = $data->getCompanyDailyActivityByDepartments();
?>
<div class="white-box">
    <!-- <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Today's Activity"); ?></h3> -->
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("New Quotes"); ?></h3>
    <!--       <p class="text-muted">this is the sample data</p> --> 
    <div class="table-responsive">
        <div class="panel-group" id="accordion">
            <?php foreach($divisions as $division): ?>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#<?php echo "{$division->CompanyID}{$division->DivisionID}CollapseActivityQuotes"; ?>">
                                <?php echo "{$division->CompanyID} / {$division->DivisionID}" ?>
                                
                                <span class="pull-right" style="font-weight:400; margin-right:10px; margin-top:1px;">
                                    <?php echo formatField(["format"=>"{0:n}"], $division->QuotesTotal); ?>
                                </span>
                            </a>
                        </h4>
                    </div>
                    <div id="<?php echo "{$division->CompanyID}{$division->DivisionID}CollapseActivityQuotes"; ?>" class="panel-collapse collapse">
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
                                    foreach($division->departments as $department)
                                    foreach($department->Status["quotes"] as $row)
                                    echo "<tr><td>{$department->DepartmentID}</td><td width=\"30%\"><a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/OrderScreens/ViewQuotes") . "&filter=last24\">{$row->Quotes}</a>" . "</td><td width=\"30%\">" . formatField(["format"=>"{0:n}"], $row->QuoteTotals) . "</td></tr>";
                                ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            <?php endforeach;?>
        </div>
    </div>
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("New Orders"); ?></h3>
    <div class="table-responsive">
        <div class="panel-group" id="accordion">
            <?php foreach($divisions as $division): ?>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#<?php echo "{$division->CompanyID}{$division->DivisionID}CollapseActivityOrders"; ?>">
                                <?php echo "{$division->CompanyID} / {$division->DivisionID}" ?>
                                
                                <span class="pull-right" style="font-weight:400; margin-right:10px; margin-top:1px;">
                                    <?php echo formatField(["format"=>"{0:n}"], $division->OrdersTotal); ?>
                                </span>
                            </a>
                        </h4>
                    </div>
                    <div id="<?php echo "{$division->CompanyID}{$division->DivisionID}CollapseActivityOrders"; ?>" class="panel-collapse collapse">
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
                                    foreach($division->departments as $department)
                                    foreach($department->Status["orders"] as $row)
                                    echo "<tr><td>{$department->DepartmentID}</td><td width=\"30%\"><a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/OrderScreens/ViewOrders") . "&filter=last24\">{$row->Orders}</a>" . "</td><td width=\"30%\">" . formatField(["format"=>"{0:n}"], $row->OrderTotals) . "</td></tr>";
                                ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            <?php endforeach;?>
        </div>
    </div>
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Shipments Today"); ?></h3>
    <div class="table-responsive">
        <div class="panel-group" id="accordion">
            <?php foreach($divisions as $division): ?>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#<?php echo "{$division->CompanyID}{$division->DivisionID}CollapseActivityShipments"; ?>">
                                <?php echo "{$division->CompanyID} / {$division->DivisionID}" ?>
                                
                                <span class="pull-right" style="font-weight:400; margin-right:10px; margin-top:1px;">
                                    <?php echo formatField(["format"=>"{0:n}"], $division->ShipmentsTotal); ?>
                                </span>
                            </a>
                        </h4>
                    </div>
                    <div id="<?php echo "{$division->CompanyID}{$division->DivisionID}CollapseActivityShipments"; ?>" class="panel-collapse collapse">
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
                                    foreach($division->departments as $department)
                                    foreach($department->Status["shipments"] as $row)
                                    echo "<tr><td>{$department->CompanyID} / {$department->DivisionID} / {$department->DepartmentID}</td><td width=\"30%\"><a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/OrderScreens/ViewOrders") . "&filter=shiptoday\">{$row->Shipments}</a>" . "</td><td width=\"30%\">" . formatField(["format"=>"{0:n}"], $row->ShipTotals) . "</td></tr>";
                                ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            <?php endforeach;?>
        </div>
    </div>
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("New Purchases"); ?></h3>
    <div class="table-responsive">
        <div class="panel-group" id="accordion">
            <?php foreach($divisions as $division): ?>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#<?php echo "{$division->CompanyID}{$division->DivisionID}CollapseActivityPurchases"; ?>">
                                <?php echo "{$division->CompanyID} / {$division->DivisionID}" ?>
                                
                                <span class="pull-right" style="font-weight:400; margin-right:10px; margin-top:1px;">
                                    <?php echo formatField(["format"=>"{0:n}"], $division->PurchasesTotal); ?>
                                </span>
                            </a>
                        </h4>
                    </div>
                    <div id="<?php echo "{$division->CompanyID}{$division->DivisionID}CollapseActivityPurchases"; ?>" class="panel-collapse collapse">
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
                                    foreach($division->departments as $department)
                                    foreach($department->Status["purchases"] as $row)
                                    echo "<tr><td>{$department->DepartmentID}</td><td width=\"30%\"><a href=\"" . $linksMaker->makeGridLink("AccountsPayable/PurchaseProcessing/ViewPurchases") . "&filter=last24\">{$row->Purchases}</a>" . "</td><td width=\"30%\">" . formatField(["format"=>"{0:n}"], $row->PurchaseTotals) . "</td></tr>";
                                ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            <?php endforeach;?>
        </div>
    </div>
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Receivings Today"); ?></h3>
    <div class="table-responsive">
        <div class="panel-group" id="accordion">
            <?php foreach($divisions as $division): ?>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#<?php echo "{$division->CompanyID}{$division->DivisionID}CollapseActivityReceivings"; ?>">
                                <?php echo "{$division->CompanyID} / {$division->DivisionID}" ?>
                                
                                <span class="pull-right" style="font-weight:400; margin-right:10px; margin-top:1px;">
                                    <?php echo formatField(["format"=>"{0:n}"], $division->ReceivingsTotal); ?>
                                </span>
                            </a>
                        </h4>
                    </div>
                    <div id="<?php echo "{$division->CompanyID}{$division->DivisionID}CollapseActivityReceivings"; ?>" class="panel-collapse collapse">
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
                                    foreach($division->departments as $department)
                                    foreach($department->Status["receivings"] as $row)
                                    echo "<tr><td>{$department->DepartmentID}</td><td width=\"30%\"><a href=\"" . $linksMaker->makeGridLink("AccountsPayable/PurchaseProcessing/ViewPurchases") . "&filter=receivedtoday\">{$row->Receivings}</a>" . "</td><td width=\"30%\">" . formatField(["format"=>"{0:n}"], $row->ReceiptTotals) . "</td></tr>";
                                ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            <?php endforeach;?>
        </div>
    </div>
</div>
