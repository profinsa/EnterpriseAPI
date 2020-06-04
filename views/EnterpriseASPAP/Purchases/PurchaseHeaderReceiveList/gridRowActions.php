<a href="javascript:;" onclick="serverProcedureCall('Receiving_Post', { PurchaseNumber : '<?php echo $row["PurchaseNumber"];?>'}, true);" data-toggle="tooltip" title="Receive All Items">
    <span class="grid-action-button glyphicon glyphicon-log-out" aria-hidden="true"></span>
</a>
<a href="<?php echo $linksMaker->makeGridItemEdit($ascope["path"], $keyString);?>" data-toggle="tooltip" title="Partially Receive">
    <span class="grid-action-button glyphicon glyphicon-edit" aria-hidden="true"></span>
</a>
