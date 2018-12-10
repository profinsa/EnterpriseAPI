<a class="btn btn-info" href="javascript:;" onclick="callRecalc('<?php echo $headerItem["PurchaseNumber"]; ?>')">
    <?php
	echo $translation->translateLabel("Recalc");
    ?>
</a>
<?php if(!$headerItem["Posted"]): ?>
    <a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Post', { PurchaseNumber : '<?php echo $headerItem["PurchaseNumber"]; ?>'}, true);">
	<?php
	    echo $translation->translateLabel("Book Purchase");
	?>
    </a>    
<?php else: ?>
    <a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('UnPost', { PurchaseNumber : '<?php echo $headerItem["PurchaseNumber"]; ?>'}, true);">
	<?php
	    echo $translation->translateLabel("UnBook Purchase");
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

