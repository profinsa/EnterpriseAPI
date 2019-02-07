<?php
    require("avatar.php");
?>
<div class="right-sidebar">
    <div class="r-panel-body">
        <ul class="m-t-20">
            <li>
                <div class="row">
                    <div class="col-md-6" style="width: 70px">
                        <img id="mini_avatar" style="cursor: pointer" onclick="changeAvatarOpen()" class="img-responsive user-photo" src="<?php echo $user['PictureURL'] ? 'uploads\\' . $user['PictureURL'] : 'assets/images/avatar_2x.png'; ?>">
                    </div>
                    <div class="col-md-6">
                    <div class="form-group">
                        <label><?php echo $translation->translateLabel('Username'); ?></label>
                        <p><?php echo $user["EmployeeUserName"];?></p>
                    </div>
                    <div class="form-group">
                        <label><?php echo $translation->translateLabel('Full Name'); ?></label>
                        <p><?php echo $user["EmployeeName"];?></p>
                    </div>                        
                    <div class="form-group">
                        <label><?php echo $translation->translateLabel('Email Address'); ?></label>
			<p><?php echo (key_exists("email", $user) ? $user["email"] : "");?></p>
                    </div>                        
                </div>
                <div>
            </li>
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
            <li>
                <a href="javascript:unlockMyRecords();" class="nav-link">
                    <?php echo $translation->translateLabel('Release Record Locks'); ?>
                </a>
                <form id="lockData" class="form-material form-horizontal m-t-30">
                    <input type="hidden" name="category" value="Main" />
                    <input type="hidden" name="EmployeeID"  value="<?php echo $user["EmployeeID"]; ?>" />
                </form>
            </li>
            <li>
            <a href="index.php?page=login" class="nav-link">
                <?php echo $translation->translateLabel('Log out'); ?>
            </a>
            </li>
        </ul>
        <ul id="themecolors">
            <li><b>With Light sidebar</b></li>
            <li><a onclick="changeTheme(event);" class="default-theme">1</a></li>
            <li><a onclick="changeTheme(event);" class="green-theme">2</a></li>
            <li><a onclick="changeTheme(event);" class="yellow-theme">3</a></li>
            <li><a onclick="changeTheme(event);" class="blue-theme">4</a></li>
            <li><a onclick="changeTheme(event);" class="purple-theme">5</a></li>
            <li><a onclick="changeTheme(event);" class="megna-theme">6</a></li>
            <li><b>With Dark sidebar</b></li>
            <br/>
            <li><a onclick="changeTheme(event);" class="default-dark-theme">7</a></li>
            <li><a onclick="changeTheme(event);" class="green-dark-theme">8</a></li>
            <li><a onclick="changeTheme(event);" class="yellow-dark-theme">9</a></li>

            <li><a onclick="changeTheme(event);" class="blue-dark-theme">10</a></li>
            <li><a onclick="changeTheme(event);" class="purple-dark-theme">11</a></li>
            <li><a onclick="changeTheme(event);" class="megna-dark-theme">12</a></li>
        </ul>
        <ul id="rightbar-help-section">
            <li>
                <label for="homanyrows">
                            <?php echo $translation->translateLabel("Rows in grid"); ?>
                </label>
                <select id="howmanyrows" stIconbar="margin-left: 30px;" onchange="changeDefaultRowsInGrid(this);">
                </select>
            </li>
            <li>
                <a style="color: #999; width: 100%; margin-left: 0px" target="_blank" href="http://dms.newtechautomotiveservices.com:8084/EnterpriseHelp/usermanual/index.php">
                    Help Documentation
                </a>
            </li>
        </ul>
    </div>
</div>
<script>
 var gridViewDefaultRowsInGrid = localStorage.getItem('gridViewDefaultRowsInGrid');
 if(!gridViewDefaultRowsInGrid)
     localStorage.setItem('gridViewDefaultRowsInGrid', gridViewDefaultRowsInGrid = 10);
 
 $(document).ready(function () {
     var showLeftMenu = localStorage.getItem('showLeftMenu');

     if (showLeftMenu == "true") {
         $('#left-menu-control').attr('checked', true);
     } else {
         $('.left-menu').hide();
     }

    //  var showIconbar = localStorage.getItem('showIconbar');

    //  if (showIconbar == "true") {
    //      $('#iconbar-control').attr('checked', true);
    //  } else {
    //      $('.bs-glyphicons').hide();
    //  }

     var rowOptions = [10, 25, 50,100];
     var howmanyrows = $("#howmanyrows"), ind, _html = "";
     for(ind in rowOptions)
	 _html += "<option " + ( rowOptions[ind] == gridViewDefaultRowsInGrid ? "selected" : "") + ">" + rowOptions[ind] + "</option>";
     howmanyrows[0].innerHTML = _html;
 });

 function showLefMenu() {
     if ($('#left-menu-control').prop("checked")) {
         $('.left-menu').show();
     } else {
         $('.left-menu').hide();
     }
     localStorage.setItem("showLeftMenu", $('#left-menu-control').prop("checked"));
 }
//  function showIconbar() {
//      if ($('#iconbar-control').prop("checked")) {
//          $('.bs-glyphicons').show();
//          setTimeout(function() {
//             $('#view_css').attr('href', 'assets/css/views/iconbar.css');
//         }, 0);

//      } else {
//          $('.bs-glyphicons').hide();
//          setTimeout(function() {
//             $('#view_css').attr('href', 'assets/css/views/standart.css');
//         }, 0);

//      }
//      localStorage.setItem("showIconbar", $('#iconbar-control').prop("checked"));
//  }

 function unlockMyRecords(){
     var itemData = $("#lockData");
     $.post("<?php echo $linksMaker->makeProcedureLink("SystemSetup/SecuritySetup/UnlockRecords", "unlockSelected"); ?>", itemData.serialize(), null, 'json').success(function(data){
	 console.log(data);
     })
      .error(function(data){
	  console.log(data);
      });
 }

 function changeTheme(event) {
     localStorage.setItem("theme", event.target.className);
     $('.working').removeClass('working');
     $('#theme_css').attr('href', 'assets/css/simple/colors/' + event.target.className + '.css');
     $(event.target).addClass('working');
 }

 function changeDefaultRowsInGrid(item){
     localStorage.setItem('gridViewDefaultRowsInGrid', gridViewDefaultRowsInGrid = parseInt($(item).val()));
 }
</script>
