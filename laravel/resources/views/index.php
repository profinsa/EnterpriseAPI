<!DOCTYPE html>
<!-- saved from url=(0046)http://demo.espocrm.com/basic/?lang=en_US#Lead -->
<html>
    <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><?php echo $app->title; ?></title>
 	<?php
	if(isset($header))
	    require $header;
	?>
	<meta content="utf-8" http-equiv="encoding">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="description" content="">
	<meta name="mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<style>
	 .navbar-nav>.open>a {
	     background : #E0E0E0 !important;
	     color : black !important;
	 }
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

	 .white-box{
	     background: #ffffff;
	     padding: 25px;
	     margin-bottom: 15px;
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
		    "href"=> $public_prefix . "/index#/grid/GeneralLedger/chartOfAccounts/grid/main/all"
		],
		[
		    "id" => "GeneralLedger/ledgerAccountGroup",
		    "full" => $translation->translateLabel('Ledger Account Group'),
		    "short" => "LA",
		    "href" => $public_prefix . "/index#/grid/GeneralLedger/ledgerAccountGroup/grid/main/all"
		],
		[
		    "id" => "GeneralLedger/bankTransactions",
		    "full" => $translation->translateLabel('Bank Transactions'),
		    "short" => "BT",
		    "href" => $public_prefix . "/index#/grid/GeneralLedger/bankTransactions/grid/main/all"
		],
		[
		    "id" => "GeneralLedger/bankAccounts",
		    "full" => $translation->translateLabel('Bank Accounts'),
		    "short" => "BA",
		    "href" => $public_prefix . "/index#/grid/GeneralLedger/bankAccounts/grid/main/all"
		]
	    ]
	];
    }

    $menuCategories["Payables"] = [
	"type" => "submenu",
	"id" => "Payables",
	"full" => $translation->translateLabel('Accounts Payable'),
	"short" => "AP",
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
	"short" => "AR",
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
			<?php  require "nav/sidebar.php"; ?>
			<?php  require "nav/topbar.php"; ?>
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
	 var sidebarItems = $(".collapse-sidebar-item");
	 sidebarItems.on('hidden.bs.collapse', function (e) {
	     $(e.currentTarget).css('display', 'none');
	 });
	 sidebarItems.on('show.bs.collapse', function (e) {
	     sideBarCloseAll();
	     $(e.currentTarget).css('display', 'block');
	 })
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
	 
	 function main(){
	     <?php if(isset($scope)): ?>
	     sideBarSelectItem("<?php echo  $scope["pathFolder"] . "\",\"" . $scope["pathPage"];?>");
	     <?php endif; ?>
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
	     var match;
	     if(path.search(/index\#\//) != -1){
		 path = path.replace(/index\#\//, "");
		 match = path.match(/grid\/(\w+)\/(\w+)\//);
		 if(match)
		     sideBarSelectItem(match[1], match[2]);
		 
		 $.get(path + "?partial=true")
		  .done(function(data){
		      setTimeout(function(){
			  $("#content").html(data);
		      },0);
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
