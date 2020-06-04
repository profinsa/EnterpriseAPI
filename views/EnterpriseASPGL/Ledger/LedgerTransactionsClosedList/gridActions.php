<script>
/*
  this is actions for LedgerTransactionsClosedList page.
  only client side logic. Sending request to stored procedures and handling result
 */
 function copySelectedToHistory(){
     var transactionNumbers = [], ind;
     for(ind in gridItemsSelected)
         transactionNumbers.push(gridItemsSelected[ind].GLTransactionNumber);

     $.post("index.php?page=grid&action=<?php  echo $scope->action;  ?>&procedure=CopyToHistory",{
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
     $.post("index.php?page=grid&action=<?php  echo $scope->action;  ?>&procedure=CopyAllToHistory",{})
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
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="copyAllToHistory()">
    <?php
	echo $translation->translateLabel("Copy All To History");
    ?>
</a>
