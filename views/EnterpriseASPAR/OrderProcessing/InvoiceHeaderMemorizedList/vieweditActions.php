<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('RecalcShipping', { InvoiceNumber : '<?php echo $headerItem["OrderNumber"]; ?>'}, true);">
    <?php
	echo $translation->translateLabel("Recalc Invoice Shipping");
    ?>
</a>

<a class="btn btn-info" href="javascript:;" onclick="callRecalc('<?php echo $headerItem["InvoiceNumber"]; ?>')">
    <?php
	echo $translation->translateLabel("Recalc");
    ?>
</a>

<?php if(!$headerItem["Posted"]): ?>
    <a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Post', { InvoiceNumber : '<?php echo $headerItem["InvoiceNumber"]; ?>'}, true);">
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

