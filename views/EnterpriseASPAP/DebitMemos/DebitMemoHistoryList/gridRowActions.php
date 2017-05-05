<?php 
/*
   print button action
 */
//echo json_encode($row);
echo "<a href=\"index.php?page=docreports&type=debitmemohistory&id=" . $row["PurchaseNumber"] ."\" target=\"_blank\"><span class=\"grid-action-button glyphicon glyphicon-print\" aria-hidden=\"true\"></span></a>";
?>
