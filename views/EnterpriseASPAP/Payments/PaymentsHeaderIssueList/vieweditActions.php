<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Payment_Split', { PaymentID : $('.PaymentID').val(), Amount : $('.Amount').val()}, true);">
    <?php
	echo $translation->translateLabel("Split");
    ?>
</a>
