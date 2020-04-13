<?php 
echo "<a href=\"" . $linksMaker->makeGridLink("AccountsReceivable/OrderProcessing/ShipStep2Orders") ."\"><span class=\"grid-action-button glyphicon glyphicon-edit\" aria-hidden=\"true\"></span></a>";
?>
<a href="<?php echo $linksMaker->makeDocreportsLink("order", $row["OrderNumber"]);?>" target="_blank">
    <span class="grid-action-button glyphicon glyphicon-print" aria-hidden="true"></span>
</a>

