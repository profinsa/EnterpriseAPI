<script>
 function approveSelected(){
     var PaymentIDs = [], ind;
     for(ind in gridItemsSelected)
         PaymentIDs.push(gridItemsSelected[ind].PaymentID);

     serverProcedureCall('Payment_CreateCreditMemo', { PaymentIDs :PaymentIDs.join(',') }, true);
 }
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="approveSelected()">
    <?php
	echo $translation->translateLabel("Issue Credit Memo For Selected");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="serverProcedureCall('Payment_CreateCreditMemoForAll', {}, true);">
    <?php
	echo $translation->translateLabel("Issue Credit Memo For All");
    ?>
</a>
