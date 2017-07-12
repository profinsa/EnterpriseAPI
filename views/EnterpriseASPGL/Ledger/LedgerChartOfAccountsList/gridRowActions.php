<?php 
/*
   print button action
 */
//echo json_encode($row);
echo "<a onclick=\"saveToStored('" . $row["GLAccountNumber"] . "')\" data-toggle=\"tooltip\" title=\"Save to Stored Chart Of Accounts\"><span class=\"grid-action-button glyphicon glyphicon-save\" aria-hidden=\"true\"></span></a>";
?>
