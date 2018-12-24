<script>
 function Receipt_Cash(){
     var InvoiceNumbers = [], ind;
     for(ind in gridItemsSelected)
         InvoiceNumbers.push(gridItemsSelected[ind].InvoiceNumber);

     serverProcedureCall('Receipt_Cash', { InvoiceNumbers :InvoiceNumbers.join(',') }, true);
 }
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="Receipt_Cash()">
    <?php
	echo $translation->translateLabel("Cash Receipt");
    ?>
</a>
