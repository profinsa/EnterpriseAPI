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
		<div class="lang-chooser-container">
		    <select class="lang-chooser" onchange="changeLanguage(event);" style="padding:0px; position:relative; right:-15px; z-index:5000">
			<option><?php echo $scope->user["language"]; ?></option>
			<?php
			foreach($translation->languages as $value)
			    if($value != $scope->user["language"])
				echo "<option style=\"color:black;\">" . $value . "</option>";
			?>
		    </select>
		    <span class="glyphicon glyphicon-chevron-down lang-chooser" style="position:relative; top:-1px; right:0px;font-size:6pt;" aria-hidden="true"></span>
		</div>
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

<script>
 function changeLanguage(event){
     var current = "<?php echo $scope->user["language"]; ?>";
     if(event.target.value != current)
	 $.getJSON("index.php?page=language&setLanguage=" + event.target.value)
	     .success(function(data) {
		 location.reload();
	     })
	     .error(function(err){
		 console.log('something going wrong');
	     });
 }
 (function($, window){
     var arrowWidth = 20;

     $.fn.resizeselect = function(settings) {  
	 return this.each(function() { 

	     $(this).change(function(){
		 var $this = $(this);

		 // create test element
		 var text = $this.find("option:selected").text();
		 var $test = $("<span>").html(text);

		 // add to body, get width, and get out
		 $test.appendTo('body');
		 var width = $test.width();
		 $test.remove();

		 // set select width
		 $this.width(width + arrowWidth);

		 // run on start
	     }).change();

	 });
     };

     // run by default
     $("select.lang-chooser").resizeselect();                       
 })(jQuery, window);
</script>
