<!-- Left navbar-header -->
<div class="navbar-default sidebar sidebar-lift" role="navigation">
    <div class="sidebar-nav navbar-collapse slimscrollsidebar">
	<?php include './views/nav/leftUser.php'; ?>
	<ul class="nav" id="side-menu">	    
	    <li class="sidebar-search hidden-sm hidden-md hidden-lg">
		<!-- input-group -->
		<div class="input-group custom-search-form">
		    <input type="text" class="form-control" placeholder="Search...">
		    <span class="input-group-btn">
			<button class="btn btn-default" type="button"> <i class="fa fa-search"></i> </button>
		    </span> </div>
		<!-- /input-group -->
	    </li>
	    <?php
		foreach ($leftMenu as $category){
		    echo "<li class=\"nav-small-cap m-t-10\">--- " .  $translation->translateLabel($category["title"]) . "</li>";
		    foreach($category["data"] as $item){
			if($item["type"] == "absoluteLink")
			    echo "<li><a href=\"" . $item["link"] . "\" ". (key_exists("target", $item) ? "target=\"" . $item["target"] . "\"" : "") ." class=\"waves-effect\"><i class=\"" . $item["icon"] . " fa-fw\" data-icon=\"v\"></i> <span class=\"hide-menu\">".  $translation->translateLabel($item["title"]) . "</span></a></li>";
			else if($item["type"] == "item")
			    echo "<li><ul class=\"nav navbar-nav tabs navbar-items\"><li data-name=\"". ( key_exists("id", $item["data"]) ? $item["data"]["id"] : "") ."\"  class=\"not-in-more\"><a href=\"" . $item["data"]["id"] . "\" class=\"nav-link nav-item-level1\"><span class=\"full-label\">". $item["data"]["full"] ."</span><span class=\"short-label\" title=\"". $item["data"]["short"] ."\">". $item["data"]["short"] ."</span></a></li></ul></li>";
			else if($item["type"] == "submenu" && $security->checkMenu($item["id"])){			
			    echo "<li id=\"list" . $item["id"] . "\"><a href=\"javascript:void(0);\" class=\"waves-effect\"><i class=\"icon-people fa-fw\"></i> <span class=\"hide-menu\">" . $item["full"] . "<span class=\"fa arrow\"></span></span></a>";
			    echo "<ul class=\"nav nav-second-level\">";
			    foreach($item["data"] as $key=>$subitem){
				if(!key_exists("type", $subitem))
				    echo "<li id=\"" . ( key_exists("id", $subitem) ? $subitem["id"] : "") . "\"><a href=\"index.php#/?page=grid&action=" . (key_exists("href_ended", $subitem) ? $subitem["href_ended"] : $subitem["id"]) . "\">" . $subitem["full"] . "</a></li>";
				else if($subitem["type"] == "relativeLink"){
				    $href = "index.php" . (key_exists("target", $subitem) && $subitem["target"] == "_blank" ? "" : "#/") . "?" . $subitem["href"];
				    echo "<li id=\"" . ( key_exists("id", $subitem) ? $subitem["id"] : "") . "\"><a href=\"" . $href . "\" " . (key_exists("target", $subitem) && $subitem["target"] == "_blank" ? "target=\"_blank\"" : "") . ">" . $subitem["full"] . "</a></li>";
				    
				}else if($subitem["type"] == "submenu"){
				    echo "<li id=\"list" . $subitem["id"] . "\"><a href=\"javascript:void(0)\" class=\"waves-effect\">" . $subitem["full"] . "<span class=\"fa arrow\"></span></a>";
				    echo "<ul  id=\"container" . $subitem["id"] . "\" class=\"nav nav-third-level collapse\" aria-expanded=\"false\" style=\"height: 0px;\">";
				    foreach($subitem["data"] as $skey=>$ssubitem){
					if(key_exists("type", $ssubitem) && $ssubitem["type"] == "submenu"){
					    echo "<li> <a href=\"javascript:void(0)\" class=\"waves-effect\">" . $ssubitem["full"] . "<span class=\"fa arrow\"></span></a>";
					    echo "<ul class=\"nav nav-fourth-level collapse\" aria-expanded=\"false\" style=\"height: 0px;\">";
					    foreach($ssubitem["data"] as $sskey=>$sssubitem){
						if(key_exists("type", $sssubitem) && $sssubitem["type"] == "relativeLink")
						    $href = "index.php" . (key_exists("target", $sssubitem) && $sssubitem["target"] == "_blank" ? "" : "#/") . "?" . $sssubitem["href"];
						else
						    $href = "index.php#/?page=grid&action=" . (key_exists("href_ended", $sssubitem) ? $sssubitem["href_ended"] : $sssubitem["id"]);
						
						echo "<li id=\"" . ( key_exists("id", $sssubitem) ? $sssubitem["id"] : "") . "\"><a href=\"" . $href . "\" " . (key_exists("target", $sssubitem) && $sssubitem["target"] == "_blank" ? "target=\"_blank\"" : "") . ">" . $sssubitem["full"] . "</a></li>";
					    }
					    echo "</ul>";
					}else{
					    if(key_exists("type", $ssubitem) && $ssubitem["type"] == "relativeLink")
						$href = "index.php" . (key_exists("target", $ssubitem) && $ssubitem["target"] == "_blank" ? "" : "#/") . "?" . $ssubitem["href"];
					    else
						$href = "index.php#/?page=grid&action=" . (key_exists("href_ended", $ssubitem) ? $ssubitem["href_ended"] : $ssubitem["id"]);
					    
					    echo "<li id=\"" . ( key_exists("id", $ssubitem) ? $ssubitem["id"] : "") . "\"><a href=\"" . $href . "\" " . (key_exists("target", $ssubitem) && $ssubitem["target"] == "_blank" ? "target=\"_blank\"" : "") . ">" . $ssubitem["full"] . "</a></li>";
					}
				    }
				    echo "</ul>";
				}
			    }
			    echo "</ul></li>";
			}
		    }
		}
	    ?>
	</ul>
    </div>
</div>

<script>
 function leftMenuGetContainer(id){
     return {
	 element : document.getElementById("container" + id),
	 insertItems : function(children){
	     var ind, _html = '';
	     for(ind in children)
		 _html += "<li id=\"" + children[ind].id + "\"><a href=\"" + children[ind].href + "\">" + children[ind].title + "</a></li>";
	     $(this.element).html(_html);
	 }
     };
 }

 function leftMenuUpdateSavedReports(){
     var container = leftMenuGetContainer("Reports/SavedReports");
     
     var savedReports = localStorage.getItem("reportsEngineSavedReports"), items = [];
     if(savedReports){
	 savedReports = JSON.parse(savedReports);
	 for(ind in savedReports)
	     items.push({
		 type : "relativeLink",
		 id : "Reports/SavedReports/" + ind,
		 href : "index.php#/?page=grid&action=Reports/Autoreport/GenericReportDetail&mode=new&category=Main&item=<?php echo "{$user["CompanyID"]}__{$user["DivisionID"]}_{$user["DepartmentID"]}"; ?>&report=" + ind,
		 title : ind
	     });
	 container.insertItems(items);
     }
 }
 leftMenuUpdateSavedReports();
</script>

