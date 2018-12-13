<script>
 function approveSelected(){
     var PaymentIDs = [], ind;
     for(ind in gridItemsSelected)
         PaymentIDs.push(gridItemsSelected[ind].PaymentID);

     serverProcedureCall('Approve', { PaymentIDs :PaymentIDs.join(',') }, true);
 }
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="approveSelected()">
    <?php
	echo $translation->translateLabel("Approve Selected");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="serverProcedureCall('ApproveAll', {}, true);">
    <?php
	echo $translation->translateLabel("Approve All");
    ?>
</a>
