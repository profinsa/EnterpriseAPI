<script>
/*
  this is actions for LedgerTransactionsClosedList page.
  only client side logic. Sending request to stored procedures and handling result
 */
 function copySelectedToHistory(){
     var transactionNumbers = [], ind;
     for(ind in gridItemsSelected)
         transactionNumbers.push(gridItemsSelected[ind].GLTransactionNumber);
     alert('selected: ' + JSON.stringify(transactionNumbers));
/*     $.post("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"] ;  ?>/procedure/Memorize",{
	 "GLTransactionNumber" : "haha",
	 lom : 12
     })
      .success(function(data) {
	  onlocation(window.location);
	  //	  alert("Memorized");
      })
      .error(function(err){
	  console.log('wrong');
      });*/
 }
 function copyAllToHistory(){
     alert('Copy all');
/*     $.post("<?php echo $public_prefix; ?>/grid/<?php  echo $scope["path"] ;  ?>/procedure/Memorize",{
	 "GLTransactionNumber" : "haha",
	 lom : 12
     })
      .success(function(data) {
	  onlocation(window.location);
	  //	  alert("Memorized");
      })
      .error(function(err){
	  console.log('wrong');
      });*/
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
