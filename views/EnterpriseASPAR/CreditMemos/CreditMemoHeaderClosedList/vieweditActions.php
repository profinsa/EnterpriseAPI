<a class="btn btn-info" href="javascript:;" onclick="callRecalc('<?php echo $headerItem["InvoiceNumber"]; ?>')" disabled>
    <?php
	echo $translation->translateLabel("Recalc");
    ?>
</a>
<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Post', { InvoiceNumber : '<?php echo $headerItem["InvoiceNumber"]; ?>'}, true);" disabled>
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
