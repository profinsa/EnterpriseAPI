<!-- Top Navigation -->
<nav class="navbar navbar-default navbar-static-top m-b-0">
    <div class="navbar-header"> 
	<a class="navbar-toggle hidden-sm hidden-md hidden-lg " href="javascript:void(0)" data-toggle="collapse" data-target=".navbar-collapse"><i class="ti-menu"></i></a>
	<div class="top-left-part"><a class="logo" href="index.html"><b>
	    <!--This is dark logo icon-->	<img src="assets/images/stfb-logo.gif" style="width:60px; height:60px" alt="home" class="dark-logo" />
	    <!--This is light logo icon-->	<img src="assets/images/stfb-logo.gif" alt="home" class="light-logo" /></b><span class="hidden-xs">
	    <!--This is dark logo text-->	<img src="assets/images/stfb-logo.gif" alt="home" class="dark-logo" />
	    <!--This is light logo text-->	<img src="assets/images/stfb-logo.gif" alt="home" class="light-logo" /></span></a>
	    
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
	    <li>
		<select  style="margin-top:10px; width:100px; background-color:inherit; color:#ffffff; border:0px" class="form-control" onclick="event.stopPropagation();" onchange="changeLanguage(event);">
		    <option style="color:black;"><?php echo $scope->user["language"]; ?></option>
		    <?php
		    foreach($translation->languages as $value)
			if($value != $scope->user["language"])
			    echo "<option style=\"color:black;\">" . $value . "</option>";
		    ?>
		</select>
	    </li>
	    <li class="right-side-toggle"> <a class="waves-effect waves-light" href="javascript:void(0)"><i class="ti-settings"></i></a></li>
	    <!-- /.dropdown -->
	</ul>
    </div>
    <!-- /.navbar-header -->
    <!-- /.navbar-top-links -->
    <!-- /.navbar-static-side -->
</nav>
<!-- End Top Navigation -->
