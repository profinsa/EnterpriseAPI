<?php
    $iconbarCategories = [
        "Customer" => [
            "full" => $translation->translateLabel('CUSTOMER'),
	    "link" => "index.php#/?page=dashboard&screen=Customer",
	    //            "link" => $linksMaker->makeGridLink("AccountsReceivable/Customers/ViewCustomers"),
            "iconclass" => "user",
            "data" => [
                [
		    "type" => "absoluteLink",
		    "href" => $linksMaker->makeGridItemNewPartial("AccountsReceivable/Customers/ViewCustomers"),
		    "full" => $translation->translateLabel('New Customer')
		],
                [
		    "id" => "AccountsReceivable/Customers/ViewCustomers",
		    "full" => $translation->translateLabel('View Customers')
		],
                [
		    "id" => "AccountsReceivable/Customers/ViewCustomerFinancials",
		    "full" => $translation->translateLabel('View Customer Balances')
                ],
	    ],
	    "topbar" => $leftMenu["Main"]["data"][2]["data"][0]["data"]
	],
	"Vendor" => [
	    "full" => $translation->translateLabel('VENDOR'),
	    "link" => "index.php#/?page=dashboard&screen=Vendor",
	    //	    "link" => $linksMaker->makeGridLink("AccountsPayable/Vendors/ViewVendors"),
	    "iconclass" => "user",
	    "data" => [
                [
		    "type" => "absoluteLink",
		    "href" => $linksMaker->makeGridItemNewPartial("AccountsPayable/Vendors/ViewVendors"),
		    "full" => $translation->translateLabel('New Vendor')
		],
                [
		    "id" => "AccountsPayable/Vendors/ViewVendors",
		    "full" => $translation->translateLabel('View Vendors')
		],
                [
		    "id" => "AccountsPayable/Vendors/ViewVendorFinancials",
		    "full" => $translation->translateLabel('View Vendor Balances')
		],
	    ],
	    "topbar" => $leftMenu["Main"]["data"][3]["data"][0]["data"]
	],
	"Items" => [
	    "full" => $translation->translateLabel('ITEM'),
	    "link" => "index.php#/?page=dashboard&screen=Item",
	    "iconclass" => "list",
	    "data" => [
                [
		    "id" => "Inventory/ItemsStock/ViewInventoryOnHand",
		    "full" => $translation->translateLabel('List Invetory') //FIXME
		],
                [
		    "id" => "Inventory/ItemsStock/ViewInventoryItems",
		    "full" => $translation->translateLabel('View Items')
		],
                [
		    "type" => "absoluteLink",
		    "href" => $linksMaker->makeGridItemNewPartial("Inventory/ItemsStock/ViewInventoryItems"),
		    "full" => $translation->translateLabel('New Item')
		],
	    ],
	    "topbar" => $leftMenu["Main"]["data"][4]["data"][0]["data"]
	],
	"Sales" => [
	    "full" => $translation->translateLabel('SALES'),
	    "link" => "index.php#/?page=dashboard&screen=SalesAndShipping",
	    "iconclass" => "list-alt",
	    "data" => [
                [
		    "type" => "absoluteLink",
		    "href" => $linksMaker->makeGridItemNewPartial("AccountsReceivable/OrderProcessing/ViewInvoices"),
		    "full" => $translation->translateLabel('New Invoice')
		],
		[
		    "id" => "AccountsReceivable/OrderProcessing/ViewInvoices",
		    "full" => $translation->translateLabel('View Invoices')
		]
	    ],
	    "topbar" => $leftMenu["Main"]["data"][2]["data"]
	],
	"Purchase" => [
	    "full" => $translation->translateLabel('PURCHASE'),
	    "link" => "index.php#/?page=dashboard&screen=PurchaseAndReceiving",
	    "iconclass" => "calendar",
	    "data" => [
                [
		    "type" => "absoluteLink",
		    "href" => $linksMaker->makeGridItemNewPartial("AccountsPayable/PurchaseProcessing/ViewPurchases"),
		    "full" => $translation->translateLabel('New Purchase')
		],
		[
		    "id" => "AccountsPayable/PurchaseProcessing/ViewPurchases",
		    "full" => $translation->translateLabel('View Purchases')
		],
		[
		    "id" => "AccountsPayable/PurchaseProcessing/ReceivePurchases",
		    "full" => $translation->translateLabel('Receive Purchase')
		]
	    ],
	    "topbar" => $leftMenu["Main"]["data"][3]["data"]
	],
	"Accounting" => [
	    "full" => $translation->translateLabel('ACCOUNTING'),
	    "link" => "index.php#/?page=dashboard",
	    "iconclass" => "calendar",
	    "data" => [
                [
		    "type" => "absoluteLink",
		    "href" => $linksMaker->makeGridItemNewPartial("GeneralLedger/Ledger/ViewGLTransactions"),
		    "full" => $translation->translateLabel('New GL Transaction')
		],
                [
		    "type" => "absoluteLink",
		    "href" => $linksMaker->makeGridItemNewPartial("Payroll/EmployeeManagement/ViewEmployees"),
		    "full" => $translation->translateLabel('New Employee')
		],
                /*			[
		   "id" => "ccountsPayable/Checks/QuickCheck",
		   "full" => $translation->translateLabel('Quick Check')
                   ],*/
		[
		    "id" => "AccountsReceivable/CashReceiptsProcessing/ViewCashReceipts",
		    "full" => $translation->translateLabel('Receive Payment') //FIXME
		],
		[
		    "id" => "AccountsPayable/VoucherScreens/ViewVouchers",
		    "full" => $translation->translateLabel('Make Payment') //FIXME
		],
	    ],
	    "topbar" => $leftMenu["Main"]["data"]
	],
	"Reports" => [
	    "full" => $translation->translateLabel('REPORTS'),
	    "link" => $linksMaker->makeGridItemNewPartial("Reports/Autoreport/GenericReportDetail") . "&category=Main&item=" . $user["CompanyID"] . '__' . $user["DivisionID"] . '__' . $user["DepartmentID"],
	    "iconclass" => "stats",
	    "data" => [
		[
		    "type" => "absoluteLink",
		    "href" => $linksMaker->makeGridItemNewPartial("Reports/Autoreport/GenericReportDetail") . "&category=Main&item=" . $user["CompanyID"] . '__' . $user["DivisionID"] . '__' . $user["DepartmentID"],
		    "full" => $translation->translateLabel('Reports Engine')
		],
		[
		    "type" => "relativeLink",
		    "href" => "page=financials&type=gaap&module=main",
		    "full" => $translation->translateLabel('Financial Statements GAAP')
		],
		[
		    "type" => "relativeLink",
		    "href" => "page=financials&type=ifrs&module=main",
		    "full" => $translation->translateLabel('Financial Statements IFRS')
		],
	    ],
	    "topbar" => $leftMenu["Main"]["data"][7]["data"]
	],
	"Favorits" => [
	    "full" => $translation->translateLabel('FAVORITES'),
	    "favorits" => true,
	    "iconclass" => "heart"
	],
	"Help" => [
	    "full" => $translation->translateLabel('HELP'),
	    "link" => "https://stfbinc.helpdocs.com",
	    "target" => "_blank",
	    "iconclass" => "question-sign",
            "data" => [
		[
		    "type" => "absoluteLink",
		    "target" => "_blank",
		    "href" => "https://stfbinc.teamwork.com/support/",
		    "full" => $translation->translateLabel('New Ticket')
		],
		[
		    "type" => "absoluteLink",
		    "target" => "_blank",
		    "href" => "https://stfbinc.helpdocs.com",
		    "full" => $translation->translateLabel('Help System')
		],
	    ]
	]
    ];
?>

<div class="bs-glyphicons">
    <ul class="bs-glyphicons-list" style="margin-top:44px">
        <?php
	    foreach ($iconbarCategories as $key=>$item){
		if (!key_exists("favorits", $item)) {
            $link = "";
            if(key_exists("link", $item))
                if(key_exists("target", $item) && $item["target"] == "_blank")
                    $link = "redirectBlank('{$item["link"]}');";
                else
                    $link = "location.href = '{$item["link"]}';";
		    echo '<li onmouseenter="onShowSubMenu(event, ' . "'$key'" . ');" onmouseleave="onHideSubMenu(event);" ><a onclick="'. $link . (key_exists("topbar", $item) ? 'topbarMenuRender(\''. $key . '\'); onTopbarUpdate();'  : 'topbarMenuRender(); onTopbarUpdate();')  .'" style="cursor: pointer"  class="mysubmenu"><span aria-hidden="true" class="glyphicon glyphicon-' . $item["iconclass"] . '"></span><span class="glyphicon-class">' . $item["full"] . '</span></a>';
		    if (key_exists("data", $item)) {
			echo "<ul onmouseenter=\"onShowSubMenu(event, " . "'$key'" . ");\" onmouseleave=\"onHideSubMenu(event);\" class=\"iconbarsubmenu dropdown-menu\" style=\" " . ($ascope["interfaceType"] == "rtl" ? "right: " : "left: ") . "99px !important; margin-top: -50px !important; z-index: 9999; width:fit-content\">";
			foreach($item["data"] as $subitem) {
			    $href = "";
			    if(!key_exists("type", $subitem))
				$href = $linksMaker->makeGridLink($subitem["id"]);
			    else if($subitem["type"] == 'relativeLink')
				$href = "index.php#/?" . $subitem["href"];
			    else if($subitem["type"] == 'absoluteLink')
				$href = $subitem["href"];
			    
			    echo '<li style="height:60px; width:auto; text-align:' . ($ascope["interfaceType"] == "rtl" ? "right" : "left") . ';"><a style="width: 100%; height: 100%; padding-top: 25px;padding-right: 10px; padding-left: 10px;" ' . (key_exists("target", $subitem) ? 'target="' . $subitem["target"] . '"' : '') . ' href="' . $href . '" class="nav-link">' . $subitem["full"] .'</a></li>';
			}
			echo '</ul>';
		    }
		    echo '</li>';
		} else {
		    echo '<li  onmouseenter="onShowSubMenu(event, ' . "'$key'" . ');" onmouseleave="onHideSubMenu(event);" ><a onclick="fillByFavorits();" style="cursor: pointer" class="mysubmenu"><span aria-hidden="true" class="glyphicon glyphicon-' . $item["iconclass"] . '"></span><span class="glyphicon-class">' . $item["full"] . '</span></a>';
		    foreach ($menuCategories as $key=>$item){
			if ($item["type"] == "custom") {
			    echo "<ul onmouseenter=\"onShowSubMenu(event, " . "'$key'" . ");\" onmouseleave=\"onHideSubMenu(event);\" id=\"" . $item["id"] . "\" class=\"iconbarsubmenu dropdown-menu\" style=\" " . ($ascope["interfaceType"] == "rtl" ? "right: " : "left: ") . "99px; !important; margin-top: -50px !important; z-index: 9999; width:fit-content\">";
			    foreach($item["actions"] as $key=>$subitem) {
				echo '<li id="' . $subitem["id"] . '"onclick="' . $subitem["action"] . '"  style="height:60px; width: 100%"><a style="width: 100%; height: 100%; padding-top: 25px;padding-right: 5px; padding-left: 5px;" href="javascript:;" class="nav-link">' . $subitem["full"] .'</a></li>';
			    }
			    echo '</ul>';
			}
		    }
		    echo '</li>';
		}
	    }
        ?>
    </ul>
</div>
<script>
 function onShowSubMenu(e, name) {
     var menu = $(e.target).find('ul'),
	 topbarHeight = parseInt($('#topbarMenu').css("height"));
     
     $(menu[0]).css({display: 'block'});
     if(name == "Customer")
	 $(menu[0]).css({top: (topbarHeight + 50) + 'px'});
     else if(topbarHeight > 100 && name == "Vendor")
	 $(menu[0]).css({top: (topbarHeight + 50) + 'px'});
     else
	 $(menu[0]).css({top: 'auto'});
 }

 function onTopbarUpdate(){
     var topbarHeight = parseInt($('#topbarMenu').css("height"));
     $('.bs-glyphicons-list').css('margin-top', topbarHeight + 'px');
 }

 function onHideSubMenu(e) {
     $('.iconbarsubmenu').css("display", "none");
     submenuToggled = false;
 }

 function sideBarCloseAll(){
     sidebarItems.css('display', 'none');
     sidebarItems.collapse('hide');
 }

 function sideBarCloseTwoLevelAll(){
     twoLevelItems.css('display', 'none');
     twoLevelItems.collapse('hide');
 }

 function sideBarCloseThreeLevelAll(){
     threeLevelItems.css('display', 'none');
     threeLevelItems.collapse('hide');
 }

 function sideBarDeselectAll(){
     $('.nav-item-level2, .nav-item-level3, .nav-item-level4').removeClass('left-iconbar-active');
 }

 function iconbarDeselectAll() {
     $('.bs-glyphicons li, .bs-glyphicons li a').removeClass('left-iconbar-active');
 }

 function sideBarSelectItem(object){
     var shortcuts = $("#MyShortcuts"), scChildren = shortcuts.children(), ind = 0;
     if(scChildren.length > 1){
	 while(ind != scChildren.length){
	     if(scChildren[ind].id == object.item.id){
		 //  $("li").removeClass('active');
		 //  $(scChildren[ind]).addClass('active');
		 //  shortcuts.parent().collapse("show");
		 //  shortcuts.parent().css("display:block");
		 return;
	     }
	     ind++;
	 }
     }else{
	 setTimeout(function(){
	     var scChildren = shortcuts.children(), ind = 0;
	     while(ind != scChildren.length){
		 if(scChildren[ind].id == object.item.id){
		     //  $(scChildren[ind]).addClass('active');
		     //console.log(scChildren[ind]);
		     //  shortcuts.parent().collapse("show");
		     //  shortcuts.parent().css("display:block");
		     //		 shortcuts.parent().collapse("hide");
		     //		 shortcuts.parent().collapse("show");
		 }
		 ind++;
	     }
	 }, 1500);
     }
     if(!object)
	 return;
     var _item = $(document.getElementById("list" + object.menu.id)), sitem, ssitem;
     //console.log(object, _item);
     if(!_item.hasClass('in')){
	 sideBarCloseAll();
	 setTimeout(function(){
	     _item.collapse('show');
	     _item.css('display', 'block');
	 }, 500);
     }

     if(object.hasOwnProperty("submenu")){
	 sitem = $(document.getElementById("list" + object.submenu.id.replace(/\//g, "")));
	 if(!sitem.hasClass('in')){
	     sideBarCloseTwoLevelAll();
	     setTimeout(function(){
		 sitem.collapse('show');
		 sitem.css('display', 'block');
	     }, 500);
	 }
     }

     if(object.hasOwnProperty("subsubmenu")){
	 ssitem = $(document.getElementById("list" + object.subsubmenu.id.replace(/\//g, "")));
	 if(!ssitem.hasClass('in')){
	     sideBarCloseThreeLevelAll();
	     setTimeout(function(){
		 sitem.collapse('show');
		 ssitem.css('display', 'block');
	     }, 500);
	 }
     }

     var selItem = document.getElementById(object.item.id);
     if(!$(selItem).hasClass("left-iconbar-active")){
	 sideBarDeselectAll();
	 $('.selItebs-glyphicons lim, .selItebs-glyphicons lim a').addClass("left-iconbar-active");
     }
 }

 function setIconbarActive(object){
     //  console.log(object.parentNode);
     iconbarDeselectAll();
     $(object).addClass("left-iconbar-active");
     $(object.parentNode).addClass("left-iconbar-active");
 }

 function fillByFavorits() {
     // clearCustomToolbar();
     // var shortcutsRaw = localStorage.getItem('shortcuts');
     // var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};
     // var keys = Object.keys(shortcuts).map(function (key) {
     //     return shortcuts[key];
     // }).sort(compare);
     // // var keys = Object.keys(shortcuts);
     // var parent = document.getElementById('custom-toolbar');

     // for (var i = 0; i < keys.length; i++) {
     //     createFavItem(keys[i].id);
     // }
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
	 topPadding = 20,
	 $content = $("#content");

     $window.scroll(function(){
	 var wscroll = $window.scrollTop();
	 if(!wscroll){
	     $sidebar.css("top", topPadding + 'px');
	 }else if(wscroll){
	     //     console.log($sidebar.height(), $(".sidebar-toggler").offset());
	     //console.log(wscroll, $sidebar.height(), $window.height());
	     if(wscroll < $sidebar.height() - $window.height() + 150)
		 $sidebar.css("top", (wscroll * -1) + 'px');
	     else
		 $sidebar.css("bottom", '0px');
	     //    $sidebar.stop().animate({
	     // marginTop: $window.scrollTop() - offset.top + topPadding
	     //   });
	 }
     });
 })();

 $(document).click(function(e){
     $('.iconbarsubmenu').css("display", "none");
     submenuToggled = false;
 });

 //old side menu like in default interface implementation
 var submenuToggled;
 $('.dropdown-submenu a.mysubmenu').on("mouseover", function(e){
     if (submenuToggled) {
	 $(submenuToggled).next('ul').toggle();
     }
     submenuToggled = this;
     $(this).next('ul').toggle();
     e.stopPropagation();
     e.preventDefault();
 });
 $('.dropdown-submenu a.mysubmenu').on("mouseout", function(e){
     if (submenuToggled) {
	 $(submenuToggled).next('ul').toggle();
     }
     submenuToggled = this;
     $(this).next('ul').toggle();
     e.stopPropagation();
     e.preventDefault();
 });

 var sidebarItems = $(".collapse-sidebar-item");
 var twoLevelItems = $(".collapse-sidebar-two-level-item");
 var threeLevelItems = $(".collapse-sidebar-three-level-item");
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
 twoLevelItems.on('hidden.bs.collapse', onhidden);
 threeLevelItems.on('hidden.bs.collapse', onhidden);
 sidebarItems.on('show.bs.collapse', function(e){
     sideBarCloseAll();
     $(e.currentTarget).css('display', 'block');
     var $sidebar   = $("#sidebar"),
	 $content = $("#content");
     if($sidebar.height() > $content.height())
	 $content.css("height", $sidebar.height() + "px");
     e.stopPropagation();
 });
 sidebarItems.on("shown.bs.collapse", function(e){
     var $sidebar   = $("#sidebar"),
	 $content = $("#content");
     if($sidebar.height() > $content.height())
	 $content.css("height", ($sidebar.height() + 20) + "px");
 });

 twoLevelItems.on('show.bs.collapse', function(e){
     var parent = $(e.currentTarget).parent().parent().parent().parent();
     //     console.log(parent, parent.is('.in, .collapse'));
     //     if(!parent.is('.in, .collapse'))
     sideBarCloseTwoLevelAll();
     $(e.currentTarget).css('display', 'block');
     var $sidebar   = $("#sidebar"),
	 $content = $("#content");
     if($sidebar.height() > $content.height())
	 $content.css("height", $sidebar.height() + "px");
     e.stopPropagation();
 });
 twoLevelItems.on("shown.bs.collapse", function(e){
     var $sidebar   = $("#sidebar"),
	 $content = $("#content");
     if($sidebar.height() > $content.height())
	 $content.css("height", ($sidebar.height() + 20) + "px");
 });

 threeLevelItems.on('show.bs.collapse', function(e){
     sideBarCloseThreeLevelAll();
     $(e.currentTarget).css('display', 'block');
     var $sidebar   = $("#sidebar"),
	 $content = $("#content");
     if($sidebar.height() > $content.height())
	 $content.css("height", $sidebar.height() + "px");
     e.stopPropagation();
 });
 threeLevelItems.on("shown.bs.collapse", function(e){
     var $sidebar   = $("#sidebar"),
	 $content = $("#content");
     if($sidebar.height() > $content.height())
	 $content.css("height", ($sidebar.height() + 20) + "px");
 });


</script>
