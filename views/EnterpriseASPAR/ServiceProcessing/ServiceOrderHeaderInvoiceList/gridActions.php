<script>
 function invoiceSelected(){
     var OrderNumbers = [], ind;

     for(ind in gridItemsSelected)
         OrderNumbers.push(gridItemsSelected[ind].OrderNumber);

     serverProcedureCall('ServiceInvoice_CreateFromOrder', { OrderNumbers :OrderNumbers.join(',') }, true);
 }

</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="invoiceSelected()">
    <?php
	echo $translation->translateLabel("Invoice Selected");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="serverProcedureCall('Invoice_AllServiceOrders', {}, true);">
    <?php
	echo $translation->translateLabel("Invoice All");
    ?>
</a>