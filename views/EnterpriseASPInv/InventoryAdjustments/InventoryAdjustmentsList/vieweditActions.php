<?php if(!$item["AdjustmentPosted"]): ?>
    <a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Post', { AdjustmentID : '<?php echo $item["AdjustmentID"]; ?>'}, true);">
	<?php
	    echo $translation->translateLabel("Post");
	?>
    </a>    
<?php endif; ?>
