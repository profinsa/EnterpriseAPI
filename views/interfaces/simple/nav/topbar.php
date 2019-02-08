<ul id="topbarMenu" class="nav navbar navbar-nav navbar-right top-bar hide-on-handsheld" style="width: 100% !important; padding-left: 10px; z-index:100; height:auto;">
    <?php
        $public_prefix = "";
	foreach ($leftMenu["Main"]["data"] as $key=>$item){
            if($item["type"] == "submenu" && $security->checkMenu($item["id"])){
		echo "<li class=\"dropdown top-bar-link\">";
		echo "<a class=\"dropdown-toggle\" data-toggle=\"dropdown\" href=\"#\" role=\"button\" aria-haspopup=\"true\" aria-expanded\"false\">"  . $item["full"] . "</a>";

		echo '<ul id="' . $item["id"] . '"class="dropdown-menu" style="width: 300px">';
		foreach($item["data"] as $key=>$subitem){
                    echo "<li class=\"dropdown-submenu\">";
		    if(!key_exists("type", $subitem)){
			$href = preg_match("/^http/", $subitem["href"]) ?
				$subitem["href"] : "index.php#/?page=grid&action=" . (key_exists("href_ended", $subitem) ? $ssubitem["href_ended"] : $subitem["id"]);
			echo "<li><a href=\"" . $href . "\" class=\"nav-link\"" . (key_exists("target", $subitem) && $subitem["target"] == "_blank" ? "target=\"_blank\"" : "") . ">" . $subitem["full"] ."</a></li>";
			//			echo "<a class=\"mysubmenu\" href=\"#\"><div class=\"row\"><span style=\"float:left\">" . $subitem["full"] . "</span><span class=\"glyphicon glyphicon-menu-right pull-right\" style=\"margin-top:2px;\"></span></div></a>\n";
		    }else if($subitem["type"] == "relativeLink") {
			$href = (key_exists("target", $subitem) && $subitem["target"] == "_blank" ? "index.php?" : "index.php#/?") . $subitem["href"];
			echo "<li><a href=\"" . $href . "\" class=\"nav-link\"" . (key_exists("target", $subitem) && $subitem["target"] == "_blank" ? "target=\"_blank\"" : "") . ">" . $subitem["full"] ."</a></li>";
		    }else if($subitem["type"] == "item"){
			//$href = preg_match("/^http/", $subitem["href"]) ? $subitem["href"] : $public_prefix . "/index#/grid/" . (key_exists("href_ended", $subitem) ? $subitem["href_ended"] : $subitem["id"] . "/grid/Main/all");
		    }else if($subitem["type"] == "submenu"){
			echo "<a class=\"mysubmenu\" href=\"#\"><div class=\"row\"><span style=\"float:left\">" . $subitem["full"] . "</span><span class=\"glyphicon glyphicon-menu-right pull-right\" style=\"margin-top:2px;\"></span></div></a>\n";
			echo "<ul class=\"dropdown-menu\" style=\"width: 300px\">";
			foreach($subitem["data"] as $ssubitem){
			    if(!key_exists("type", $ssubitem)){
				// $href = preg_match("/^http/", $ssubitem["href"]) ? $ssubitem["href"] : $public_prefix . "/index#/grid/" . $ssubitem["id"] . "/grid/main/all";
				$href = preg_match("/^http/", $ssubitem["href"]) ? $ssubitem["href"] : "index.php#/?page=grid&action=" . (key_exists("href_ended", $ssubitem) ? $ssubitem["href_ended"] : $ssubitem["id"]);
				echo "<li><a href=\"" . $href . "\" class=\"nav-link\"" . (key_exists("target", $ssubitem) && $ssubitem["target"] == "_blank" ? "target=\"_blank\"" : "") . ">" . $ssubitem["full"] ."</a></li>";
			    }else if($ssubitem["type"] == "submenu"){
				//echo json_encode($ssubitem["data"]);
				foreach($ssubitem["data"] as $sssubitem){
				    if(key_exists("type", $sssubitem) && $sssubitem["type"] == "submenu"){
				    }else{
					if(key_exists("type", $sssubitem) && $sssubitem["type"] == "relativeLink")
					    $href = (key_exists("target", $sssubitem) && $sssubitem["target"] == "_blank" ? "index.php?" : "index.php#/?") . $sssubitem["href"];
					else
					    $href = preg_match("/^http/", $sssubitem["href"]) ? $sssubitem["href"] : "index.php#/?page=grid&action=" . $sssubitem["id"];
					echo "<li><a href=\"" . $href . "\" class=\"nav-link\"" . (key_exists("target", $sssubitem) && $sssubitem["target"] == "_blank" ? "target=\"_blank\"" : "") . ">" . $sssubitem["full"] ."</a></li>";
				    }
				}
			    }else if($ssubitem["type"] == "relativeLink"){
				$href = (key_exists("target", $ssubitem) && $ssubitem["target"] == "_blank" ? "index.php?" : "index.php#/?") . $ssubitem["href"];
				echo "<li><a href=\"" . $href . "\" class=\"nav-link\"" . (key_exists("target", $ssubitem) && $ssubitem["target"] == "_blank" ? "target=\"_blank\"" : "") . ">" . $ssubitem["full"] ."</a></li>";
			    }
			}
			echo "</ul>";
		    };
		    echo "</li>";
		}
		echo "</ul></li>";
	    }
	}
    ?>
</ul>
<div class="custom-menu-bar">
    <ul id="custom-toolbar" class="nav">
	<li class="top-bar-link2 float-right">
            <a class="mysubmenu" href="javascript:toggleStyleBar()" title="<?php echo $translation->translateLabel('Profile'); ?>">
		<span style="font-size: 30px" class="favorits glyphicon glyphicon-user" aria-hidden="true"></span>
            </a>
	</li>
	<!-- <li class="top-bar-link2 float-right dropdown-submenu bs-glyphicons2" style="background-color: unset;">
             <a class="mysubmenu" title="<?php echo $translation->translateLabel('Favorits'); ?>">
             <span style="font-size: 30px;" class="favorits glyphicon glyphicon-heart" aria-hidden="true"></span>
             </a>
             <?php
		 foreach ($menuCategories as $key=>$item){
                 if ($item["type"] == "custom") {
                 echo "<ul id=\"" . $item["id"] . "2\" class=\"iconbarsubmenu dropdown-menu\" style=\"z-index: 9999; top: auto !important; left: auto !important; right: 0 !important\">";
                 foreach($item["actions"] as $key=>$subitem) {
                 echo '<li id="' . $subitem["id"] . '2" onclick="' . $subitem["action"] . '"  style="height:60px; width: 100%"><a style="width: 100%; height: 100%; padding-top: 25px;padding-right: 5px; padding-left: 5px;" href="javascript:;" class="nav-link">' . $subitem["full"] .'</a></li>';
                 }
                 echo '</ul>';
                 }
		 }        
		 ?>
	     </li> -->
	<li class="top-bar-link2 float-right">
            <a  class="mysubmenu" href="https://stfbinc.teamwork.com/support" target="_blank" title="<?php echo $translation->translateLabel('Help'); ?>">
		<span style="font-size: 30px" class="favorits glyphicon glyphicon-question-sign" aria-hidden="true"></span>
            </a>
	</li>
	<!--<li class="top-bar-link2 float-right">
             <a class="mysubmenu dropdown-toggle" data-toggle="dropdown">
             <span style="font-size: 30px" class="favorits glyphicon glyphicon-modal-window"></span>
             </a>
             
             <ul class="dropdown-menu pull-right" style="width: 300px">
             <li><a href="<?php echo "makeEmbeddedgridItemNewLinkWithDirectBackPayroll/EmployeeSetup/ViewTaskList\", \"$public_prefix/index#/dashboard\", \"new\", \"\")" ?>" class="nav-link">Add Task</a></li>
             <li><a href="<?php echo "makeEmbeddedgridItemNewLinkWithDirectBack(CRMHelpDesk/CRM/ViewLeads\", \"$public_prefix/index#/dashboard\", \"new\", \"\")" ?>" class="nav-link">Add Follow-up</a></li>
             <li><a href="<?php echo "makeEmbeddedgridItemNewLinkWithDirectBack(AccountsReceivable/Customers/ViewCustomers, $public_prefix/index#/dashboard, new, )" ?>" class="nav-link">Add Customer Contact</a></li>
             </ul>
	     </li>
             <li class="top-bar-link2 float-right">
             <a  class="mysubmenu" href="#" target="_blank" title="<?php echo $translation->translateLabel('Email'); ?>">
             <span style="font-size: 30px" class="favorits glyphicon glyphicon-envelope" aria-hidden="true"></span>
             </a>
	     </li>
	     <li class="top-bar-link2 float-right">
             <div class="search-wrapper-id inner-addon right-addon">
             <span onclick="startSearch();" id="search-submit-id" class="glyphicon glyphicon-search"></span>
             <input id="search-input-id" style="margin: 11px 0px" type="search" class="form-control input-sm" placeholder="Enter your search" />
             </div>
             <div id="search-table-wrapper-id" style="display: none; min-width: 400px; padding: 15px; position: absolute; right: 0; background-color: white; border: 3px solid #d3d3d3;">
             <table id="search-table" class="table table-striped table-bordered">
             <thead>
             <tr>
             <th>
             <?php echo $translation->translateLabel("Customer ID")?>
             </th>
             <th>
             <?php echo $translation->translateLabel("Customer First Name")?>
             </th>
             <th>
             <?php echo $translation->translateLabel("Customer Last Name")?>
             </th>
             </tr>
             </thead>
             <tbody>
             </tbody>
             </table>
             </div>
	     </li>    
	     <li class="top-bar-link2 float-right">
             <a class="mysearch">
             <span style="font-size: 30px" class="glyphicon glyphicon-search" aria-hidden="true"></span>
             </a>
	     </li> -->
    </ul>
</div>
<script>
 //"https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"
 //inlined for fast
 /*!
    DataTables Bootstrap 3 integration
    В©2011-2015 SpryMedia Ltd - datatables.net/license
  */
 setTimeout(function() {
     (function(b){"function"===typeof define&&define.amd?define(["jquery","datatables.net"],function(a){return b(a,window,document)}):"object"===typeof exports?module.exports=function(a,d){a||(a=window);if(!d||!d.fn.dataTable)d=require("datatables.net")(a,d).$;return b(d,a,a.document)}:b(jQuery,window,document)})(function(b,a,d,m){var f=b.fn.dataTable;b.extend(!0,f.defaults,{dom:"<'row'<'col-sm-6'l><'col-sm-6'f>><'row'<'col-sm-12'tr>><'row'<'col-sm-5'i><'col-sm-7'p>>",renderer:"bootstrap"});b.extend(f.ext.classes,
																																																															 {sWrapper:"dataTables_wrapper form-inline dt-bootstrap",sFilterInput:"form-control input-sm",sLengthSelect:"form-control input-sm",sProcessing:"dataTables_processing panel panel-default"});f.ext.renderer.pageButton.bootstrap=function(a,h,r,s,j,n){var o=new f.Api(a),t=a.oClasses,k=a.oLanguage.oPaginate,u=a.oLanguage.oAria.paginate||{},e,g,p=0,q=function(d,f){var l,h,i,c,m=function(a){a.preventDefault();!b(a.currentTarget).hasClass("disabled")&&o.page()!=a.data.action&&o.page(a.data.action).draw("page")};
																																																															     l=0;for(h=f.length;l<h;l++)if(c=f[l],b.isArray(c))q(d,c);else{g=e="";switch(c){case "ellipsis":e="&#x2026;";g="disabled";break;case "first":e=k.sFirst;g=c+(0<j?"":" disabled");break;case "previous":e=k.sPrevious;g=c+(0<j?"":" disabled");break;case "next":e=k.sNext;g=c+(j<n-1?"":" disabled");break;case "last":e=k.sLast;g=c+(j<n-1?"":" disabled");break;default:e=c+1,g=j===c?"active":""}e&&(i=b("<li>",{"class":t.sPageButton+" "+g,id:0===r&&"string"===typeof c?a.sTableId+"_"+c:null}).append(b("<a>",{href:"#",
																																																																																																																														  "aria-controls":a.sTableId,"aria-label":u[c],"data-dt-idx":p,tabindex:a.iTabIndex}).html(e)).appendTo(d),a.oApi._fnBindAction(i,{action:c},m),p++)}},i;try{i=b(h).find(d.activeElement).data("dt-idx")}catch(v){}q(b(h).empty().html('<ul class="pagination"/>').children("ul"),s);i!==m&&b(h).find("[data-dt-idx="+i+"]").focus()};return f});
     
 }, 1000);
</script>
<script>
 var topSubmenuToggled;
 var topbarChildren = $('#topbarMenu').clone();
 var stylebarToggled = false;
 var table = null;
 
 $(document).click(function(e){
     // $("#search-table-wrapper-id").hide();
     // topSubmenuToggled = false;
     // menuToggled = false;
     // $(this).next('ul').css('display', 'none');
     // $('.dropdown-submenu a.mysubmenu').css('display', 'none');
 });

 function toggleStyleBar() {
     if(stylebarToggled) {
         stylebarToggled = false;
         $('.right-sidebar')[0].style.display = 'none';
         $('.right-sidebar')[0].style.right = '-240px';
     } else {
         $('.right-sidebar')[0].style.display = 'block';
         $('.right-sidebar')[0].style.right = '0px';
         stylebarToggled = true;
     }
 }

 // var favbarToggled = false;
 // function toggleFavBar() {
 //     if(favbarToggled) {
 //         favbarToggled = false;
 //         $('.favbar')[0].style.display = 'none';
 //         $('.favbar')[0].style.right = '-240px';
 //     } else {
 //         $('.favbar')[0].style.display = 'block';
 //         $('.favbar')[0].style.right = '0px';
 //         favbarToggled = true;
 //     }
 // }

 // var topbarToggled = true;

 // function toggleTopBar(){
 //     if(topbarToggled){
 //         $('body').addClass('top-bar-minimized');
 //         $('.logo-link').addClass("hide-logo");
 //         $('.top-bar-shower-off').addClass('top-bar-shower');
 //         $('.top-bar-shower-off').removeClass('top-bar-shower-off');
 //         $('#topBarShower')[0].style.display = 'block';
 //         topbarToggled = false;
 //     }else{
 //         $('body').removeClass('top-bar-minimized');
 //         $('.logo-link').removeClass("hide-logo");
 //         $('.top-bar-shower').addClass('top-bar-shower-off');
 //         $('.top-bar-shower').removeClass('top-bar-shower');
 //         $('#topBarShower')[0].style.display = 'none';
 //         topbarToggled = true;
 //     }
 // }

 function initTopbarEvents() {
     $('.dropdown-submenu a.mysubmenu').on("mouseover", function(e){
         if (topSubmenuToggled) {
             $(topSubmenuToggled).next('ul').toggle();
         }
         topSubmenuToggled = this;
         $(this).next('ul').toggle();
         e.stopPropagation();
         e.preventDefault();
     });

     var menuToggled;
     $('.dropdown .top-bar-link').on("mouseover", function(e){
         if (menuToggled) {
             $(menuToggled).next('ul').toggle();
         }
         menuToggled = this;
         $(this).next('ul').toggle();
         e.stopPropagation();
         e.preventDefault();
     });

     $('.dropdown-submenu a.mysubmenu ul.dropdown-menu li a').on("click", function(e){
     });

 }

 initTopbarEvents();

 function createTypicalRootItem(id) {
     $('#topbarMenu').append(
         '<li class="dropdown top-bar-link"><a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded"false" aria-haspopup="true">' + id + '</a>' + 
         '<ul id="' + id + '"class="dropdown-menu" style="width: 300px"></ul></li>'
     );
 }


 function createTypicalItem(id, item) {
     $('#topbarMenu').append(
         '<li class="dropdown top-bar-link"><a href="' + linksMaker.makeGridLink(item.id) + '"  class="nav-link">' + item.full + '</a></li>'
     );
 }
 
 function createTypicalSubItem(id, item) {
     $('#' + id).append(
         '<li><a href="' + linksMaker.makeGridLink(item.id) + '"  class="mysubmenu">' + item.full + '</a></li>'
     );
 }

 function clearTopbarmenu() {
     var select = document.getElementById('topbarMenu');
     
     while (select.firstChild) {
         select.removeChild(select.firstChild);
     }
 }

 function fillTopmenu() {
     // topbarChildren = $('#topbarMenu').topbarChildren();

     clearTopbarmenu();

     $('#topbarMenu').append(topbarChildren);
     initTopbarEvents();
 }

 // fillTopmenu();

 function fillByTypical(key) {
     // topbarChildren = $('#topbarMenu').clone();
     clearTopbarmenu();

     var items = <?php echo json_encode($iconbarCategories); ?>,
	 topbar = items[key].topbar,
	 ind, iind, iiind, iiiind, item, subitem, ssubitem, sssubitem, _html = '', href;

     for(ind in topbar){
	 item = topbar[ind];
	 if(item["type"] == "submenu"){// && $security->checkMenu($item["id"])){ FIXME
 	     _html += "<li class=\"dropdown top-bar-link\">";
	     _html += "<a class=\"dropdown-toggle\" data-toggle=\"dropdown\" href=\"#\" role=\"button\" aria-haspopup=\"true\" aria-expanded\"false\">" + item["full"] + "</a>";

	     _html += '<ul id="' + item["id"] + '"class="dropdown-menu" style="width: 300px">';
	     for(iind in item.data){
		 subitem = item.data[iind];
		 _html += "<li class=\"dropdown-submenu\">";
		 if(!subitem.hasOwnProperty("type")){
		     href = subitem["href"].search(/^http/) != -1 ?
			    subitem["href"] : "index.php#/?page=grid&action=" + (subitem.hasOwnProperty("href_ended") ? subitem["href_ended"] : subitem["id"]);
		     _html += "<li><a href=\"" + href + "\" class=\"nav-link\"" + (subitem.hasOwnProperty("target") && subitem["target"] == "_blank" ? "target=\"_blank\"" : "") + ">" + subitem["full"] +"</a></li>";
		     //			echo "<a class=\"mysubmenu\" href=\"#\"><div class=\"row\"><span style=\"float:left\">" + $subitem["full"] + "</span><span class=\"glyphicon glyphicon-menu-right pull-right\" style=\"margin-top:2px;\"></span></div></a>\n";
		 }else if(subitem["type"] == "relativeLink") {
		     href = (subitem.hasOwnProperty("target") && subitem["target"] == "_blank" ? "index.php?" : "index.php#/?") + subitem["href"];
		     _html += "<li><a href=\"" + href + "\" class=\"nav-link\"" + (subitem.hasOwnProperty("target") && subitem["target"] == "_blank" ? "target=\"_blank\"" : "") + ">" + subitem["full"] +"</a></li>";
		 }else if(subitem["type"] == "item"){
		     //$href = preg_match("/^http/", $subitem["href"]) ? $subitem["href"] : $public_prefix + "/index#/grid/" + (key_exists("href_ended", $subitem) ? $subitem["href_ended"] : $subitem["id"] + "/grid/Main/all");
		 }else if(subitem["type"] == "submenu"){
		     _html += "<a class=\"mysubmenu\" href=\"#\"><div class=\"row\"><span style=\"float:left\">" + subitem["full"] + "</span><span class=\"glyphicon glyphicon-menu-right pull-right\" style=\"margin-top:2px;\"></span></div></a>\n";
		     _html += "<ul class=\"dropdown-menu\" style=\"width: 300px\">";
		     for(iiind in subitem["data"]){
			 ssubitem = subitem["data"][iiind];
			 if(!ssubitem.hasOwnProperty("type")){
			     // $href = preg_match("/^http/", $ssubitem["href"]) ? $ssubitem["href"] : $public_prefix + "/index#/grid/" . $ssubitem["id"] . "/grid/main/all";
			     href = ssubitem["href"].search(/^http/) != -1 ? ssubitem["href"] : "index.php#/?page=grid&action=" + (ssubitem.hasOwnProperty("href_ended") ? ssubitem["href_ended"] : ssubitem["id"]);
			     _html += "<li><a href=\"" + href + "\" class=\"nav-link\"" + (ssubitem.hasOwnProperty("target") && ssubitem["target"] == "_blank" ? "target=\"_blank\"" : "") + ">" + ssubitem["full"] +"</a></li>";
			 }else if(ssubitem["type"] == "submenu"){
			     //echo json_encode($ssubitem["data"]);
			     for(iiiind in ssubitem["data"]){
				 sssubitem = ssubitem["data"][iiiind];
				 if(sssubitem.hasOwnProperty("type") && sssubitem["type"] == "submenu"){
				 }else{
				     if(sssubitem.hasOwnProperty("type") && sssubitem["type"] == "relativeLink")
					 href = (sssubitem.hasOwnProperty("target") && sssubitem["target"] == "_blank" ? "index.php?" : "index.php#/?") + sssubitem["href"];
				     else
					 href = sssubitem["href"].search(/^http/) != -1 ? sssubitem["href"] : "index.php#/?page=grid&action=" + $sssubitem["id"];
				     _html += "<li><a href=\"" + href + "\" class=\"nav-link\"" + (sssubitem.hasOwnProperty("target") && sssubitem["target"] == "_blank" ? "target=\"_blank\"" : "") + ">" + sssubitem["full"] +"</a></li>";
				 }
			     }
			 }else if(ssubitem["type"] == "relativeLink"){
			     href = (ssubitem.hasOwnProperty("target") && ssubitem["target"] == "_blank" ? "index.php?" : "index.php#/?") + ssubitem["href"];
			     _html += "<li><a href=\"" + href + "\" class=\"nav-link\"" + (ssubitem.hasOwnProperty("target") && ssubitem["target"] == "_blank" ? "target=\"_blank\"" : "") + ">" + ssubitem["full"] +"</a></li>";
			 }
		     }
		     _html += "</ul>";
		 };
		 _html += "</li>";
	     }
	     _html += "</ul></li>";
	 }else{
 	     _html += "<li class=\"top-bar-link\">";
	     _html += "<a href=\"" + "index.php#/?page=grid&action=" + (item.hasOwnProperty("href_ended") ? item["href_ended"] : item["id"]) + "\" role=\"button\">" + item["full"] + "</a>";
	     _html += "</li>";
	 }
     }

     $('#topbarMenu').html(_html);
     initTopbarEvents();

     return;
     for(ind in topbar){
	 if(!topbar[ind].hasOwnProperty("data")){
	     createTypicalItem(topbar[ind], topbar[ind]);
	 }else{
	     createTypicalRootItem(makeId(topbar[ind].id));
	     
	     for(iind in topbar[ind].data)
		 createTypicalSubItem(makeId(topbar[ind].id), topbar[ind].data[iind])
	 }
     }

     return;
     var keys = Object.keys(items[key].topbar);

     for (var i = 0; i < keys.length; i++) {
	 if (Array.isArray(items[key].topbar[keys[i]])) {
	     if (!items[key].topbar[keys[i]].length) {
		 createTypicalItem(keys[i], {
		     id: '#',
		     full: keys[i]
		 });
	     } else {
		 createTypicalRootItem(keys[i]);
		 for (var j = 0; j < items[key].topbar[keys[i]].length; j++) {
		     createTypicalSubItem(keys[i], items[key].topbar[keys[i]][j])
		 }
	     }
	 } else {
	     if (items[key].topbar[keys[i]].hasOwnProperty('node')) {
		 createTypicalRootItem(keys[i]);
		 var nodes = topbarChildren.find('#' + items[key].topbar[keys[i]].node).clone().children();
		 
		 for ( var k = 0; k < nodes.length; k++) {
		     $('#' + keys[i]).append(nodes[k]);
		 }
		 initTopbarEvents();
	     } else {
		 createTypicalItem(keys[i], items[key].topbar[keys[i]]);
	     }
	 }
     }
 }

 function changeLanguage(event){
     $.getJSON("index.php?page=language&setLanguage=" + event.target.value)
      .success(function(data) {
	  location.reload();
      })
      .error(function(err){
	  console.log('something going wrong');
      });
 }

 function startSearch() {
     var input = $('input#search-input-id');
     $.post("<?php echo $linksMaker->makeProcedureLink("AccountsReceivable/OrderScreens/ViewOrders", "searchCustomer") ?>",{
	 searchText: input.val(),
     })
      .success(function(jsondata) {
	  $("#search-table-wrapper-id").show();
	  if (table) {
	      table.destroy();
	      table = null;
	      $('#search-table tbody').empty();
	  }
	  var select = $('#search-table tbody')[0];
	  
	  while (select.firstChild) {
	      select.removeChild(select.firstChild);
	  }

	  var data = JSON.parse(jsondata);
	  if (data) {
	      for (var i = 0; i < data.length; i++) {
		  var keyString = '<?php echo $user["CompanyID"] . "__" . $user["DivisionID"] . "__" . $user["DepartmentID"] . "__"; ?>' + data[i].CustomerID;
		  var CustomerFirstName = data[i].CustomerFirstName ? data[i].CustomerFirstName : '';
		  var CustomerLastName = data[i].CustomerLastName ? data[i].CustomerLastName : '';
		  $('#search-table tbody').append(
		      '<tr class="context-menu-row"><td><a href="<?php echo $linksMaker->makeGridItemView("AccountsReceivable/Customers/ViewCustomers", ""); ?>' + encodeURIComponent(keyString) + '"><span class="grid-action-button glyphicon glyphicon-edit" aria-hidden="true"></span></a></td><td>' + CustomerFirstName + '</td><td>' + CustomerLastName + '</td></tr>'
		  );
	      }
	  }

	  // setTimeout(function() {
	  table = $('#search-table').DataTable({
	      destroy: true,
	      filter: false,
	  });                
	  //            }, 1);
      })
      .error(function(err){
	  console.log(err);
      });

 }

 function initSearch() {
     var input = $('input#search-input-id');
     var divInput = $('div.search-wrapper-id');
     var width = divInput.width();
     var outerWidth = 400;
     var submit = $('#search-submit-id');
     var txt = input.val();

     input.mouseenter(function() {
	 if (input.val()) {
	     $("#search-table-wrapper-id").show();                
	 }
     });

     $("#search-table-wrapper-id").mouseleave(function() {
	 $("#search-table-wrapper-id").hide();
     });

     input.bind("enterKey",function(e){
	 startSearch();
     });

     input.keyup(function(e){
	 if(e.keyCode == 13)
	     {
		 $(this).trigger("enterKey");
	     }
     });

     
     input.bind('focus', function() {
	 // if(input.val() === txt) {
	 //     input.val('');
	 // }
	 // $(this).animate({color: '#000'}, 300); // text color
	 $(this).parent().animate({
	     width: outerWidth + 'px',
	     backgroundColor: '#fff', // background color
	     // paddingRight: '43px'
	 }, 0, function() {
	     if(!(input.val() === '' || input.val() === txt)) {
		 // if(!($.browser.msie && $.browser.version < 9)) {
		 //     submit.fadeIn(300);
		 // } else {
		 submit.css({display: 'block'});
		 // }
	     }
	 }).addClass('focus');
     }).bind('blur', function() {
	 // $(this).animate({color: '#b4bdc4'}, 300); // text color
	 $(this).parent().animate({
	     width: width + 'px',
	     backgroundColor: '#e8edf1', // background color
	     // paddingRight: '15px'
	 }, 0, function() {
	     if(input.val() === '') {
		 input.val(txt)
	     }
	 }).removeClass('focus');
	 // if(!($.browser.msie && $.browser.version < 9)) {
	 //     submit.fadeOut(100);
	 // } else {
	 setTimeout(function () {
	     submit.css({display: 'none'});
	 }, 1000);

	 // submit.css({display: 'none'});
	 // }    
     }).keyup(function() {
	 if(input.val() === '') {
	     // if(!($.browser.msie && $.browser.version < 9)) {
	     //     submit.fadeOut(300);
	     // } else {
	     submit.css({display: 'none'});
	     // }
	 } else {
	     // if(!($.browser.msie && $.browser.version < 9)) {
	     //     submit.fadeIn(300);
	     // } else {
	     submit.css({display: 'block'});
	     // }
	 }
     });
 }
 initSearch();
</script>