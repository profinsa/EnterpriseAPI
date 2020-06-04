<script>
 function createInvoice(){
     var Numbers = [], ind;

     for(ind in gridItemsSelected)
         Numbers.push(gridItemsSelected[ind].InvoiceNumber);

     serverProcedureCall('Invoice_CreateFromMemorized', { InvoiceNumbers :Numbers.join(',') }, true);
 }

</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="createInvoice()">
    <?php
	echo $translation->translateLabel("Create Invoice");
    ?>
</a>
