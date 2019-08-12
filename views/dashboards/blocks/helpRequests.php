<?php
    $requests = $data->helpRequests();
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Help Requests"); ?></h3>
    <!-- <p class="text-muted">this is the sample data</p> -->
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th><?php echo $translation->translateLabel("Customer ID"); ?></th>
                    <th><?php echo $translation->translateLabel("Question"); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach($requests as $row){
                        if($row->CustomerID){
                            $keyString = "{$user["CompanyID"]}__{$user["DivisionID"]}__{$user["DepartmentID"]}__{$row->CaseID}";
                            echo "<tr><td><a href=\"". $linksMaker->makeGridItemView("CRMHelpDesk/HelpDesk/ViewSupportRequests", $keyString)  . "\">" . $row->CustomerID . "</a></td><td>" . $row->SupportQuestion . "</td></tr>";
                        }
                    }
                ?>
            </tbody>
        </table>
    </div>
</div>
