<!-- Top Navigation -->
<nav class="navbar navbar-default navbar-static-top m-b-0">
    <div class="navbar-header"> 
	<a class="navbar-toggle hidden-sm hidden-md hidden-lg " href="javascript:void(0)" data-toggle="collapse" data-target=".navbar-collapse"><i class="ti-menu"></i></a>
	<div class="top-left-part">
	    <a class="logo" href="index.php">
		<b>
		    <!--This is dark logo icon-->
		    <img src="<?php echo  $user["company"]["MediumLogo"];?>" style="width:60px; height:60px" alt="home" class="dark-logo" />
		    <!--This is light logo icon-->
		    <img src="<?php echo  $user["company"]["MediumLogo"];?>" style="width:60px; height:60px"  alt="home" class="light-logo" />
		</b>
		<!--  		<span class="hidden-xs">
		<img src="<?php echo  $user["company"]["MediumLogo"];?>" alt="home" class="dark-logo" />
		<img src="<?php echo  $user["company"]["MediumLogo"];?>" alt="home" class="light-logo" />
		</span> -->
	    </a>
	</div>
	<ul class="nav navbar-top-links navbar-left hidden-xs">
	    <li><a href="javascript:void(0)" class="open-close hidden-xs waves-effect waves-light"><i class="icon-arrow-left-circle ti-menu"></i></a></li>
	    <li>
		<form role="search" class="app-search hidden-xs">
		    <input type="text" placeholder="Search..." class="form-control">
		    <a href=""><i class="fa fa-search"></i></a>
		</form>
	    </li>
	</ul>
	<ul class="nav navbar-top-links navbar-right pull-right">
	    <li style="position:relative; right:3px;">
		<div class="dropdown" style="margin-top:13px; margin-right:0px;">
		    <button class="btn btn-default dropdown-toggle" type="button" id="langChooserDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color:white; border:0px; background-color:inherit;">
			<?php echo $scope->user["language"]; ?>
			<span class="caret"></span>
		    </button>
		    <ul class="dropdown-menu lang-chooser-popup" aria-labelledby="langChooserDropdown" aria-expanded="false">
			<li><a href="javascript:;" data-value="<?php echo $scope->user["language"]; ?>" class="lang-item"><img src="assets/images/langs/<?php echo $scope->user["language"]; ?>.png">  <?php echo $scope->user["language"]; ?></a></li>
			<?php
			    foreach($translation->languages as $value)
			    if($value != $scope->user["language"])
				echo "<li><a href=\"javascript:;\" data-value=\"$value\" class=\"lang-item\"><img src=\"assets/images/langs/{$value}.png\">  " . $value . "</a></li>";
			?>
		    </ul>
		</div>
	    </li>
	    <li style="position:relative; right:-3px;">
		<div class="dropdown" style="margin-top:13px; margin-right:0px;">
		    <button class="btn btn-default dropdown-toggle" type="button" id="interfaceChooserDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color:white; border:0px; background-color:inherit;">
			<?php echo $scope->user["interface"]; ?>
			<span class="caret"></span>
		    </button>
		    <ul class="dropdown-menu interface-chooser-popup" aria-labelledby="interfaceChooserDropdown" aria-expanded="false">
			<li><a href="javascript:;" data-value="<?php echo $scope->user["interface"]; ?>" class="lang-item"><?php echo $scope->user["interface"]; ?></a></li>
			<?php
			    foreach(["simple", "default"] as $value)
			    if($value != $scope->user["interface"])
				echo "<li><a href=\"javascript:;\" data-value=\"$value\" class=\"lang-item\">" . $value . "</a></li>";
			?>
		    </ul>
		</div>
	    </li>
	    <li class="right-side-toggle">
		<a class="waves-effect waves-light" href="javascript:void(0)">
		    <i class="ti-settings"></i>
		</a>
	    </li>
	</ul>
    </div>
</nav>

<script>
 $(".lang-chooser-popup li a").click(function(){
     var item = $(this), lang = item.data('value');
     item.parents(".dropdown").find('.btn').html(item.text() + ' <span class="caret"></span>');
     item.parents(".dropdown").find('.btn').val(lang);
     var current = "<?php echo $scope->user["language"]; ?>";
     if(lang != current)
	 $.getJSON("index.php?page=language&setLanguage=" + lang)
	  .success(function(data) {
	      location.reload();
	  })
	  .error(function(err){
	      console.log('something going wrong');
	  });
 });

 $(".interface-chooser-popup li a").click(function(){
     var item = $(this), name = item.data('value');
     item.parents(".dropdown").find('.btn').html(item.text() + ' <span class="caret"></span>');
     item.parents(".dropdown").find('.btn').val(name);
     var current = "<?php echo $scope->user["interface"]; ?>";
     if(name != current)
	 $.post("<?php echo $linksMaker->makeProcedureLink("Payroll/EmployeeManagement/ViewEmployees", "changeInterface"); ?>&interface=" + name, null, null, 'json').success(function(data){
	     location.reload();
	 })
	  .error(function(data){
	      console.log(data);
	  });
 });
</script>
