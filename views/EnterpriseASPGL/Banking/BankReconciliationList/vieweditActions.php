<script>
 /*
    this is actions for BankReconciliation page.
    only client side logic. Sending request to stored procedures and handling result
  */
 $('a[data-toggle="tab"]').on('shown', function (e) {
     console.log(e.target) // activated tab
     e.relatedTarget // previous tab
 })
 function recalcClicked(){
     onlocation(linksMaker.makeGridItemView("<?php echo $ascope["path"] ?>", "<?php echo $ascope["item"] ?>", $('li[role="presentation"].active').prop("textContent")));
 }

 function Post(){
     var itemData = $("#itemData");
     serverProcedureCall('Post', getFormData(itemData), false);
     onlocation(linksMaker.makeGridItemView("<?php echo $ascope["path"] ?>", "<?php echo $ascope["item"] ?>", $('li[role="presentation"].active').prop("textContent")));
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
