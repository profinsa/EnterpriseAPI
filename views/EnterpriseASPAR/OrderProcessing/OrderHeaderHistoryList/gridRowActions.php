<?php 
/*
   print button action
 */
//echo json_encode($row);
echo "<a href=\"" . $public_prefix ."/docreports/orderhistory/" . $row["OrderNumber"] ."\" target=\"_blank\"><span class=\"grid-action-button glyphicon glyphicon-print\" aria-hidden=\"true\"></span></a>";
?>
