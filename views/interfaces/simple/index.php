<!DOCTYPE html>
<html dir="<?php echo $ascope["interfaceType"]; ?>">
    <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><?php echo $app->title; ?></title>
	<?php
	    require "header.php";
	?>
	<meta content="utf-8" http-equiv="encoding">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="description" content="">
	<meta name="mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<script src="dependencies/assets/js/spin.min.js"></script>
	<script>
	</script>
	<?php
	    require __DIR__ . '/../../components/commonJavascript.php';
	?>
	<style> <!-- FAST STYLE FIXES FIXMEEEE -->
	 @media screen and (min-width: 768px){
	     .navbar .navbar-right {
		 height : auto !important;
	     }
	 }
	 /*
	    FIXME hardcode for RTL Support, we need support styles separed in the future for RTL and LTR interface types
	  */
	 <?php if($ascope["interfaceType"] == "rtl"): ?>
	 body  > .content {
	     margin-left : 0px !important;
	     margin-right : 100px !important;
	 }
	 @media screen and (min-width: 768px){
	     #header .navbar-right {
		 margin-left: 0px !important;
		 margin-right: 100px !important;
	     }
	     
	     .navbar-nav>li{
		 float:right;
	     }
	 }

	 .bs-glyphicons-list {
	     padding-right:0px !important;
	 }

	 .logo-container {
	     right : 100px !important;
	 }
	 .float-right {
	     float: left !important;
	 }
	 <?php endif; ?>
	</style>
    </head>
    <?php
	$menuCategories = $leftMenu["Main"]["data"];
	$menuActions = [];

	$keyString = $user["CompanyID"] . "__" . $user["DivisionID"] . "__" . $user["DepartmentID"];

	//	require "menuActions.php";

/*	$menuCategories["Dashboard"] = [
	    "type" => "blank",
	    "data" => [
		"id" => "Dashboard",
		"full" => $translation->translateLabel('Dashboard'),
		"short" => "Da",
		"href" => "dashboard",
	    ]
	];
*/
	$menuCategories["MyShortcuts"] = [
            "type" => "custom",
            "id" => "MyShortcuts",
            "full" => $translation->translateLabel('My Shortcuts'),
            "short" => "Ms",
            "actions" => [
		[
                    "id" => "CustomizeShortcuts",
                    "full" => $translation->translateLabel('Customize Shortcuts'),
                    "short" => "Cu",
                    "action" => "custormizeShortcutsOpen();"
		]
            ]
	];

/*	$menuCategories["Documentation"] = [
	    "type" => "item",
	    "data" => [
		"id" => "Documentation",
		"full" => $translation->translateLabel('Help Documentation'),
		"short" => "HD",
		"href" => "http://dms.newtechautomotiveservices.com:8084/EnterpriseHelp/usermanual/index.php",
		"Target" => "_Blank"
	    ]
	    ];*/

    ?>
    <body onload="main();" style="min-height: 800px;" class="">
	<?php
	?>
	<header id="header">
            <div id="navbar">
		<div class="navbar navbar-inverse left-iconbar-wrapper" role="navigation">
		    <div class="navbar-header top-bar logo-container">
			<a class="navbar-brand nav-link logo-link" href="index.php#/?page=dashboard"><img id="logosection"  src="<?php echo  $user["company"]["MediumLogo"];?>" class="logo"><span class="home-icon glyphicon glyphicon-th-large" title="Home"></span></a>
		    </div>
		    <!-- <button type="button" class="navbar-toggle hide-on-small" data-toggle="collapse" data-target=".navbar-body">
			 <span class="icon-bar"></span>
			 <span class="icon-bar"></span>
			 <span class="icon-bar"></span>
			 </button> -->
		    <div class="left-iconbar-collapse collapse navbar-collapse navbar-body"  style="height: 100% !important;">
			<?php
			    require "nav/sidebar.php";
			    require "nav/topbar.php";
			    require "nav/right-sidebar.php";
			    require "nav/favbar.php";
			?>
		    </div>
		</div>
            </div>
	</header>
	<!--<a class="minimizer top-bar-shower-off top-bar-toggler" href="javascript:toggleTopBar()">
             <span id="topBarShower" class="glyphicon glyphicon glyphicon-menu-down"></span>
	     </a>-->
	<?php require "footer.php"; ?>
	<div id="content" class="container content top-bar-offset" style="background: #ffffff; padding-bottom:10px; padding-right:0px; padding-left:0px;">
            <?php
		if(isset($content))
		    require $content;
            ?>
	</div>
	<div id="popup-notifications-container" class="hidden"></div>
	<span style="position:fixed; bottom:0%; left:120px; font-size:10pt; color: black; margin-right: 15px; margin-bottom: 10px">
	    <?php
		echo $user["CompanyID"] . ' / ' .
		     $user["DivisionID"] . ' / ' .
		     $user["DepartmentID"] . ' / ' .
		     $user["EmployeeID"];
	    ?>
	</span>
	<script>
	 function escapeRegExp(str) {
             return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
	 }
	 var menuCategories = <?php echo json_encode($menuCategories); ?>;
	 function findMenuItem(href){
             var ind, sind, submenu, iind, items, subsubmenu, ssind;
             for(ind in menuCategories){
		 items = menuCategories[ind].data;
		 for(iind in items){
		     if(items[iind].type == "item"){
			 if(href.match("/" + items[iind].id + "/"))
			     return {
				 menu : menuCategories[ind],
				 item : items[iind]
			     };
		     }else if(items[iind].type == "submenu"){
			 submenu = items[iind].data;
			 for(sind in submenu){
			     if(submenu[sind].hasOwnProperty("type") && submenu[sind].type == "submenu"){
				 subsubmenu = submenu[sind].data;
				 for(ssind in subsubmenu){
				     if(href.match("/" + subsubmenu[ssind].id + "/") ||
					(subsubmenu[ssind].hasOwnProperty("type") && subsubmenu[ssind].type == "relativeLink" && href.match(escapeRegExp(subsubmenu[ssind].href))))
					 return {
					     menu : menuCategories[ind],
					     submenu : items[iind],
					     subsubmenu : submenu[sind],
					     item : subsubmenu[ssind]
					 };
				 }
			     }else{
				 if(href.match("/" + submenu[sind].id + "/") ||
				    (submenu[sind].hasOwnProperty("type") && submenu[sind].type == "relativeLink" && href.match(escapeRegExp(submenu[sind].href))))
				     return {
					 menu : menuCategories[ind],
					 submenu : items[iind],
					 item : submenu[sind]
				     };
			     }
			 }
		     }
		 }
             }
             return undefined;
	 }
	 //	 console.log(JSON.stringify(menuCategories, null, 3));
	 /*
            parsing window.location, loading page and insert to content section. Main entry point of SAP
	  */
	 var onlocationSkipUrls = {};
	 function onlocation(location){
             var path = location.toString();
	     if(onlocationSkipUrls.hasOwnProperty(location)){
		 delete onlocationSkipUrls[location];
		 return;
	     }
             var match;
             if(path.search(/index\.php.*\#\//) != -1){
		 path = path.replace(/index\.php.*\#\//, "index\.php");
		 // match = path.match(/grid\/(\w+)\/\w+\/(\w+)\//);
		 //		 console.log();
		 var item = findMenuItem(path);
		 if(item){
		     if(path.match(/grid\/(\w+)\/\w+\/(\w+)\//) || path.match(/autoreports/))
			 sideBarSelectItem(item);
		     else{
			 sideBarCloseAll();
			 sideBarDeselectAll();
		     }
		 }
		 $.get(path.match(/\?/) ? path : path + "?partial=true")
		  .done(function(data){
		      setTimeout(function(){
			  $("#content").html(data);
			  window.scrollTo(0,0);
		      },0);
		  })
		  .error(function(xhr){
		      if(xhr.status == 401)
			  window.location = "index.php?page=login";
		      else{
			  $("#content").html("<br/><br/>" + xhr.responseText);
			  window.scrollTo(0,0);
		      }
		  });
             }else
             console.log("wrong url");
	 }

	 onlocation(window.location);
	 $(window).on('hashchange', function() {
             onlocation(window.location);
	 });

	 function main(){
	     topbarMenuRender();
	     topbarUpdateSavedReports();
	     
             <?php if(isset($sscope)): ?> <!-- FIXME -->
             sideBarSelectItem("<?php echo  $scope["pathFolder"] . "\",\"" . $ascope["pathPage"];?>");
             <?php endif; ?>
             var spinnerTarget = document.getElementById('content');
             var spinner;
             $(document).ajaxStart(function(){
		 setTimeout(function(){
		     spinner = new Spinner({
			 lines: 13 // The number of lines to draw
			 , length: 28 // The length of each line
			 , width: 16 // The line thickness
			 , radius: 37 // The radius of the inner circle
			 , scale: 1 // Scales overall size of the spinner
			 , corners: 1 // Corner roundness (0..1)
			 , color: '#000' // #rgb or #rrggbb or array of colors
			 , opacity: 0.25 // Opacity of the lines
			 , rotate: 11 // The rotation offset
			 , direction: 1 // 1: clockwise, -1: counterclockwise
			 , speed: 1 // Rounds per second
			 , trail: 60 // Afterglow percentage
			 , fps: 20 // Frames per second when using setTimeout() as a fallback for CSS
			 , zIndex: 2e9 // The z-index (defaults to 2000000000)
			 , className: 'spinner' // The CSS class to assign to the spinner
			 , top: '40%' // Top position relative to parent
			 , left: '50%' // Left position relative to parent
			 , shadow: false // Whether to render a shadow
			 , hwaccel: false // Whether to use hardware acceleration
			 , position: 'absolute' // Element positioning
		     }).spin(spinnerTarget);
		 },0);
             });
             $(document).ajaxStop(function(){
		 if(spinner)
		     spinner.stop();
		 else
		     setTimeout(function(){
			 if (spinner) {
			     spinner.stop();
			 }
		     }, 0);
             });
	 }
	</script>
    </body>
</html>
