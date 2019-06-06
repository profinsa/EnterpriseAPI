<script>
function createLedgerTransactions(){
     var Numbers = [], ind;

     for(ind in gridItemsSelected)
         Numbers.push(gridItemsSelected[ind].GLTransactionNumber);

     serverProcedureCall('LedgerTransactions_CreateFromMemorized', { GLTransactionNumbers :Numbers.join(',') }, true);
 }

</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="createLedgerTransactions()">
    <?php
	echo $translation->translateLabel("Create Ledger Transaction");
    ?>
</a>
