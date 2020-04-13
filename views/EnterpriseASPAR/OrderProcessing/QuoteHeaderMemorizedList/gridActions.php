<script>
 function createQuote(){
     var Numbers = [], ind;

     for(ind in gridItemsSelected)
         Numbers.push(gridItemsSelected[ind].OrderNumber);

     serverProcedureCall('Order_CreateFromMemorized', { OrderNumbers :Numbers.join(',') }, true);
 }

</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="createQuote()">
    <?php
	echo $translation->translateLabel("Create Quote");
    ?>
</a>
