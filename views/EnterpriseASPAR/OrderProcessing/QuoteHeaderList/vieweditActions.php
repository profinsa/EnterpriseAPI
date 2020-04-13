<a class="btn btn-info" href="javascript:;" onclick="callRecalc('<?php echo $headerItem["OrderNumber"]; ?>')">
    <?php
	echo $translation->translateLabel("Recalc");
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
