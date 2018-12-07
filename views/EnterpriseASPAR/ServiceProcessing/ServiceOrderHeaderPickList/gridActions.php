<script>
 function fulfillSelected(){
     var OrderNumbers = [], ind;

     for(ind in gridItemsSelected)
         OrderNumbers.push(gridItemsSelected[ind].OrderNumber);

     serverProcedureCall('FulfillServiceRequest', { OrderNumbers :OrderNumbers.join(',') }, true);
 }

</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="fulfillSelected()">
    <?php
	echo $translation->translateLabel("Fulfill Selected Orders");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="serverProcedureCall('FulfillServiceRequestAll', {}, true);">
    <?php
	echo $translation->translateLabel("Fulfill All Orders");
    ?>
</a>