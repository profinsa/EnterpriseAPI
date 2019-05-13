<script>
 function ApplyToPayment(){
     var rows = [], ind;
     for(ind in gridItemsSelected)
         rows.push(gridItemsSelected[ind]);

     serverProcedureCall('ApplyToPayment', rows, true, true);
 }
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="ApplyToPayment">
    <?php
	echo $translation->translateLabel("Apply To Payment");
    ?>
</a>
