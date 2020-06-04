<script>
 function createOrder(){
     var Numbers = [], ind;

     for(ind in gridItemsSelected)
         Numbers.push(gridItemsSelected[ind].OrderNumber);

     serverProcedureCall('Order_CreateFromMemorized', { OrderNumbers :Numbers.join(',') }, true);
 }

</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="createOrder()">
    <?php
	echo $translation->translateLabel("Create Order");
    ?>
</a>
