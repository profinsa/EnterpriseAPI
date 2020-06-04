<script>
 function invoiceSelectedOrders(){
     var OrderNumbers = [], ind;

     for(ind in gridItemsSelected)
         OrderNumbers.push(gridItemsSelected[ind].OrderNumber);

     serverProcedureCall('Invoice_CreateFromOrder', { OrderNumbers :OrderNumbers.join(',') }, true);
 }

</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="invoiceSelectedOrders()">
    <?php
	echo $translation->translateLabel("Invoice Selected Orders");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="serverProcedureCall('Invoice_AllOrders', {}, true);">
    <?php
	echo $translation->translateLabel("Invoice All Orders");
    ?>
</a>