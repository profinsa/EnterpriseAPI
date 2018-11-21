<?php 
/*
   Company rename button
 */
//echo json_encode($row);
echo "<a onclick=\"companyRename('" . $row["CompanyID"] . "')\" data-toggle=\"tooltip\" title=\"Rename Company\"><span class=\"grid-action-button glyphicon glyphicon-log-out\" aria-hidden=\"true\"></span></a>";
?>
