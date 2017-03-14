<!-- Left navbar-header -->
<div class="navbar-default sidebar" role="navigation" style="position:absolute; top:-50px; z-index:5000">
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
	    <li class="nav-small-cap m-t-10">--- My Menu</li>
	    <li> <a href="index.php?page=index" class="waves-effect"><i class="linea-icon linea-basic fa-fw" data-icon="v"></i> <span class="hide-menu"> <?php echo $translation->translateLabel('Dashboard'); ?> </span></a></li>
	    
	    <li> <a href="index.php?page=index#tasks" class="waves-effect"><i class="linea-icon linea-basic fa-fw" data-icon="v"></i> <span class="hide-menu"> <?php echo $translation->translateLabel('Tasks');  ?> </span></a></li>
	    
	    <li>
		<a href="index.php?page=index#chat" class="waves-effect"><i class="linea-icon linea-basic fa-fw" data-icon="v"></i> <span class="hide-menu"> <?php echo $translation->translateLabel('Chat');  ?> </span>
		</a>
	    </li>

	    <li class="nav-small-cap">--- Main Menu</li>

	    <?php
	    foreach ($menuCategories as $key=>$item){
		if($item["type"] == "item")
		    echo "<li><ul class=\"nav navbar-nav tabs navbar-items\"><li data-name=\"". ( key_exists("id", $item["data"]) ? $item["data"]["id"] : "") ."\"  class=\"not-in-more\"><a href=\"" . $item["data"]["id"] . "\" class=\"nav-link nav-item-level1\"><span class=\"full-label\">". $item["data"]["full"] ."</span><span class=\"short-label\" title=\"". $item["data"]["short"] ."\">". $item["data"]["short"] ."</span></a></li></ul></li>";
		else if($item["type"] == "submenu"){			
		    echo "<li  id=\"list" . $item["id"] . "\"><a href=\"javascript:void(0);\" class=\"waves-effect\"><i class=\"icon-people fa-fw\"></i> <span class=\"hide-menu\">" . $item["full"] . "<span class=\"fa arrow\"></span></span></a>";
		    echo "<ul class=\"nav nav-second-level\">";
		    foreach($item["data"] as $key=>$subitem){
			if($subitem["type"] == "item")
			    echo "<li id=\"" . ( key_exists("id", $subitem) ? $subitem["id"] : "") . "\"><a href=\"index.php?page=grid&action=" . $subitem["id"] . "\">" . $subitem["full"] . "</a></li>";
			else if($subitem["type"] == "submenu"){
			    echo "<li> <a href=\"javascript:void(0)\" class=\"waves-effect\">" . $subitem["full"] . "<span class=\"fa arrow\"></span></a>";
			    echo "<ul class=\"nav nav-third-level collapse\" aria-expanded=\"false\" style=\"height: 0px;\">";
			    foreach($subitem["data"] as $skey=>$ssubitem)
				echo "<li id=\"" . ( key_exists("id", $ssubitem) ? $ssubitem["id"] : "") . "\"><a href=\"index.php?page=grid&action=" . $ssubitem["id"] . "\">" . $ssubitem["full"] . "</a></li>";
			    
			    echo "</ul>";
			}
		    }
		    echo "</ul></li>";
		}
	    }
	    ?>
	    <li class="nav-small-cap">--- Support</li>
	    <li>
		<a href="https://stfbinc.helpdocs.com" Target="_Blank" class="waves-effect">
		    <i class="icon-docs fa-fw"></i>
		    <span class="hide-menu"><?php echo $translation->translateLabel("Help Documentation"); ?></span>
		</a>
	    </li>
	    <li>
		<a href="https://stfbinc.teamwork.com/support/" Target="_Blank" class="waves-effect">
		    <i class="icon-support fa-fw"></i>
		    <span class="hide-menu"><?php echo $translation->translateLabel("Support Ticket"); ?></span>
		</a>
	    </li> 
	    

	    <li>
		<a href="index.php?page=index&logout=true" class="waves-effect">
		    <i class="icon-logout fa-fw"></i>
		    <span class="hide-menu"><?php echo $translation->translateLabel("Log out"); ?></span>
		</a>
	    </li>
	    
	</ul>
    </div>
    <script>
     function changeLanguage(event){
	 $.getJSON("index.php?page=language&setLanguage=" + event.target.value)
	  .success(function(data) {
	      location.reload();
	  })
	  .error(function(err){
	      console.log('something going wrong');
	  });
     }
    </script>
</div>
<!-- Left navbar-header end -->
