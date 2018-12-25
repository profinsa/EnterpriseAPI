<script>
/*
  this is actions for BankReconciliation page.
  only client side logic. Sending request to stored procedures and handling result
 */
 function recalcClicked(){
     onlocation(window.location);
 }

</script>
<a class="btn btn-info" href="javascript:;" onclick="recalcClicked()">
    <?php
	echo $translation->translateLabel("Recalc");
    ?>
</a>
<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Post', { id : '<?php echo $ascope["item"]; ?>'}, true);">
    <?php
	echo $translation->translateLabel("Post");
    ?>
</a>
