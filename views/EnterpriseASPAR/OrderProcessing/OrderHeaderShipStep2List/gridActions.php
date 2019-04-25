<script>
 function shipSelectedOrders(){
     var rows = [], ind;
     for(ind in gridItemsSelected)
         rows.push(gridItemsSelected[ind]);

     console.log(rows);
     serverProcedureCall('Shipped', rows, true, true);
 }

</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="shipSelectedOrders()">
    <?php
	echo $translation->translateLabel("Ship Selected Orders");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="serverProcedureCall('ShipAll', {}, true);">
    <?php
	echo $translation->translateLabel("Ship All Orders");
    ?>
</a>
