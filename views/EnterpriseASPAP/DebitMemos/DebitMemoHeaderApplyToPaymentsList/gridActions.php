<script>
 function ApplyToPayment(){
     var rows = [], ind;
     for(ind in gridItemsSelected){
         gridItemsSelected[ind]["PurchaseNumber"] = "<?php echo $_GET["PurchaseNumber"]; ?>";
         rows.push(gridItemsSelected[ind]);
     }
     
     serverProcedureCall('ApplyToPayment', rows, true, true);
 }
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="ApplyToPayment()">
    <?php
	echo $translation->translateLabel("Apply To Payment");
    ?>
</a>
