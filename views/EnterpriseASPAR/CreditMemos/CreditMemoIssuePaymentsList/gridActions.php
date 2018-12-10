<script>
function CreditMemo_CreatePayment(){
    var InvoiceNumbers = [], ind;
    for(ind in gridItemsSelected)
        InvoiceNumbers.push(gridItemsSelected[ind].InvoiceNumber);

    serverProcedureCall('CreditMemo_CreatePayment', { InvoiceNumbers : InvoiceNumbers.join(',') }, true);
}
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="CreditMemo_CreatePayment()">
    <?php
	echo $translation->translateLabel("Issue Payments For Selected");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="serverProcedureCall('CreditMemo_CreatePaymentsForAll', {}, true);">
    <?php
	echo $translation->translateLabel("Issue Payments For All");
    ?>
</a>
