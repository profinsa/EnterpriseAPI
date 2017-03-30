<script>
/*
  this is actions for LedgerTransactionsClosedList page.
  only client side logic. Sending request to stored procedures and handling result
 */
 function copySelectedToHistory(){
     var transactionNumbers = [], ind;
     for(ind in gridItemsSelected)
         transactionNumbers.push(gridItemsSelected[ind].GLTransactionNumber);

     $.post("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"] ;  ?>/procedure/CopyToHistory",{
             "GLTransactionNumbers" : transactionNumbers.join(',')
      })
           .success(function(data) {
               onlocation(window.location);
           })
           .error(function(err){
               alert('Something goes wrong');
           });
 }
 function copyAllToHistory(){
     $.post("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"] ;  ?>/procedure/CopyAllToHistory",{})
           .success(function(data) {
               onlocation(window.location);
           })
           .error(function(err){
               alert('Something goes wrong');
           });
 }
</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="copySelectedToHistory()">
    <?php
	echo $translation->translateLabel("Copy Selected To History");
    ?>
</a>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="copyAllToHistory()">
    <?php
	echo $translation->translateLabel("Copy All To History");
    ?>
</a>
