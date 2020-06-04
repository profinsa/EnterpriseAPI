<script>
 function invoiceSelected(){
     var OrderNumbers = [], ind;

     for(ind in gridItemsSelected)
         OrderNumbers.push(gridItemsSelected[ind].OrderNumber);

     serverProcedureCall('ServiceInvoice_CreateFromOrder', { OrderNumbers :OrderNumbers.join(',') }, true);
 }

 function invoiceAll(){
     var OrderNumbers = [], ind;

     for(ind in gridItems)
         OrderNumbers.push(gridItems[ind].OrderNumber);

     serverProcedureCall('ServiceInvoice_CreateFromOrder', { OrderNumbers :OrderNumbers.join(',') }, true);
 }

//serverProcedureCall('Invoice_AllServiceOrders', {}, true);
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="invoiceSelected()">
    <?php
	echo $translation->translateLabel("Invoice Selected");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="invoiceAll();">
    <?php
	echo $translation->translateLabel("Invoice All");
    ?>
</a>