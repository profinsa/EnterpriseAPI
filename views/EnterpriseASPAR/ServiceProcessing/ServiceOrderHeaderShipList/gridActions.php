<script>
 function performedSelected(){
     var OrderNumbers = [], ind;

     for(ind in gridItemsSelected)
         OrderNumbers.push(gridItemsSelected[ind].OrderNumber);

     serverProcedureCall('ServicePerformed', { OrderNumbers :OrderNumbers.join(',') }, true);
 }

</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="performedSelected()">
    <?php
	echo $translation->translateLabel("Perform Selected Orders");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="serverProcedureCall('ServicePerformedAll', {}, true);">
    <?php
	echo $translation->translateLabel("Perform All Orders");
    ?>
</a>