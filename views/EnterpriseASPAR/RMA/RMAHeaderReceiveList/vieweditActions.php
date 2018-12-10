<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('RMA_Split', { PurchaseNumber : '<?php echo $headerItem["PurchaseNumber"]; ?>'}, true);">
    <?php
	echo $translation->translateLabel("Receive");
    ?>
</a>    
