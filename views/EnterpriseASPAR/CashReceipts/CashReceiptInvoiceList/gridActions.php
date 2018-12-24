<script>
 function Receipt_Cash(){
     var rows = [], ind;
     for(ind in gridItemsSelected)
         rows.push(gridItemsSelected[ind]);

     serverProcedureCall('Receipt_Cash', rows, true, true);
 }
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="Receipt_Cash()">
    <?php
	echo $translation->translateLabel("Cash Receipt");
    ?>
</a>
