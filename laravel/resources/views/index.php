<!DOCTYPE html>
<!-- saved from url=(0046)http://demo.espocrm.com/basic/?lang=en_US#Lead -->
<html>
    <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><?php echo $app->title; ?></title>
	<script src="<?php echo $public_prefix; ?>/dependencies/plugins/bower_components/jquery/dist/jquery.min.js"></script>
	<!-- <script src="<?php echo $public_prefix; ?>/dependencies/assets/bootstrap/dist/js/bootstrap.min.js"></script> -->	
	<script type="text/javascript" src="<?php echo $public_prefix; ?>/assets/js/espo.min.js" data-base-path=""></script>
	<script src="chrome-extension://mclbjdibcpiohnhgkjkbfbnjcafkhani/files/foreground.js"></script>
 	<?php
	if(isset($header))
	    require $header;
	?>
	<link href="<?php echo $public_prefix; ?>/assets/css/newtechcrm-vertical.css" rel="stylesheet">
 	<link href="<?php echo $public_prefix; ?>/assets/css/style.css" rel="stylesheet">
	<meta content="utf-8" http-equiv="encoding">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="description" content="">
	<meta name="mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<link rel="shortcut icon" sizes="196x196" href="http://demo.espocrm.com/basic/client/img/favicon196x196.png">
	<link rel="icon" href="http://demo.espocrm.com/basic/client/img/favicon.ico" type="image/x-icon">
	<link rel="shortcut icon" href="http://demo.espocrm.com/basic/client/img/favicon.ico" type="image/x-icon">
	<style>
	 .sidebar-active{
	     background : red;
	 }
	 body.minimized .nav-item-level2{
	     margin-left:0px !important;
	     padding-left:3px !important;
	 }
	 .nav-item-level2{
	     padding-left:10px;
	 }
	 
	 body.minimized .nav-item-level1{
	     margin-left:0px !important;
	     padding-left:8px !important;
	 }
	 .nav-item-level1{
	     margin-left:0px;
	     padding-left:0px;
	 }

	 .navbar-items{
	     margin-top: 0px !important;
	     padding-left: 0px !important;
	     padding-right: 0px !important;
	     margin-left: 0px !important;
	     margin-right: 0px !important;
	     width : 100%;
	 }

	 .top-bar{
	     height : 70px !important;
	 }

	 
	 .top-bar-offset{
	     margin-top : 50px !important;
	 }

	 .top-bar-shower-off{
	     display : none;
	 }
	 
	 @media screen and (max-width : 768px){
	     .top-bar-toggler{
		 display:none !important;
	     }

	     div.sidebar-toggler{
		 display:none;
	     }
	     .hide-on-handsheld{
		 display:none;
	     }
	 }
	 
	 @media screen and (min-width : 768px){
	     .hide-logo{
		 display: none;
	     }
	     .sidebar-toggler{
		 position:absolute;
		 left : 12px;
		 bottom:10px;
	     }
	     
	     div.sidebar-toggler a{
		 color:white;
		 text-decoration:none;
	     }

	     body.top-bar-minimized .top-bar{
		 /*height : 10px !important;*/
		 display : none;
	     }

	     body.top-bar-minimized .top-bar-offset{
		 margin-top : 0px !important;
		 padding-top : 0px !important;
	     }

	     body.minimized .navbar-right{
		 width : 100% !important; 
	     }
	     
	     .hide-on-small{
		 display : none !important;
	     }
	     .top-bar-offset{
		 margin-top : 0px;
	     }
	     .top-bar-shower{
		 display : block;
		 position:fixed;
		 top:5px;
		 right:7px;
		 text-decoration:none !important;
	     }
	     .top-bar-link{
		 margin-left:20px;
		 margin-top:40px;
	     }
	     li.top-bar-link a{
		 color:gray !important;
	     }
	     li.top-bar-link a:hover{
		 color:black !important;
	     }
	 }
	</style>
    </head>
    <?php
    $menuCategories = [];
    if($user["accesspermissions"]["GLView"]){
	$menuCategories["GeneralLedger"] = [
	    "id" => "GeneralLedger",
	    "full"=> $translation->translateLabel('Ledger'),
	    "short" => "GL",
	    "type" => "submenu",
	    "data" => [
		[
		    "id" => "GeneralLedger/chartOfAccounts",
		    "full" => $translation->translateLabel('Chart Of Accounts'),
		    "short" => "CO",
		    "href"=> $public_prefix . "/grid/GeneralLedger/chartOfAccounts/grid/main/all"
		],
		[
		    "id" => "GeneralLedger/ledgerAccountGroup",
		    "full" => $translation->translateLabel('Ledger Account Group'),
		    "short" => "LA",
		    "href" => $public_prefix . "/grid/GeneralLedger/ledgerAccountGroup/grid/main/all"
		],
		[
		    "id" => "GeneralLedger/bankTransactions",
		    "full" => $translation->translateLabel('Bank Transactions'),
		    "short" => "BT",
		    "href" => $public_prefix . "/grid/GeneralLedger/bankTransactions/grid/main/all"
		],
		[
		    "id" => "GeneralLedger/bankAccounts",
		    "full" => $translation->translateLabel('Bank Accounts'),
		    "short" => "BA",
		    "href" => $public_prefix . "/grid/GeneralLedger/bankAccounts/grid/main/all"
		]
	    ]
	];
    }

    $menuCategories["Payables"] = [
	"type" => "submenu",
	"id" => "Payables",
	"full" => $translation->translateLabel('Accounts Payable'),
	"short" => "Pa",
	"data" => [
	    [
		"id" => "Payables/PurchaseOrders",
		"full" => $translation->translateLabel('Purchase Orders'),
		"href"=> "#",
		"short" => "PO"
	    ],
	    [
		"id" => "Payables/Vouchers",
		"full" => $translation->translateLabel('Vouchers'),
		"href" => "#",
		"short" => "Vo"
	    ],
	    [
		"id" => "Payables/Vendors",
		"full" => $translation->translateLabel('Vendors'),
		"href" => "#",
		"short" => "Ve"
	    ]
	]
    ];

    $menuCategories['Receivables'] = [
	"type" => "submenu",
	"id" => "Receivables",
	"full" => $translation->translateLabel('Receivables'),
	"short" => "Re",
	"data" => [
	    [
		"id" => "Receivables/Quotes",
		"full" => $translation->translateLabel('Quotes'),
		"short" => "Qu",
		"href"=> "#"
	    ],
	    [
		"id" => "Receivables/Orders",
		"full" => $translation->translateLabel('Orders'),
		"short" => "Or",
		"href" => "#"
	    ],
	    [
		"id" => "Receivables/Invoices",
		"full" => $translation->translateLabel('Invoices'),
		"short" => "In",
		"href" => "#"
	    ]
	]
    ];

    $menuCategories["Documentation"] = [
	"type" => "item",
	"data" => [
	    "id" => "Documentation",
	    "full" => $translation->translateLabel('Help Documentation'),
	    "short" => "HD",
	    "href" => "https://stfbinc.helpdocs.com",
	    "Target" => "_Blank"
	]
    ];
    
    $menuCategories["SupportTicket"] = [
	"type" => "item",
	"data" => [
	    "id" => "Support",
	    "full" => $translation->translateLabel('Support Ticket'),
	    "short" => "ST",
	    "href" => "https://stfbinc.teamwork.com/support/",
	    "Target" => "_Blank"
	]
    ];

    /*    $menuCategories["Support"] = [
       "id" => "Support",
       "full" => $translation->translateLabel('Support'),
       "short" => "Sp",
       "type" => "submenu",
       "data" => [
       [
       "full" => $translation->translateLabel('Help Documentation'),
       "short" => "HD",
       "href" => "https://stfbinc.helpdocs.com",
       "Target" => "_Blank"
       ],
       [
       "full" => $translation->translateLabel('Support Ticket'),
       "short" => "ST",
       "href" => "https://stfbinc.teamwork.com/support/",
       "Target" => "_Blank"
       ]
       ]
       ];*/
    ?>
    <body onload="main();" style="min-height: 450px;" class="">
	<header id="header">
	    <div id="navbar">
		<div class="navbar navbar-inverse" role="navigation">
		    <div class="navbar-header top-bar">
			<a class="navbar-brand nav-link logo-link" href="<?php echo $public_prefix; ?>/index"><img id="logosection"  src="<?php echo $public_prefix; ?>/assets/images/logo.png" class="logo"><span class="home-icon glyphicon glyphicon-th-large" title="Home"></span></a>
			<button type="button" class="navbar-toggle hide-on-small" data-toggle="collapse" data-target=".navbar-body">
			    <span class="icon-bar"></span>
			    <span class="icon-bar"></span>
			    <span class="icon-bar"></span>
			</button>
		    </div>

		    <div class="collapse navbar-collapse navbar-body">
			<ul id="sidebar" class="nav navbar-nav tabs" style="margin-top:0px; height: 400px;"> <!-- 178 -->
			    <?php
			    foreach ($menuCategories as $key=>$item){
				if($item["type"] == "item")
				    echo "<li><ul class=\"nav navbar-nav tabs navbar-items\"><li data-name=\"". ( key_exists("id", $item["data"]) ? $item["data"]["id"] : "") ."\"  class=\"not-in-more\"><a href=\"" . $item["data"]["href"] . "\" class=\"nav-link nav-item-level1\"><span class=\"full-label\">". $item["data"]["full"] ."</span><span class=\"short-label\" title=\"". $item["data"]["short"] ."\">". $item["data"]["short"] ."</span></a></li></ul></li>";
				else if($item["type"] == "submenu"){			
				    /*echo "<li data-name=\"". $key ."\" class=\"not-in-more\"><a href=\"" . $key . "\" class=\"nav-link\"><span class=\"full-label\">". $key ."</span><span class=\"short-label\" title=\"". $key ."\">". $key ."</span></a></li>";*/
				    echo "<li><ul class=\"nav navbar-nav tabs navbar-items\"><li data-name=\"". $key ."\"  class=\"not-in-more\"><a class=\"nav-item-level1\" href=\"#list" . $item["id"] . "\" data-toggle=\"collapse\"><span class=\"full-label\">". $item["full"] ."</span><span class=\"short-label\" title=\"". $item["short"] ."\">". $item["short"] ."</span></a></li>";
				    echo "<li id=\"list" . $item["id"] . "\" class=\"collapse-sidebar-item collapse in\" data-name=\"" . $key ."\" class=\"not-in-more\" style=\"display:none\">";
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
			<ul class="nav navbar navbar-nav navbar-right top-bar hide-on-handsheld">
			    <?php
			    foreach ($menuCategories as $key=>$item){
				if($item["type"] == "item")
				    echo "<li class=\"top-bar-link\"><a  href=\"" . $item["data"]["href"] . "\">". $item["data"]["full"] . "<span class=\"sr-only\">(current)</span></a></li>";
				else if($item["type"] == "submenu"){
				    echo "<li class=\"dropdown top-bar-link\">";
				    echo "<a class=\"dropdown-toggle\" data-toggle=\"dropdown\" href=\"#\" role=\"button\" aria-haspopup=\"true\" aria-expanded\"false\">"  . $item["full"] . " <span class=\"caret\"></span></a>";
				    echo "<ul class=\"dropdown-menu\">";
				    foreach($item["data"] as $key=>$subitem){
					echo "<li><a href=\"" . $subitem["href"] . "\" class=\"nav-link\">" . $subitem["full"] ."</a></li>";
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
			    <li class="pull-right top-bar-toggler" style="margin-top:45px;">
				<a class="minimizer" class="dropdown-toggle" href="javascript:toggleTopBar()">
				    <span id="topBarHider" class="glyphicon glyphicon glyphicon-menu-up"></span>
				</a>
			    </li>
			</ul>
			<div class="sidebar-toggler">
			    <a class="minimizer" href="javascript:toggleSideBar()">
				<span id="sideBarHider" class="glyphicon glyphicon glyphicon-menu-left"></span>
				<span id="sideBarShower" style="display:none;" class="glyphicon glyphicon glyphicon-menu-right"></span>
			    </a>
			</div>
		    </div>
		</div>
	    </div>
	</header>
	<a class="minimizer top-bar-shower-off top-bar-toggler" href="javascript:toggleTopBar()">
	    <span id="topBarShower" class="glyphicon glyphicon glyphicon-menu-down"></span>
	</a>
	<?php require "footer.php"; ?>
	<div id="content" class="container content top-bar-offset" style="background: #ffffff">
	    <?php
	    if(isset($content))
		require $content;
	    ?>
	</div>
	<div id="popup-notifications-container" class="hidden"></div>
	<script>
	 function sideBarCloseAll(){
	     var items = $(".collapse-sidebar-item");
	     items.css('display', 'none');
	     items.collapse('hide');
	     items.on('hidden.bs.collapse', function (e) {
		 $(e.currentTarget).css('display', 'none');
	     });
	     items.on('show.bs.collapse', function (e) {
		 sideBarCloseAll();
		 $(e.currentTarget).css('display', 'block');
	     })
	 }

	 function sideBarSelectItem(folder, item){
	     console.log($("#list" + folder));
	     var _item = $("#list" + folder);
	     setTimeout(function(){
		 _item.collapse('show');
		 _item.css('display', 'block');
	     }, 1000);
	     document.getElementById(folder + '/' + item).className += " sidebar-active";
	 }
	 
	 function main(){
	     sideBarCloseAll();
	     <?php if(isset($scope)): ?>
	     sideBarSelectItem("<?php echo  $scope["pathFolder"] . "\",\"" . $scope["pathPage"];?>");
	     <?php endif; ?>
	 }

	 var sidebarToggled = true;
	 function toggleSideBar(){
	     if(sidebarToggled){
		 $('body').addClass('minimized');
		 /*$('#sidebar')[0].style.display = 'none';
		    console.log($('#sidebar'));*/
		 $('#logosection').addClass("hide-logo");
		 $('#sideBarHider')[0].style.display = 'none';
		 $('#sideBarShower')[0].style.display = 'block';
		 sidebarToggled = false;
	     }else{
		 $('body').removeClass('minimized');
		 /*$('#sidebar')[0].style.display = 'block';*/
		 $('#logosection').removeClass("hide-logo");
		 $('#sideBarHider')[0].style.display = 'block';
		 $('#sideBarShower')[0].style.display = 'none';
		 sidebarToggled = true;
	     }
	 }

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

	 function onlocation(location){
	     var path = new String(location);
	     if(path.search(/index\#\//) != -1){
		 path = path.replace(/index\#\//, "");
		 console.log(path);
		 $.get(path + "?partial=true")
		     .done(function( data ) {
			 $( "#content" ).html( data );
		     });
	     }
	 }

	 onlocation(window.location);
	 $(window).on('hashchange', function() {
	     onlocation(window.location);
	 });
	</script>
    </body>
</html>
