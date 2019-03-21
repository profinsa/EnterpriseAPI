<script>
</script>
<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Purchase_Split', { PurchaseNumber : '<?php echo $item["PurchaseNumber"]; ?>'}, true);">
    <?php
	echo $translation->translateLabel("Receive");
    ?>
</a>
