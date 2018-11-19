<?php 
/*
   print button action
 */
//echo json_encode($row);
echo "<a onclick=\"Customer_CreateFromLead('" . $row["LeadID"] . "')\" data-toggle=\"tooltip\" title=\"Create Customer\"><span class=\"grid-action-button glyphicon glyphicon-log-out\" aria-hidden=\"true\"></span></a>";
?>
