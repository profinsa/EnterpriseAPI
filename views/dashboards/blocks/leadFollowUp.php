<?php
    $leadFollowUp = $data->LeadFollowUp();
?>
<div class="white-box">
    <h3 class="box-title m-b-0"><?php echo $translation->translateLabel("Follow Up Today"); ?></h3>
    <!-- <p class="text-muted">this is the sample data</p> -->
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th><?php echo $translation->translateLabel("Lead ID"); ?></th>
                    <th><?php echo $translation->translateLabel("Email"); ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach($leadFollowUp as $row){
                        $keyString = "{$user["CompanyID"]}__{$user["DivisionID"]}__{$user["DepartmentID"]}__{$row->LeadID}";
                        echo "<tr><td><a href=\"". $linksMaker->makeGridItemView("CRMHelpDesk/CRM/ViewLeads", $keyString)  . "\">" . $row->LeadID . "</a></td><td>" . $row->LeadEmail . "</td></tr>";
                    }
                ?>
            </tbody>
        </table>
    </div>
</div>
