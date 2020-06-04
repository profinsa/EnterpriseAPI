<?php
    $topTransits = $data->MRPgetTopWarehouseTransits();
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Top Five Warehouse Transits"); ?></h3>
    <!--  <p class="text-muted">this is the sample data</p> -->
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th><?php echo $translation->translateLabel("Transit ID"); ?></th>
                    <th><?php echo $translation->translateLabel("Entered Date"); ?></th>
                    <th><?php echo $translation->translateLabel("Ship Date"); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach($topTransits as $row)
                    echo "<tr><td width=\"25%\">" . "<a target=\"_blank\" href=\"" . $linksMaker->makeGridItemView("Inventory/WarehouseTransits/WarehouseTransits", "{$user["CompanyID"]}__{$user["DivisionID"]}__{$user["DepartmentID"]}__{$row->TransitID}") . "\">{$row->TransitID}</a></td><td width=\"25%\">" . date("m/d/y", strtotime($row->TransitEnteredDate)) . "</td><td width=\"25%\">" . date("m/d/y", strtotime($row->TransitShipDate)) . "</td></tr>";
                ?>
            </tbody>
        </table>
    </div>
</div>

