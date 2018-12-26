<script>
 /*
    this is actions for BankReconciliation page.
    only client side logic. Sending request to stored procedures and handling result
  */
 function recalcClicked(){
     onlocation(window.location);
 }

 function Post(){
     var itemData = $("#itemData");
     serverProcedureCall('Post', getFormData(itemData), false);
     window.location = linksMaker.makeGridItemView("<?php echo $ascope["path"] ?>", "<?php echo $ascope["item"] ?>", $('li[role="presentation"].active').prop("id"));
 }

</script>
<a class="btn btn-info" href="javascript:;" onclick="recalcClicked()">
    <?php
	echo $translation->translateLabel("Recalc");
    ?>
</a>
<a class="btn btn-info" href="javascript:;" onclick="Post();">
    <?php
	echo $translation->translateLabel("Post");
    ?>
</a>
