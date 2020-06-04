<a href="<?php echo $linksMaker->makeDocreportsLink("quote", $row["OrderNumber"]);?>" target="_blank">
    <span class="grid-action-button glyphicon glyphicon-print" aria-hidden="true"></span>
</a>
<a href="javascript:;" onclick="serverProcedureCall('Order_CreateFromQuote', { OrderNumber : '<?php echo $row["OrderNumber"];?>'}, true);" data-toggle="tooltip" title="Create Order">
    <span class="grid-action-button glyphicon glyphicon-log-out" aria-hidden="true"></span>
</a>
