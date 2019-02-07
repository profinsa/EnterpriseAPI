<div class="bs-glyphicons">
    <ul class="bs-glyphicons-list" style="margin-top: 9px">
        <?php
                                        $public_prefix = '';
            $iconbarCategories = [
                "Customer" => [
                    "label" => $translation->translateLabel('CUSTOMER'),
                    "link" => $linksMaker->makeGridLink("AccountsReceivable/Customers/ViewCustomers"),
                    "iconclass" => "user",
                    "topbar" => [
                        "Add Customer" => [
                            "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewCustomers/new/Main/new",
                            "label" => $translation->translateLabel('Add Customer')
                        ],
                        "Setup" => [
                            [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewCustomers/grid/Main/all",
                                "label" => $translation->translateLabel('View Customers'),
                                ],
                                [
                                "link" => $public_prefix . "/index#/grid/AccountsReceivable/Customers/ViewCustomerFinancials/grid/Main/all",
                                "label" => $translation->translateLabel('View Customer Financials'),
                                ],
                        ],
                        "Reports" => [
                            [
                                "link" => $public_prefix . "/index#/autoreports/RptListCustomerInformation?id=1202975512&title=Customer Information",
                                "label" => $translation->translateLabel("Information"),
                            ]
                        ]

                    ]
                ],
                "Vendor" => [
                    "label" => $translation->translateLabel('Vendor'),
                    "link" => $linksMaker->makeGridLink("AccountsPayable/Vendors/ViewVendors"),
                    "iconclass" => "user",
                    "topbar" => [
                        "Add Vehicle" => [
                            "link" => $public_prefix . "/index#/grid/Inventory/Vehicles/ViewVehicles/new/Main/new",
                            "label" => $translation->translateLabel('Add Vehicle')
                        ],
                        "Setup" => [
                            [
                            "link" => $public_prefix . "/index#/grid/Inventory/Vehicles/ViewVehicles/grid/Main/all",
                            "label" => $translation->translateLabel('View Vehicles'),
                            ],
                            [
                            "link" => $public_prefix . "/index#/grid/SystemSetup/ManufacturerSetup/ManufacturerSetup/grid/Main/all",
                            "label" => $translation->translateLabel('Vehicle Setup'),
                            ]                    
                        ],
                        "Reports" => [
                            [
                                "link" => $public_prefix . "/index#/autoreports/RptListVehiclesHeader?id=77896561&title=Vehicles",
                                "label" => $translation->translateLabel("Vehicles"),    
                            ]
                        ]

                    ]
                ],
                "Items" => [
                    "label" => $translation->translateLabel('Items'),
                    "link" => "index.php#/?page=dashboard",
                    "iconclass" => "list",
                    "topbar" => [
                        "Counter Sale" => [
                            "link" => $public_prefix . "/index#/grid/Inventory/PartsDepartment/PartsInvoice/new/Main/new",
                            "label" => $translation->translateLabel('Counter Sale')
                        ],
                        "Setup" => [
                            "node" => "Inventory",
                        ],
                        "Reports" => [
                            [
                                "link" => $public_prefix . "/index#/autoreports/RptListParts?id=1554973463&title=Parts",
                                "label" => $translation->translateLabel('Parts'),
                                ],
                        ],
                    ],
                ],
                "Sales" => [
                    "label" => $translation->translateLabel('SALES'),
                    "iconclass" => "list-alt",
                    "data" => [
                        [
                        "link" => $public_prefix . "/index#/grid/AccountsReceivable/OrderScreens/ViewQuotes/grid/Main/all",
                        "label" => $translation->translateLabel('View Quotes')
                        ],
                        [
                        "link" => $public_prefix . "/index#/grid/AccountsReceivable/OrderProcessing/ViewOrders/grid/Main/all",
                        "label" => $translation->translateLabel('View Orders')
                        ],
                        [
                        "link" => $public_prefix . "/index#/grid/AccountsReceivable/OrderProcessing/ViewInvoices/grid/Main/all",
                        "label" => $translation->translateLabel('View Invoices')
                        ]
                    ],
                    "topbar" => [
                        "Desking" => [
                            "label" => $translation->translateLabel('Desking'),
                            "link" => $public_prefix . "/index#/dashboard?screen=Desking",
                        ],
                        "Reports" => [
                            [
                            "link"=> $public_prefix . "/index#/autoreports/RptSalesCustomerSalesDetail?id=479496937&title=Customer Sales Detail",
                            "label"=> $translation->translateLabel("Sales Detail"),
                            ],

                            [
                            "link"=> $public_prefix . "/index#/autoreports/RptSalesCustomerSalesSummary?id=1834645779&title=Customer Sales Summary",
                            "label"=> $translation->translateLabel("Sales Summary"),
                            ],
                        ]
                    ],

                ],
                "Purchase" => [
                    "label" => $translation->translateLabel('PURCHASE'),
                    "link" => "index.php#/?page=dashboard",
                    "iconclass" => "calendar"
                ],
                "Accounting" => [
                    "label" => $translation->translateLabel('ACCOUNTING'),
                    "link" => "index.php#/?page=dashboard",
                    "iconclass" => "calendar"
                ],
                "Reports" => [
                    "label" => $translation->translateLabel('Reports'),
                    "link" => $linksMaker->makeGridItemNewPartial("Reports/Autoreport/GenericReportDetail") . "&category=Main&item=" . $user["CompanyID"] . '__' . $user["DivisionID"] . '__' . $user["DepartmentID"],
                    "iconclass" => "stats"
                ],
                "Favorits" => [
                    "label" => $translation->translateLabel('FAVORITES'),
                    "favorits" => true,
                    "iconclass" => "heart"
                ],
                "Setup" => [
                    "label" => $translation->translateLabel('Setup'),
                    // "link" => $public_prefix . "/index#/grid/SystemSetup/CompanySetup/CompanySetup/view/Main/" . $user["CompanyID"] . '__' . $user["DivisionID"] . '__' . $user["DepartmentID"],
                    "iconclass" => "cog",
                    "topbar" => [
                        "Add User" => [
                            "link" => $public_prefix . "/index#/grid/SystemSetup/SecuritySetup/SecuritySetup/new/Main/new",
                            "label" => $translation->translateLabel('Add User')
                        ],
                    ]
                ],
                "Help" => [
                    "label" => $translation->translateLabel('HELP'),
                    "link" => "https://stfbinc.helpdocs.com",
                    "target" => "_blank",
                    "iconclass" => "question-sign"                    
                ]
            ];

            foreach ($iconbarCategories as $key=>$item){
                if (!key_exists("favorits", $item)) {
                    echo '<li onmouseenter="onShowSubMenu(event);" onmouseleave="onHideSubMenu(event);" ><a onclick="'. (key_exists("link", $item) ? 'location.href=\'' . $item["link"].'\';' :' ') .     (key_exists("topbar", $item) ? 'fillByTypical(\''. $key . '\');'  : 'fillTopmenu();')  .'" style="cursor: pointer"  class="mysubmenu"><span aria-hidden="true" class="glyphicon glyphicon-' . $item["iconclass"] . '"></span><span class="glyphicon-class">' . $item["label"] . '</span></a>';
                    if (key_exists("data", $item)) {
                        echo "<ul onmouseenter=\"onShowSubMenu(event);\" onmouseleave=\"onHideSubMenu(event);\" class=\"iconbarsubmenu dropdown-menu\" style=\" left: 99px !important; margin-top: -50px !important; z-index: 9999\">";
                            foreach($item["data"] as $subitem) {
                                echo '<li style="height:60px"><a style="width: 100%; height: 100%; padding-top: 25px;padding-right: 5px; padding-left: 5px;" href="' . $subitem["link"] . '" class="nav-link">' . $subitem["label"] .'</a></li>';
                            }
                        echo '</ul>';
                    }
                    echo '</li>';
                } else {
                    echo '<li  onmouseenter="onShowSubMenu(event);" onmouseleave="onHideSubMenu(event);" ><a onclick="fillByFavorits();" style="cursor: pointer" class="mysubmenu"><span aria-hidden="true" class="glyphicon glyphicon-' . $item["iconclass"] . '"></span><span class="glyphicon-class">' . $item["label"] . '</span></a>';
                    foreach ($menuCategories as $key=>$item){
                        if ($item["type"] == "custom") {
                            echo "<ul onmouseenter=\"onShowSubMenu(event);\" onmouseleave=\"onHideSubMenu(event);\" id=\"" . $item["id"] . "\" class=\"iconbarsubmenu dropdown-menu\" style=\" left: 99px !important; margin-top: -50px !important; z-index: 9999\">";
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

function onShowSubMenu(e) {
    var menu = $(e.target).find('ul');
    $(menu[0]).css({display: 'block'});
    $(menu[0]).css({top: 'auto'});
}

function onHideSubMenu(e) {
    $('.iconbarsubmenu').css("display", "none");
    submenuToggled = false;
}

$(document).click(function(e){
    $('.iconbarsubmenu').css("display", "none");
    submenuToggled = false;
});

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

// function createFavItem(id) {
//     var shortcutsRaw = localStorage.getItem('shortcuts');
//     var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};

//     var hh = "" + "/index#/grid/" + id + "/grid/Main/all";

//     $('#custom-toolbar').append(
//         '<li style="float: left" id="' + id + '"class="top-bar-link"><a href="' + hh+ '" style="padding: 5px 7px !important">' + shortcuts[id].label + '</a></li>'
//     );
// }

// function clearCustomToolbar() {
//     // var parent = document.getElementById('custom-toolbar');
//     // while (parent.firstChild) {
//     //     parent.removeChild(parent.firstChild);
//     // }
// }
// function compare(a,b) {
//     if (a.order < b.order)
//         return -1;
//     if (a.order > b.order)
//         return 1;
//     return 0;
// }

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

</script>
