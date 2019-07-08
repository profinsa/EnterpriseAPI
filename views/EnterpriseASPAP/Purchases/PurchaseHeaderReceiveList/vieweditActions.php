<script>
 function Purchase_Receive_Split(){
     var requestData = {
         header : getCurrentPageValues(),
         detail : gridItems
     };
     console.log(requestData);
     serverProcedureAnyCall("<?php echo $ascope["path"]; ?>", 'Purchase_Split', requestData, function(data){
	 onlocation(location);
     }, true);
 }
</script>
<a class="btn btn-info" href="javascript:;" onclick="Purchase_Receive_Split();">
    <?php
	echo $translation->translateLabel("Receive");
    ?>
</a>
