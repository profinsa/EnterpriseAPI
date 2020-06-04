<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Post', { PaymentID : '<?php echo $headerItem["PaymentID"]; ?>'}, true);">
    <?php
	echo $translation->translateLabel("Post");
    ?>
</a>    

<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Memorize', { id : '<?php echo $ascope["item"]; ?>', Memorize : '<?php echo $headerItem["Memorize"]; ?>'}, true);">
    <?php
	if(!$headerItem["Memorize"])
	    echo $translation->translateLabel("Memorize");
	else
	    echo $translation->translateLabel("UnMemorize");
    ?>
</a>
