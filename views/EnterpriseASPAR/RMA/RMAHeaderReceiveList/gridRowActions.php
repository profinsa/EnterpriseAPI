<a href="<?php echo $linksMaker->makeGridItemEdit($ascope["path"], $keyString); ?>" data-toggle="tooltip" title="Receive">
    <span class="grid-action-button glyphicon glyphicon-edit" aria-hidden="true"></span>
</a>
<a href="javascript:;" onclick="serverProcedureCall('RMAReceiving_Post', { PurchaseNumber : '<?php echo $row["PurchaseNumber"];?>'}, true);" data-toggle="tooltip" title="Receive All">
    <span class="grid-action-button glyphicon glyphicon-log-in" aria-hidden="true"></span>
</a>
