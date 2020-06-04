<?php
    $companyStatus = $data->CompanyAccountsStatus();
    $statusByDepartments = $data->getAccountsStatusesByDepartments();
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Detailed Balances"); ?></h3>
    <!--       <p class="text-muted">this is the sample data</p> --> 
    <div class="table-responsive">
        <div class="panel-group" id="accordion">
            <?php foreach($statusByDepartments as $department): ?>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#<?php echo "{$department->CompanyID}{$department->DivisionID}{$department->DepartmentID}CollapseStatus"; ?>">
                                <?php echo "{$department->CompanyID} / {$department->DivisionID} / {$department->DepartmentID}" ?>
                                
                                <span class="pull-right" style="font-weight:400; margin-right:10px; margin-top:1px;">
                                    Total: <?php echo formatField(["format"=>"{0:n}"], $department->Total); ?>
                                </span>
                            </a>
                        </h4>
                    </div>
                    <div id="<?php echo "{$department->CompanyID}{$department->DivisionID}{$department->DepartmentID}CollapseStatus"; ?>" class="panel-collapse collapse">
                        <div class="panel-body">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <!-- <th></th>  -->
                                        <th><?php echo $translation->translateLabel("Account Type"); ?></th>
                                        <th><?php echo $translation->translateLabel("Account Name"); ?></th>
                                        <th><?php echo $translation->translateLabel("Account Totals"); ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php 
                                        foreach($department->Status as $row)
                                        echo "<tr><!-- <td>{$department->CompanyID} / {$department->DivisionID} / {$department->DepartmentID}</td> --><td>" . $row->GLAccountType . "</td><td>" . $drill->getLinkByAccountNameAndAccountType($row->GLAccountName,$row->GLAccountType,"{$department->CompanyID}__{$department->DivisionID}__{$department->DepartmentID}")  . "</td><td>" . formatField(["format"=>"{0:n}"], $row->Totals) . "</td></tr>";
                                        
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
