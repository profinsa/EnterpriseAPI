<!-- 
     this is actions for BankTransactions page.
     only client side logic. Sending request to stored procedures and handling result
-->
<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Post', { BankTransactionID : '<?php echo $item["BankTransactionID"]; ?>'}, true);">
    <?php
	echo $translation->translateLabel("Post");
    ?>
</a>

