<script>
</script>
<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Purchase_Split', { PurchaseNumber : '<?php echo $headerItem["PurchaseNumber"]; ?>'}, true);">
    <?php
	echo $translation->translateLabel("Receive");
    ?>
</a>
