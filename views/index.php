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
	    <!-- .right-sidebar -->
	    <div class="right-sidebar">
		<div class="slimscrollright">
		    <div class="rpanel-title"> Service Panel <span><i class="ti-close right-side-toggle"></i></span> </div>
		    <div class="r-panel-body">
			<ul>
			    <li><b>Layout Options</b></li>
			    <li>
				<div class="checkbox checkbox-info">
				    <input id="checkbox1" type="checkbox" class="fxhdr">
				    <label for="checkbox1"> Fix Header </label>
				</div>
			    </li>
			    <li>
				<div class="checkbox checkbox-warning">
				    <input id="checkbox2" type="checkbox" checked="" class="fxsdr">
				    <label for="checkbox2"> Fix Sidebar </label>
				</div>
			    </li>
			    <li>
				<div class="checkbox checkbox-success">
				    <input id="checkbox4" type="checkbox" class="open-close">
				    <label for="checkbox4" > Toggle Sidebar </label>
				</div>
			    </li>
			</ul>
			<ul id="themecolors" class="m-t-20">
			    <li><b>With Light sidebar</b></li>
			    <li><a href="javascript:void(0)" theme="default" class="default-theme">1</a></li>
			    <li><a href="javascript:void(0)" theme="green" class="green-theme">2</a></li>
			    <li><a href="javascript:void(0)" theme="gray" class="yellow-theme">3</a></li>
			    <li><a href="javascript:void(0)" theme="blue" class="blue-theme">4</a></li>
			    <li><a href="javascript:void(0)" theme="purple" class="purple-theme">5</a></li>
			    <li><a href="javascript:void(0)" theme="megna" class="megna-theme">6</a></li>
			    <li><b>With Dark sidebar</b></li>
			    <br/>
			    <li><a href="javascript:void(0)" theme="default-dark" class="default-dark-theme">7</a></li>
			    <li><a href="javascript:void(0)" theme="green-dark" class="green-dark-theme">8</a></li>
			    <li><a href="javascript:void(0)" theme="gray-dark" class="yellow-dark-theme working">9</a></li>

			    <li><a href="javascript:void(0)" theme="blue-dark" class="blue-dark-theme">10</a></li>
			    <li><a href="javascript:void(0)" theme="purple-dark" class="purple-dark-theme">11</a></li>
			    <li><a href="javascript:void(0)" theme="megna-dark" class="megna-dark-theme">12</a></li>

			</ul>
		    </div>
		</div>
	    </div>
	    <!-- /.right-sidebar -->
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
//			  console.log(xhr.responseText);
			  window.location = "index.php?page=login";
		      else{
			  $("#page-wrapper").html(xhr.responseText);
			  window.scrollTo(0,0);
//			  alert("Unable to load page");
		      }
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
