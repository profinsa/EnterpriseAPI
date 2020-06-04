<a class="btn btn-info" href="javascript:;" onclick="saveItem(); setTimeout(function(){serverProcedureCall('RMA_Split', { PurchaseNumber : '<?php echo $item["PurchaseNumber"]; ?>'}, true)}, 500);;">
    <?php
	echo $translation->translateLabel("Receive");
    ?>
</a>    
