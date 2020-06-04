<?php 
/*
   print button action
 */
//echo json_encode($row);
echo "<a href=\"index.php?page=docreports&type=customertransactions&id=" . $row["CustomerID"] ."\" target=\"_blank\"><span class=\"grid-action-button glyphicon glyphicon-print\" aria-hidden=\"true\"></span></a>";
echo "<a href=\"index.php?page=docreports&type=customerstatements&id=" . $row["CustomerID"] ."\" target=\"_blank\"><span class=\"grid-action-button glyphicon glyphicon-print\" aria-hidden=\"true\"></span></a>";
?>
