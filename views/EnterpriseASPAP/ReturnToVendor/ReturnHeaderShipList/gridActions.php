<script>
 function shipSelectedOrders(){
     var OrderNumbers = [], ind;

     for(ind in gridItemsSelected)
         OrderNumbers.push(gridItemsSelected[ind].OrderNumber);

     serverProcedureCall('Shipped', { OrderNumbers :OrderNumbers.join(',') }, true);
 }

</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="shipSelectedOrders()">
    <?php
	echo $translation->translateLabel("Ship Selected Returns");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="serverProcedureCall('ShipAll', {}, true);">
    <?php
	echo $translation->translateLabel("Ship All Returns");
    ?>
</a>
