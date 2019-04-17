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
	<div class="col-md-2 col-lg-2">
	    <img src="<?php  echo $linksMaker->makeImageLink($header["Picture"]);?>" class="item-header-image" />
	</div>
	<div class="col-md-6 col-lg-6" style="padding:10px;">
	    <div class="item-header-label">
		<?php echo $header["ItemID"]; ?>
	    </div>
	    <div class="item-header-label">
		<?php echo $header["ItemName"]; ?>
	    </div>
	    <div class="item-header-label">
		<?php echo $header["ItemDescription"]; ?>
	    </div>
	</div>
    </div>
<?php endif; ?>
