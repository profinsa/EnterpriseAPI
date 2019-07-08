<script>
 function Purchase_Receive_Split(){
     var requestData = {
         header : getCurrentPageValues(),
         detail : gridItems
     };
     console.log(JSON.stringify(requestData, null, 3));
     serverProcedureAnyCall("<?php echo $ascope["path"]; ?>", 'Purchase_Split', requestData, function(data){
         console.log(data);
//	 onlocation(location);
     }, true);
     //serverProcedureCall('Purchase_Split', { PurchaseNumber : '<?php echo $item["PurchaseNumber"]; ?>'}, true);
 }
</script>
<a class="btn btn-info" href="javascript:;" onclick="Purchase_Receive_Split();">
    <?php
	echo $translation->translateLabel("Receive");
    ?>
</a>
