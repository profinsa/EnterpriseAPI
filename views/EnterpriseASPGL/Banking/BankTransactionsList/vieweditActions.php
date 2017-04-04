<script>
/*
  this is actions for BankTransactions page.
  only client side logic. Sending request to stored procedures and handling result
 */
 function post(){
     $.post("index.php?page=grid&action=<?php echo $scope->action ;  ?>&procedure=Post",{
             "BankTransactionID" : "<?php echo $item["BankTransactionID"]; ?>"
      })
         .success(function(data) {
             onlocation(window.location);
         })
         .error(function(err){
             alert('Something goes wrong');
         });
 }
</script>
<a class="btn btn-info" href="javascript:;" onclick="post()">
    <?php
	echo $translation->translateLabel("Post");
    ?>
</a>

