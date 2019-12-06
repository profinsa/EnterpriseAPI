<?php
    $departmentsOrders = $data->getTopOrdersReceiptsByDepartments();
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Top 5 Open Orders"); ?></h3>
    <!--  <p class="text-muted">this is the sample data</p> -->
    <div class="table-responsive">
        <div class="panel-group" id="accordion">
            <?php foreach($departmentsOrders as $department): ?>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#<?php echo "{$department->CompanyID}{$department->DivisionID}{$department->DepartmentID}CollapseOrder"; ?>">
                                <?php echo "{$department->CompanyID} / {$department->DivisionID} / {$department->DepartmentID}" ?>
                                
                                <span class="pull-right" style="font-weight:400; margin-right:10px; margin-top:1px;">
                                    Total: <?php echo formatField(["format"=>"{0:n}"], $department->OrdersTotal); ?>
                                </span>
                            </a>
                        </h4>
                    </div>
                    <div id="<?php echo "{$department->CompanyID}{$department->DivisionID}{$department->DepartmentID}CollapseOrder"; ?>" class="panel-collapse collapse">
                        <div class="panel-body">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <!-- <th></th>  -->
                                        <th><?php echo $translation->translateLabel("Order Number"); ?></th>
                                        <th><?php echo $translation->translateLabel("Customer"); ?></th>
                                        <th><?php echo $translation->translateLabel("Ship Date"); ?></th>
                                        <th><?php echo $translation->translateLabel("Amount"); ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                        foreach($department->Status["orders"] as $row)
                                        echo "<tr><!-- <td width=\"25%\">{$department->CompanyID} / {$department->DivisionID} / {$department->DepartmentID}</td> --><td width=\"25%\">" . "<a target=\"_blank\" href=\"" . $linksMaker->makeGridItemView("AccountsReceivable/OrderScreens/ViewOrders", "{$user["CompanyID"]}__{$user["DivisionID"]}__{$user["DepartmentID"]}__{$row->OrderNumber}") . "\">{$row->OrderNumber}</a></td><td width=\"25%\">" . $drill->getLinkByField("CustomerID", $row->CustomerID) . "</td><td width=\"25%\">" . date("m/d/y", strtotime($row->OrderShipDate)) . "</td><td width=\"25%\">" . formatField(["format"=>"{0:n}"], $row->OrderTotal) . "</td></tr>";
                                    ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            <?php endforeach;?>
        </div>
    </div>
</div>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Top 5 Open Receivings"); ?></h3>
    <div class="table-responsive">
        <div class="panel-group" id="accordion">
            <?php foreach($departmentsOrders as $department): ?>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#<?php echo "{$department->CompanyID}{$department->DivisionID}{$department->DepartmentID}CollapseReceipt"; ?>">
                                <?php echo "{$department->CompanyID} / {$department->DivisionID} / {$department->DepartmentID}" ?>
                                
                                <span class="pull-right" style="font-weight:400; margin-right:10px; margin-top:1px;">
                                    Total: <?php echo formatField(["format"=>"{0:n}"], $department->ReceiptsTotal); ?>
                                </span>
                            </a>
                        </h4>
                    </div>
                    <div id="<?php echo "{$department->CompanyID}{$department->DivisionID}{$department->DepartmentID}CollapseReceipt"; ?>" class="panel-collapse collapse">
                        <div class="panel-body">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <!-- <th></th> -->
                                        <th><?php echo $translation->translateLabel("Receiving"); ?></th>
                                        <th><?php echo $translation->translateLabel("Vendor"); ?></th>
                                        <th><?php echo $translation->translateLabel("Arrival Date"); ?></th>
                                        <th><?php echo $translation->translateLabel("Amount"); ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                        foreach($department->Status["purchases"] as $row)
                                        echo "<tr><!-- <td width=\"25%\">{$department->CompanyID} / {$department->DivisionID} / {$department->DepartmentID}</td> --><td width=\"25%\">" . "<a target=\"_blank\" href=\"" . $linksMaker->makeGridItemView("AccountsPayable/PurchaseProcessing/ViewPurchases", "{$user["CompanyID"]}__{$user["DivisionID"]}__{$user["DepartmentID"]}__{$row->PurchaseNumber}") . "\">{$row->PurchaseNumber}</a></td><td width=\"25%\">" . $drill->getLinkByField("VendorID", $row->VendorID) . "</td><td width=\"25%\">" . date("m/d/y", strtotime($row->PurchaseDueDate)) . "</td><td width=\"25%\">" . formatField(["format"=>"{0:n}"], $row->ReceiptTotal) . "</td></tr>";
                                    ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            <?php endforeach;?>
        </div>
    </div>
</div>

