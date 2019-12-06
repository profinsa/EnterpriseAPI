<?php
    $departments = $data->getTodaysTasksByDepartments();
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Today Tasks"); ?></h3>
    <!-- <p class="text-muted">this is the sample data</p> -->
    <div class="table-responsive">
        <?php foreach($departments as $department): ?>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#<?php echo "{$department->CompanyID}{$department->DivisionID}{$department->DepartmentID}CollapseTasks"; ?>">
                            <?php echo "{$department->CompanyID} / {$department->DivisionID} / {$department->DepartmentID}" ?>
                            
                            <span class="pull-right" style="font-weight:400; margin-right:10px; margin-top:1px;">
                                Total: <?php echo formatField(["format"=>"{0:n}"], $department->Total); ?>
                            </span>
                        </a>
                    </h4>
                </div>
                <div id="<?php echo "{$department->CompanyID}{$department->DivisionID}{$department->DepartmentID}CollapseTasks"; ?>" class="panel-collapse collapse">
                    <div class="panel-body">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <!--  <th></th>-->
                                    <th><?php echo $translation->translateLabel("Due Date"); ?></th>
                                    <th><?php echo $translation->translateLabel("Task ID"); ?></th>
                                    <th><?php echo $translation->translateLabel("Description"); ?></th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                    foreach($department->Status as $row)                    
                                    echo "<tr><!-- <td>{$department->CompanyID} / {$department->DivisionID} / {$department->DepartmentID}</td> --><td><a href=\"" . $linksMaker->makeDashboardLink() . "&screen=Tasks\">" . date("m/d/y", strtotime($row->DueDate)) . "</a></td><td><a href=\"" . $linksMaker->makeDashboardLink() . "&screen=Tasks\">" . $row->Task . "</a></td><td>" . $row->Description . "</td></tr>";
                                    
                                ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        <?php endforeach;?>
    </div>
</div>

