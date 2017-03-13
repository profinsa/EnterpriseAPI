<ul class="nav navbar navbar-nav navbar-right top-bar hide-on-handsheld">
    <?php
    foreach ($menuCategories as $key=>$item){
	if($item["type"] == "item"){
	//    $href = preg_match("/^http/", $item["data"]["href"]) ? $item["data"]["href"] : $public_prefix . "/index#/grid/" . $item["data"]["href"] . "/grid/main/all";
	  //  echo "<li class=\"top-bar-link\"><a  href=\"" . $href . "\">". $item["data"]["full"] . "<span class=\"sr-only\">(current)</span></a></li>";
	}else if($item["type"] == "submenu"){
	    echo "<li class=\"dropdown top-bar-link\">";
	    echo "<a class=\"dropdown-toggle\" data-toggle=\"dropdown\" href=\"#\" role=\"button\" aria-haspopup=\"true\" aria-expanded\"false\">"  . $item["full"] . " <span class=\"caret\"></span></a>";
	    echo "<ul class=\"dropdown-menu\">";
	    foreach($item["data"] as $key=>$subitem){
		$href = preg_match("/^http/", $subitem["href"]) ? $subitem["href"] : $public_prefix . "/index#/grid/" . $subitem["href"] . "/grid/main/all";
		echo "<li><a href=\"" . $href . "\" class=\"nav-link\">" . $subitem["full"] ."</a></li>";
	    }
	    echo "</ul></li>";
	}
    }
    ?>
    <li class="dropdown menu-container">
	<a id="nav-menu-dropdown" class="dropdown-toggle" data-toggle="dropdown" href="#" title="Menu"><span class="glyphicon glyphicon-menu-hamburger"></span></a>
	<ul class="dropdown-menu" role="menu" aria-labelledby="nav-menu-dropdown">
	    <li>
		<select class="form-control" onchange="changeLanguage(event);">
		    <option><?php echo $user["language"]; ?></option>
		    <?php
		    foreach($translation->languages as $value)
			if($value != $user["language"])
			    echo "<option>" . $value . "</option>";
		    ?>
		</select>
	    </li>
	    <li class="divider"></li>
	    <li>
		<a href="<?php echo $public_prefix; ?>/login" class="nav-link">
		    <?php echo $translation->translateLabel('Log out'); ?>
		</a>
	    </li>
	</ul>
    </li>
    <li class="pull-right top-bar-toggler">
	<a class="minimizer" class="dropdown-toggle" href="javascript:toggleTopBar()">
	    <span id="topBarHider" class="glyphicon glyphicon glyphicon-menu-up"></span>
	</a>
    </li>
</ul>
<script>
 var topbarToggled = true;
 function toggleTopBar(){
     if(topbarToggled){
	 $('body').addClass('top-bar-minimized');
	 $('.logo-link').addClass("hide-logo");
	 $('.top-bar-shower-off').addClass('top-bar-shower');
	 $('.top-bar-shower-off').removeClass('top-bar-shower-off');
	 $('#topBarShower')[0].style.display = 'block';
	 topbarToggled = false;
     }else{
	 $('body').removeClass('top-bar-minimized');
	 $('.logo-link').removeClass("hide-logo");
	 $('.top-bar-shower').addClass('top-bar-shower-off');
	 $('.top-bar-shower').removeClass('top-bar-shower');
	 $('#topBarShower')[0].style.display = 'none';
	 topbarToggled = true;
     }
 }

 function changeLanguage(event){
     $.getJSON("<?php echo $public_prefix; ?>/language/" + event.target.value)
      .success(function(data) {
	  location.reload();
      })
      .error(function(err){
	  console.log('something going wrong');
      });
 }
</script>
