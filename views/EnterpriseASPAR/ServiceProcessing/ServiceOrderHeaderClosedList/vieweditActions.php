<a class="btn btn-info" href="javascript:;" onclick="callRecalc('<?php echo $headerItem["OrderNumber"]; ?>')">
    <?php
	echo $translation->translateLabel("Recalc");
    ?>
</a>
<?php if(!$headerItem["Posted"]): ?>
    <a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Post', { OrderNumber : '<?php echo $headerItem["OrderNumber"]; ?>'}, true);">
	<?php
	    echo $translation->translateLabel("Book Order");
	?>
    </a>    
<?php else: ?>
    <a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('UnPost', { OrderNumber : '<?php echo $headerItem["OrderNumber"]; ?>'}, true);">
	<?php
	    echo $translation->translateLabel("UnBook Order");
	?>
    </a>
<?php endif; ?>
