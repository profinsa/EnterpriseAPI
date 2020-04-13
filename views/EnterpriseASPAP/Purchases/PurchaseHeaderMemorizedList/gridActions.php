<script>
 function createPurchase(){
     var Numbers = [], ind;

     for(ind in gridItemsSelected)
         Numbers.push(gridItemsSelected[ind].PurchaseNumber);

     serverProcedureCall('Purchase_CreateFromMemorized', { PurchaseNumbers :Numbers.join(',') }, true);
 }

</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="createPurchase()">
    <?php
	echo $translation->translateLabel("Create Purchase");
    ?>
</a>
