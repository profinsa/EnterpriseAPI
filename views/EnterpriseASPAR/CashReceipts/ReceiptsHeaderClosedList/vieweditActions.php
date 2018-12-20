<a class="btn btn-info" href="javascript:;" onclick="callRecalc('<?php echo $headerItem["ReceiptID"]; ?>')" disabled>
    <?php
	echo $translation->translateLabel("Recalc");
    ?>
</a>
<?php if(!$headerItem["Posted"]): ?>
    <a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Post', { ReceiptID : '<?php echo $headerItem["ReceiptID"]; ?>'}, true);" disabled>
	<?php
	    echo $translation->translateLabel("Post");
	?>
    </a>    
<?php else: ?>
    <a class="btn btn-info" href="javascript:;" disabled>
	<?php
	    echo $translation->translateLabel("Post");
	?>
    </a>    
<?php endif; ?>


<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Memorize', { id : '<?php echo $ascope["item"]; ?>', Memorize : '<?php echo $headerItem["Memorize"]; ?>'}, true);">
    <?php
	if(!$headerItem["Memorize"])
	    echo $translation->translateLabel("Memorize");
	else
	    echo $translation->translateLabel("UnMemorize");
    ?>
</a>
