<ul id="sidebar" class="nav navbar-nav tabs" style="margin-top:0px; height: 400px;"> <!-- 178 -->
    <?php
    foreach ($menuCategories as $key=>$item){
	if($item["type"] == "item")
	    echo "<li><ul class=\"nav navbar-nav tabs navbar-items\"><li data-name=\"". ( key_exists("id", $item["data"]) ? $item["data"]["id"] : "") ."\"  class=\"not-in-more\"><a href=\"" . $item["data"]["href"] . "\" class=\"nav-link nav-item-level1\"><span class=\"full-label\">". $item["data"]["full"] ."</span><span class=\"short-label\" title=\"". $item["data"]["short"] ."\">". $item["data"]["short"] ."</span></a></li></ul></li>";
	else if($item["type"] == "submenu"){			
	    /*echo "<li data-name=\"". $key ."\" class=\"not-in-more\"><a href=\"" . $key . "\" class=\"nav-link\"><span class=\"full-label\">". $key ."</span><span class=\"short-label\" title=\"". $key ."\">". $key ."</span></a></li>";*/
	    echo "<li><ul class=\"nav navbar-nav tabs navbar-items\"><li data-name=\"". $key ."\"  class=\"not-in-more\"><a class=\"nav-item-level1\" href=\"#list" . $item["id"] . "\" data-toggle=\"collapse\"><span class=\"full-label\">". $item["full"] ."</span><span class=\"short-label\" title=\"". $item["short"] ."\">". $item["short"] ."</span></a></li>";
	    echo "<li id=\"list" . $item["id"] . "\" class=\"collapse-sidebar-item collapse\" data-name=\"" . $key ."\" class=\"not-in-more\" style=\"display:none\">";
	    echo "<ul class=\"nav navbar-nav tabs navbar-items\">";
	    //echo  "<a href=\"#\" style=\"margin-left:10px;\" class=\"nav-link active\"><span class=\"full-label\">Opportunities</span><span class=\"short-label\" title=\"Opportunities\">Op</span></a>";
	    foreach($item["data"] as $key=>$subitem){
		echo "<li id=\"" . ( key_exists("id", $subitem) ? $subitem["id"] : "") . "\" data-name=\"". $subitem["full"] ."\" class=\"not-in-more nav-link nav-item-level2\"><a href=\"" . $subitem["href"] . "\"><span class=\"full-label\">". $subitem["full"] ."</span><span class=\"short-label\" title=\"". $subitem["short"] ."\">". $subitem["short"] ."</span></a></li>";
	    }
	    echo "</ul></li></ul></li>";
	}
    }
    ?>
</ul>
<div class="sidebar-toggler">
    <a class="minimizer" href="javascript:toggleSideBar()">
	<span id="sideBarHider" class="glyphicon glyphicon glyphicon-menu-left"></span>
	<span id="sideBarShower" style="display:none;" class="glyphicon glyphicon glyphicon-menu-right"></span>
    </a>
</div>
<script>
 var sidebarItems = $(".collapse-sidebar-item");
 sidebarItems.on('hidden.bs.collapse', function (e) {
     $(e.currentTarget).css('display', 'none');
 });
 sidebarItems.on('show.bs.collapse', function (e) {
     sideBarCloseAll();
     $(e.currentTarget).css('display', 'block');
 });
 
 function sideBarCloseAll(){
     sidebarItems.css('display', 'none');
     sidebarItems.collapse('hide');
 }
 
 function sideBarDeselectAll(){
     $('.nav-item-level2').removeClass('sidebar-active');
 }

 function sideBarSelectItem(folder, item){
     var _item = $("#list" + folder);
     if(!_item.hasClass('in')){
	 sideBarCloseAll();
	 setTimeout(function(){
	     _item.collapse('show');
	     _item.css('display', 'block');
	 }, 500);
     }
     var selItem = document.getElementById(folder + '/' + item);
     if(!$(selItem).hasClass("sidebar-active")){
	 sideBarDeselectAll();
	 $(selItem).addClass("sidebar-active");
     }
 }
 
 var sidebarToggled = true;
 function toggleSideBar(){
     if(sidebarToggled){
	 $('body').addClass('minimized');
	 $('#logosection').addClass("hide-logo");
	 $('#sideBarHider')[0].style.display = 'none';
	 $('#sideBarShower')[0].style.display = 'block';
	 sidebarToggled = false;
     }else{
	 $('body').removeClass('minimized');
	 $('#logosection').removeClass("hide-logo");
	 $('#sideBarHider')[0].style.display = 'block';
	 $('#sideBarShower')[0].style.display = 'none';
	 sidebarToggled = true;
     }
 }
</script>
