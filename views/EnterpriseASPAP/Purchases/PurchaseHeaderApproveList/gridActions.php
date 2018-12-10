<script>
function approveSelected(){
    var PurchaseNumbers = [], ind;
    for(ind in gridItemsSelected)
        PurchaseNumbers.push(gridItemsSelected[ind].PurchaseNumber);

    serverProcedureCall('Purchase_Approve', { PurchaseNumbers :PurchaseNumbers.join(',') }, true);
}
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="approveSelected()">
    <?php
	echo $translation->translateLabel("Approve Selected");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="serverProcedureCall('Purchase_ApproveAll', {}, true);">
    <?php
	echo $translation->translateLabel("Approve All");
    ?>
</a>
