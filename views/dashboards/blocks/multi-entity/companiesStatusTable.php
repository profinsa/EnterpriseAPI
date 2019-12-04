<?php
    $companyStatus = $data->CompanyAccountsStatus();
    $statusByDepartments = $data->getAccountsStatusesByDepartments();
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Company Status"); ?></h3>
    <!--       <p class="text-muted">this is the sample data</p> --> 
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th></th>
                    <th><?php echo $translation->translateLabel("Account Type"); ?></th>
                    <th><?php echo $translation->translateLabel("Account Name"); ?></th>
                    <th><?php echo $translation->translateLabel("Account Totals"); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach($statusByDepartments as $department)
                    foreach($department->Status as $row)
                    echo "<tr><td>{$department->CompanyID} / {$department->DivisionID} / {$department->DepartmentID}</td><td>" . $row->GLAccountType . "</td><td>" . $drill->getLinkByAccountNameAndAccountType($row->GLAccountName,$row->GLAccountType,"{$department->CompanyID}__{$department->DivisionID}__{$department->DepartmentID}")  . "</td><td>" . formatField(["format"=>"{0:n}"], $row->Totals) . "</td></tr>";
                ?>
            </tbody>
        </table>
    </div>
</div>
