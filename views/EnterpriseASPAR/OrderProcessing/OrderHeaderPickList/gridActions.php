<script>
function pickupSelectedOrders(){
    var OrderNumbers = [], ind;
    for(ind in gridItemsSelected)
        OrderNumbers.push(gridItemsSelected[ind].OrderNumber);

    serverProcedureCall('Picked', { OrderNumbers :OrderNumbers.join(',') }, true);
}
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="pickupSelectedOrders()">
    <?php
	echo $translation->translateLabel("Pick Selected Orders");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="serverProcedureCall('PickAll', {}, true);">
    <?php
	echo $translation->translateLabel("Pick All Orders");
    ?>
</a>
