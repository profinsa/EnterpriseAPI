<div class="user-profile">
    <div class="dropdown user-pro-body">
        <div><img src="assets/images/stfblogosm.jpg" alt="user-img" class="img-circle"></div>
        <a href="#" class="dropdown-toggle u-dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><?php echo $scope->user["EmployeeUserName"];  ?><span class="caret"></span></a>
        <ul class="dropdown-menu animated flipInY">
            <!-- <li><a href="#"><i class="ti-user"></i> My Profile</a></li>
		 <li><a href="#"><i class="ti-wallet"></i> My Balance</a></li>
		 <li><a href="#"><i class="ti-email"></i> Inbox</a></li>
		 <li role="separator" class="divider"></li>
		 <li><a href="#"><i class="ti-settings"></i> Account Setting</a></li>
		 <li role="separator" class="divider"></li>- -->
            <!-- <li><a href="#"><i class="fa fa-language"></i><?php echo $translation->translateLabel("Language"); ?></a></li>
	    <li>
		<select class="form-control" onclick="event.stopPropagation();" onchange="changeLanguage(event);">
		    <option><?php echo $scope->user["language"]; ?></option>
		    <?php
		    foreach($translation->languages as $value)
			if($value != $scope->user["language"])
			    echo "<option>" . $value . "</option>";
		    ?>
		</select>
	    </li> -->

            <li>
		<a href="javascript:unlockMyRecords();">
                    <?php echo $translation->translateLabel('Release Record Locks'); ?>
		</a>
		<form id="lockData">
		    <input type="hidden" name="category" value="Main" />
		    <input type="hidden" name="EmployeeID"  value="<?php echo $user["EmployeeID"]; ?>" />
		</form>
            </li>
	    <li><a href="index.php?page=index&logout=true"><i class="fa fa-power-off"></i>  <?php echo $translation->translateLabel("Log out"); ?></a></li>
	</ul>
    </div>
</div>
<script>
 function unlockMyRecords(){
     var itemData = $("#lockData");
     $.post("<?php echo $linksMaker->makeProcedureLink("SystemSetup/SecuritySetup/UnlockRecords", "unlockSelected"); ?>", itemData.serialize(), null, 'json').success(function(data){
	 console.log(data);
     })
      .error(function(data){
	  console.log(data);
      });
 }

</script>