<script>
 function processSelected(){
     var PaymentIDs = [], ind;
     for(ind in gridItemsSelected)
         PaymentIDs.push(gridItemsSelected[ind].PaymentID);

     serverProcedureCall('Process', { PaymentIDs :PaymentIDs.join(',') }, true);
 }
 function printSelected(){
     var PaymentIDs = [], ind;
     if(Object.keys(gridItemsSelected).length)
         redirectBlank(linksMaker.makeDocreportsLink("apcheck", gridItemsSelected[Object.keys(gridItemsSelected)[0]].PaymentID));
     //     for(ind in gridItemsSelected)
     //  PaymentIDs.push(gridItemsSelected[ind].PaymentID);

 }
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="processSelected()">
    <?php
	echo $translation->translateLabel("Process Check");
    ?>
</a>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="printSelected()">
    <?php
	echo $translation->translateLabel("Print Check");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="serverProcedureCall('PaymentCheck_PostAllChecks', {}, true);">
    <?php
	echo $translation->translateLabel("Confirm Check Print");
    ?>
</a>
