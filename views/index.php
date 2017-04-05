<!DOCTYPE html>  
<html lang="en">
    <?php
    require 'header.php';
    ?>
    <body>
	<script src="dependencies/plugins/bower_components/datatables/jquery.dataTables.min.js"></script>
	<!-- Preloader
	     <div class="preloader">
	     <div class="cssload-speeding-wheel"></div>
	     </div>-->
	<div id="wrapper">
	    <?php
	    require 'nav/top.php';
	    ?>
	    <?php
	    require 'nav/left.php';
	    ?>
	    <!-- /#wrapper -->
	    <?php
	    require 'footer.php';
	    ?>
	    <div id="page-wrapper">
		<?php
		if(key_exists("page", $_GET) && $_GET["page"] == "index")
		    require 'dashboards/GeneralLedger.php';
		?>
	    </div>
	</div>
	<?php 
	require 'uiItems/footer.php';
	?>
	<script>
	 var menuCategories = <?php echo json_encode($menuCategories); ?>;
	 function findMenuItem(href){
	     var ind, sind, submenu, iind, items;
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
			     //			     console.log(href);
			     //			     console.log(submenu[sind].id);
			     if(href.match("/" + submenu[sind].id + "/"))
				 return {
				     menu : menuCategories[ind],
				     submenu : items[iind],
				     item : submenu[sind]
				 };
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
	 function onlocation(location){
	     var path = new String(location);
	     var match;
	     if(path.search(/index.php\#\//) != -1){
		 path = path.replace(/index.php\#\//, "index.php");
		 match = path.match(/grid\/(\w+)\/\w+\/(\w+)\//);
		 //		 if(match)
		     //		     sideBarSelectItem(findMenuItem(path));//match[1], match[2]);
		 //		 else{
		 //		     sideBarCloseAll();
//		     sideBarDeselectAll();
//		 }
		 console.log(path);
		 $.get(path)
		  .done(function(data){
		      setTimeout(function(){
			  $("#page-wrapper").html(data);
			  window.scrollTo(0,0);
		      },0);
		  })
		  .error(function(xhr){
		      if(xhr.status == 401)
			  window.location = "index.php?page=login";
		      else
			  alert("Unable to load page");
		  });
	     }
	 }
	 onlocation(window.location);
	 $(window).on('hashchange', function() {
	     onlocation(window.location);
	 });

	 //select sidebar item if application loaded in separated pages mode, like that: grid/GeneralLedger/ledgerAccountGroup/grid/main/all, without index#/
	 function main(){
	     <?php if(isset($scope)): ?>
	     //sideBarSelectItem("<?php /*echo  $scope["pathFolder"] . "\",\"" . $scope["pathPage"];*/?>");
	     <?php endif; ?>
	 }
	</script>
    </body>
</html>
