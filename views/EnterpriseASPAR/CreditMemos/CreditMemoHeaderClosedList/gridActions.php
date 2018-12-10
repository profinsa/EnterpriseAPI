<script>
function copySelectedToHistory(){
    var InvoiceNumbers = [], ind;
    for(ind in gridItemsSelected)
        InvoiceNumbers.push(gridItemsSelected[ind].InvoiceNumber);

    serverProcedureCall('CopyToHistory', { InvoiceNumbers : InvoiceNumbers.join(',') }, true);
}
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="copySelectedToHistory()">
    <?php
	echo $translation->translateLabel("Copy Selected To History");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="serverProcedureCall('CopyAllToHistory', {}, true);">
    <?php
	echo $translation->translateLabel("Copy All To History");
    ?>
</a>
