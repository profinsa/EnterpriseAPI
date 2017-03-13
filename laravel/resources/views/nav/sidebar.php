<ul id="sidebar" class="nav navbar-nav tabs sidebar"> <!-- - 178 -->
    <?php
    foreach ($menuCategories as $key=>$item){
	if($item["type"] == "item"){
	    $href = preg_match("/^http/", $item["data"]["href"]) ? $item["data"]["href"] : $public_prefix . "/index#/grid/" . $item["data"]["href"] . "/grid/main/all";
	    echo "<li><ul class=\"nav navbar-nav tabs navbar-items\"><li data-name=\"". ( key_exists("id", $item["data"]) ? $item["data"]["id"] : "") ."\"  class=\"not-in-more\"><a href=\"" . $href . "\" class=\"nav-link nav-item-level1\"><span class=\"full-label\">". $item["data"]["full"] ."</span><span class=\"short-label\" title=\"". $item["data"]["short"] ."\">". $item["data"]["short"] ."</span></a></li></ul></li>";
	}else if($item["type"] == "submenu"){
	    /*echo "<li data-name=\"". $key ."\" class=\"not-in-more\"><a href=\"" . $key . "\" class=\"nav-link\"><span class=\"full-label\">". $key ."</span><span class=\"short-label\" title=\"". $key ."\">". $key ."</span></a></li>";*/
	    echo "<li><ul class=\"nav navbar-nav tabs navbar-items\"><li data-name=\"". $key ."\"  class=\"not-in-more\"><a class=\"nav-item-level1\" href=\"#list" . $item["id"] . "\" data-toggle=\"collapse\"><span class=\"full-label\">". $item["full"] ."</span><span class=\"short-label\" title=\"". $item["short"] ."\">". $item["short"] ."</span></a></li>";
	    echo "<li id=\"list" . $item["id"] . "\" class=\"collapse-sidebar-item collapse\" data-name=\"" . $key ."\" class=\"not-in-more\" style=\"display:none\">";
	    echo "<ul class=\"nav navbar-nav tabs navbar-items\">";
	    //echo  "<a href=\"#\" style=\"margin-left:10px;\" class=\"nav-link active\"><span class=\"full-label\">Opportunities</span><span class=\"short-label\" title=\"Opportunities\">Op</span></a>";
	    foreach($item["data"] as $key=>$subitem){
		if($subitem["type"] == "item"){
		    $href = preg_match("/^http/", $subitem["href"]) ? $subitem["href"] : $public_prefix . "/index#/grid/" . $subitem["href"] . "/grid/main/all";
		    echo "<li id=\"" . ( key_exists("id", $subitem) ? $subitem["id"] : "") . "\" data-name=\"". $subitem["id"] ."\" class=\"not-in-more nav-link nav-item-level2\"><a href=\"" . $href . "\"><span class=\"full-label\">". $subitem["full"] ."</span><span class=\"short-label\" title=\"". $subitem["short"] ."\">". $subitem["short"] ."</span></a></li>";
		}else if($subitem["type"] == "submenu"){
		    echo "<li><ul class=\"nav navbar-nav tabs navbar-items\"><li data-name=\"#list". str_replace("/", "", $subitem["id"]) ."\"  class=\"not-in-more\"><a class=\"nav-item-submenu\" href=\"#list" . str_replace("/", "", $subitem["id"]) . "\" data-toggle=\"collapse\"><span class=\"full-label\">". $subitem["full"] ."</span><span class=\"short-label\" title=\"". $subitem["short"] ."\">". $subitem["short"] ."</span></a></li>";
		    echo "<li id=\"list" . str_replace("/", "", $subitem["id"]) . "\" class=\"collapse-sidebar-two-level-item collapse\" data-name=\"" . $subitem["id"] ."\" class=\"not-in-more\" style=\"display:none\">";
		    echo "<ul class=\"nav navbar-nav tabs navbar-items\">";
		    foreach($subitem["data"] as $ssubitem){
			$href = preg_match("/^http/", $ssubitem["href"]) ? $ssubitem["href"] : $public_prefix . "/index#/grid/" . $ssubitem["href"] . "/grid/main/all";
			echo "<li id=\"" . ( key_exists("id", $ssubitem) ? $ssubitem["id"] : "") . "\" data-name=\"". $ssubitem["full"] ."\" class=\"not-in-more nav-link nav-item-level3\"><a href=\"" . $href . "\"><span class=\"full-label\">". $ssubitem["full"] ."</span><span class=\"short-label\" title=\"". $ssubitem["short"] ."\">". $ssubitem["short"] ."</span></a></li>";
		    }
		    echo "</ul></li></ul></li>";
		}
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
 var TwolevelItems = $(".collapse-sidebar-two-level-item");
 function onhidden(e) {
     $(e.currentTarget).css('display', 'none');
     var $sidebar   = $("#sidebar"), 
	 $content = $("#content");
     $content.height('100%');
     if($sidebar.height() > $content.height())
	 $content.height($sidebar.height());
     e.stopPropagation();
 }
 sidebarItems.on('hidden.bs.collapse', onhidden);
 TwolevelItems.on('hidden.bs.collapse', onhidden);
 sidebarItems.on('show.bs.collapse', function(e){
     sideBarCloseAll();
     $(e.currentTarget).css('display', 'block');
     var $sidebar   = $("#sidebar"), 
	 $content = $("#content");
     if($sidebar.height() > $content.height())
	 $content.height($sidebar.height());
     e.stopPropagation();
 });
 TwolevelItems.on('show.bs.collapse', function(e){
     var parent = $(e.currentTarget).parent().parent().parent().parent();
     console.log(parent, parent.is('.in, .collapse'));
//     if(!parent.is('.in, .collapse'))
     sideBarCloseTwolevelAll();
     $(e.currentTarget).css('display', 'block');
     var $sidebar   = $("#sidebar"), 
	 $content = $("#content");
     if($sidebar.height() > $content.height())
	 $content.height($sidebar.height());
     e.stopPropagation();
 });
 
 function sideBarCloseAll(){
     sidebarItems.css('display', 'none');
     sidebarItems.collapse('hide');
 }

 function sideBarCloseTwolevelAll(){
     TwolevelItems.css('display', 'none');
     TwolevelItems.collapse('hide');
 }
 
 function sideBarDeselectAll(){
     $('.nav-item-level2, .nav-item-level3').removeClass('sidebar-active');
 }


 function sideBarSelectItem(object){
     if(!object)
	 return;
     var _item = $(document.getElementById("list" + object.menu.id)), sitem;
     //console.log(object, _item);
     if(!_item.hasClass('in')){
	 sideBarCloseAll();
	 setTimeout(function(){
	     _item.collapse('show');
	     _item.css('display', 'block');
	 }, 500);
     }
     
     if(object.hasOwnProperty("submenu")){
	 sitem = $(document.getElementById("list" + object.submenu.id.replace(/\//, "")));
	 if(!sitem.hasClass('in')){
	     sideBarCloseTwolevelAll();
	     setTimeout(function(){
//		 sitem.collapse('show');
		 sitem.css('display', 'block');
	     }, 500);
	 }
     }
     var selItem = document.getElementById(object.item.id);
     //console.log(selItem, 'llooo');
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
 (function(){
     var $sidebar   = $("#sidebar"), 
	 $window    = $(window),
	 offset     = $sidebar.offset(),
	 topPadding = 15,
	 $content = $("#content");

     $window.scroll(function(){
	 var wscroll = $window.scrollTop();
	 if(!wscroll){
	     $sidebar.css("top", 0 + 'px');
	 }else if(wscroll){
	     //	     console.log($sidebar.height(), $(".sidebar-toggler").offset());
	     //console.log(wscroll, $sidebar.height(), $window.height());
	     if(wscroll < $sidebar.height() - $window.height() + 150)
		 $sidebar.css("top", (wscroll * -1) + 'px');
	     else
		 $sidebar.css("bottom", '0px');	 
	     //    $sidebar.stop().animate({
	     //	 marginTop: $window.scrollTop() - offset.top + topPadding
	     //   });
	 }
     });
 })();
</script>
