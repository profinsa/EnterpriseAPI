<?php if($ascope["mode"] == 'edit' || $ascope["mode"] == 'view'): ?>
    <?php
	$header = $data->getEditItem($ascope["item"], "Main");
    ?>
    <div class="row">
	<style>
	 .item-header-image {
	     padding : 10px;
	     width:150px;
	     height:150px;
	 }
	 .item-header-label {
	     font-size : 14pt;
	     padding-top : 5px;
	     font-weight : 500;
	 }
	</style>
	<div class="col-md-6 col-lg-6" style="margin-left:10px; padding:10px;">
	    <div class="item-header-label">
		<?php echo $header["GLAccountNumber"]; ?>
	    </div>
	    <div class="item-header-label">
		<?php echo $header["GLAccountName"]; ?>
	    </div>
	    <div class="item-header-label">
		<?php echo $header["GLAccountBalance"]; ?>
	    </div>
	</div>
    </div>
<?php endif; ?>
