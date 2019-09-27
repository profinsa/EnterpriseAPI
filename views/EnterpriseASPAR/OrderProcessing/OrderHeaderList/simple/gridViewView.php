<?php
    /* 
       Name of Page: Simple Order like form view

       Method: this view for Simple Order like form in the edit mode

       Date created: 22/07/2019

       Use: this view used for view mode. Renders all ui interface including Detail actions but only in the edit mode

       Input parameters:
       $scope: common information object
       $data : model

       Output parameters:
       html

       Called from:
       Grid Controller

       Calls:
       model

       Last Modified: 07/08/2019
       Last Modified by: Zaharov Nikita
     */

    $GLOBALS["dialogChooserTypes"] = [];
    $GLOBALS["dialogChooserInputs"] = [];

    function renderInputSimple($translation, $ascope, $data, $category, $item, $key, $value){
        $translatedFieldName = $translation->translateLabel(key_exists($key, $data->editCategories[$category]) && key_exists("label", $data->editCategories[$category][$key]) ? $data->editCategories[$category][$key]["label"] : (key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key));
        $leftWidth = property_exists($data, "editCategoriesWidth") ? round(12 / 100 * $data->editCategoriesWidth["left"]) : 6;
        $rightWidth = property_exists($data, "editCategoriesWidth") ? round(12 / 100 * $data->editCategoriesWidth["right"]) : 6;
        $disabledEdit =  (key_exists("disabledEdit", $data->editCategories[$category][$key]) && $ascope["mode"] == "edit")  ||
                         (key_exists("disabledNew", $data->editCategories[$category][$key]) && $ascope["mode"] == "new") ||
                         (key_exists("editPermissions", $data->editCategories[$category][$key]) &&
                          $data->editCategories[$category][$key]["editPermissions"] == "admin" &&
                          !$security->isAdmin())
                       ? "disabled" : "";
        
        switch($data->editCategories[$category][$key]["inputType"]){
            case "text" :
                //renders text input with label
                echo "<input style=\"display:inline\" type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" onchange=\"fillSameInputs('" . $value . "', '" . $key . "', this);\" class=\"form-control $key\" value=\"";
                if(key_exists("formatFunction", $data->editCategories[$category][$key])){
                    $formatFunction = $data->editCategories[$category][$key]["formatFunction"];
                    echo $data->$formatFunction($item, "editCategories", $key, $value, false);
                }
                else
                    echo formatField($data->editCategories[$category][$key], $value);

                echo"\" " . ( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && ($ascope["mode"] == "edit" || $ascope["mode"] == "view"))  || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $ascope["mode"] == "new") ? "readonly" : "")
               .">";
                break;

            case "textarea" :
                //renders text input with label
                echo "<textarea id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control $key\" $disabledEdit>";
                if(key_exists("formatFunction", $data->editCategories[$category][$key])){
                    $formatFunction = $data->editCategories[$category][$key]["formatFunction"];
                    echo $data->$formatFunction($item, "editCategories", $key, $value, false);
                }
                else
                    echo formatField($data->editCategories[$category][$key], $value);

                echo"</textarea>";
                break;

            case "datetime" :
                //renders text input with label
                echo "<input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control fdatetime $key\" value=\"" . ($value == 'now' || $value == "0000-00-00 00:00:00" || $value == "CURRENT_TIMESTAMP"? date("m/d/y") : date("m/d/y", strtotime($value))) ."\" " .
                     ( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && ($ascope["mode"] == "edit" || $ascope["mode"] == "view"))  || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $ascope["mode"] == "new") ? "readonly" : "")
                    .">";
                break;

            case "checkbox" :
                //renders checkbox input with label
                echo "<input type=\"hidden\" name=\"" . $key . "\" value=\"0\"/>";
                echo "<input class=\"grid-checkbox\" type=\"checkbox\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control $key\" value=\"1\" " . ($value ? "checked" : "") ." " .
                     ( (key_exists("disabledEdit", $data->editCategories[$category][$key]) && ($ascope["mode"] == "edit" || $ascope["mode"] == "view")) || (key_exists("disabledNew", $data->editCategories[$category][$key]) && $ascope["mode"] == "new") ? "disabled" : "")
                    .">";
                break;

            case "dialogChooser":
                $dataProvider = $data->editCategories[$category][$key]["dataProvider"];
                //$GLOBALS["dialogChooserTypes"][$key] = $data->editCategories[$category][$key];
                //$GLOBALS["dialogChooserTypes"][$key]["fieldName"] = $key;
                if(!key_exists($dataProvider, $GLOBALS["dialogChooserTypes"])){
                    $GLOBALS["dialogChooserTypes"][$dataProvider] = $data->editCategories[$category][$key];
                    $GLOBALS["dialogChooserTypes"][$dataProvider]["fieldName"] = $key;
                }
                $GLOBALS["dialogChooserInputs"][$key] = $dataProvider;
                $onchange = "";
                if(key_exists("onchange", $data->editCategories[$category][$key]))
                    $onchange = "onchange=\"{$data->editCategories[$category][$key]["onchange"]}()\"";
                echo "<input type=\"text\" id=\"". $key ."\" name=\"" .  $key. "\" class=\"form-control $key\" value=\"$value\" $onchange>";
                break;

            case "dropdown" :
                //renders select with available values as dropdowns with label
                echo "<select class=\"form-control $key\" name=\"" . $key . "\" id=\"" . $key . "\">";
                $method = $data->editCategories[$category][$key]["dataProvider"];
                if(key_exists("dataProviderArgs", $data->editCategories[$category][$key])){
                    $args = [];
                    foreach($data->editCategories[$category][$key]["dataProviderArgs"] as $argname)
                    $args[$argname] = $item[$argname];
                    $types = $data->$method($args);
                }
                else
                    $types = $data->$method();
                if($value)
                    echo "<option value=\"" . $value . "\">" . (key_exists($value, $types) ? $types[$value]["title"] : $value) . "</option>";
                else
                    echo "<option></option>";

                foreach($types as $type)
                if(!$value || $type["value"] != $value)
                    echo "<option value=\"" . $type["value"] . "\">" . $type["title"] . "</option>";
                echo"</select>";
                break;
        }
    }

    function renderRow($translation, $data, $fieldsDefinition, $values, $key, $value){
        echo "<tr style=\"padding: 5px\"><td style=\"padding: 5px\">" . $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key) . ":</td><td style=\"word-wrap: break-word; padding: 5px\">";
        echo formatValue($data, $fieldsDefinition, $values, $key, $value);
        echo "</td></tr>";
    }

    function renderEditRow($translation, $ascope, $data, $category, $item, $key, $value){
        echo "<tr style=\"padding: 5px\"><td style=\"padding: 5px\">" . $translation->translateLabel(key_exists($key, $data->columnNames) ? $data->columnNames[$key] : $key) . ":</td><td style=\"word-wrap: break-word; padding: 5px\">";
        renderInputSimple($translation, $ascope, $data, $category, $item, $key, $value);
        echo "</td></tr>";
    }

    function getMemo($tableItems) {
        $ret = '';

        foreach($tableItems["leftItems"] as $key =>$value)
        $ret .= $value;
        foreach($tableItems["rightItems"] as $key =>$value)
        $ret .= $value;

        $ret = str_replace("\t", '', $ret); // remove tabs
        $ret = str_replace("\n", '', $ret); // remove new lines
        $ret = str_replace("\r", '', $ret); // remove carriage returns
        
        return $ret;
    }

    function makeTableItems($values, $fieldsDefinition){
        $leftItems = [];
        $rightItems = [];
        
        $itemsHalf = 0;
        $itemsCount = 0;
        foreach($values as $key =>$value){
            if(key_exists($key, $fieldsDefinition))
                $itemsCount++;
        }
        $itemsHalf = $itemsCount/2;

        $itemsCount = 0;
        foreach($values as $key =>$value){
            if(key_exists($key, $fieldsDefinition)){
                if($itemsCount < $itemsHalf)
                    $leftItems[$key] = $value;
                else 
                    $rightItems[$key] = $value;
                $itemsCount++;
            }
        }
        return [
            "leftItems" => $leftItems,
            "rightItems" => $rightItems
        ];
    }

    $currencySymbol = $data->getCurrencySymbol();
?>

<div class="simple-form row">
    <div id="row_viewer"  style="font-size: 11pt">
        <form id="itemData" class="form-material form-horizontal m-t-30 col-md-12 col-xs-12">
            <input type="hidden" name="id" value="<?php echo $ascope["item"]; ?>" />
            <input type="hidden" name="category" value="<?php echo $ascope["category"]; ?>" />

            <?php
                $headerItem = $ascope["mode"] == 'edit' || $ascope["mode"] == 'view'? $data->getEditItem($ascope["item"], "...fields") :
                              $data->getNewItem($ascope["item"], "...fields" );
                $whom = key_exists("whom", $data->simpleInterface) ? $data->simpleInterface["whom"] : "Customer";
            ?>
            
            <!-- horizontal top blue line with 2 inputs -->
            <div class="row top_params">
                <div class="col-md-6 col-xs-12">
                    <div class="row">
                        <label class="pull-left" for="<?php echo $whom; ?>ID"><?php echo $whom; ?></label>
                        <!-- <span class="custom-select col-md-7"> -->
                        <span class="col-md-7">
                            <?php renderInputSimple($translation, $ascope, $data, "...fields", $headerItem, $whom . "ID", $headerItem[$whom . "ID"]); ?>
                        </span>
                    </div>
                </div>
                <!-- <div class="col-md-6 col-xs-12">
                     <div class="row">
                     <label class="pull-left" for="template">Template</label>
                     <span class="custom-select col-md-5">
                     <input type="text" id="template" class="custom-select" value="" />
                     </span>
                     </div>
                     </div> -->
            </div>
            
            <script>
             //catching CustomerID/VendorID changing
             /*var whomCatcher = $("#<?php echo $whom ?>ID").change(function(){
                var chooserData = dialogChooserData[dialogChooserInputs["<?php echo $whom; ?>ID"]].allValues, ind;
                for(ind in chooserData)
                if(chooserData[ind].<?php echo $whom ?>ID == whomCatcher.val()){
                chooserData = chooserData[ind];
                break;
                };
                
                var whomFields = ["Name","Address1", "Address2", "Address3", "City", "State", "Zip", "Country"], input;
                for(ind in whomFields){
                if((input = $("#Shipping" + whomFields[ind])).length)
                $(input).val(chooserData["<?php echo $whom?>" + whomFields[ind]]);
                }
                });*/
            </script>
            
            <div class="row" style="margin-top:20px">
                <div class="style-5 col-md-2 about-order">
                    <?php foreach($data->simpleInterface["aboutOrder"] as $key=>$value): ?>
                        <label for="<?php echo $translation->translateLabel($key); ?>">
                            <?php echo $translation->translateLabel($key); ?>
                        </label>
                        <!--   <span readonly class="form-control" id="<?php echo $translation->translateLabel($key); ?>">
                             <span class="form-control" id="<?php echo $translation->translateLabel($key); ?>">
                             </span>
                        -->
                        <?php renderInputSimple($translation, $ascope, $data, "...fields", $headerItem, $value, $headerItem[$value]); ?>
                    <?php endforeach; ?>
                </div>
                <div class="col-md-4">
                    <div class="row">
                        <label class="header col-md-12 col-xs-12">
                            <?php echo $data->simpleInterface["customerTitle"]; ?>
                        </label>
                    </div>
                    <div class="style-5">
                        <div>
                            <table class="noinputborders">
                                <tbody>
                                    <?php
                                        $item = $ascope["mode"] == 'edit' || $ascope["mode"] == 'view'? $data->getEditItem($ascope["item"], $whom) :
                                                $data->getNewItem($ascope["item"], $whom);
                                        $customerInfo = $whom == "Customer" ?
                                                        $data->getCustomerInfo($headerItem[property_exists($data, "customerField") ? $data->customerField : $whom . "ID"]):
                                                        $data->getVendorInfo($headerItem[property_exists($data, "customerField") ? $data->customerField : $whom . "ID"]);
                                        $tableItems = makeTableItems($customerInfo, $data->simpleInterface["customerFields"]);
                                        $tableCategories = $whom == "Customer" ? $data->customerFields : $data->vendorFields;
                                        $items = $customerInfo;
                                    ?>
                                    <?php
                                        if(key_exists("shippingFields", $data->simpleInterface))
                                            foreach($tableItems["leftItems"] as $key =>$value)
                                        renderEditRow($translation, $ascope, $data, "Main", $items, $data->simpleInterface["shippingFields"][$key], $value);
                                        //    renderRow($translation, $data, $tableCategories, $items, $key, $value);
                                    ?>
                                    <?php 
                                        if(key_exists("shippingFields", $data->simpleInterface))
                                            foreach($tableItems["rightItems"] as $key =>$value)
                                        renderEditRow($translation, $ascope, $data, "Main", $items, $data->simpleInterface["shippingFields"][$key], $value);
                                    ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <?php if(key_exists("showShipping", $data->simpleInterface) && $data->simpleInterface["showShipping"]): ?>
                    <div class="col-md-3">
                        <div class="row">
                            <span style="margin-top: 0 !important;margin-bottom: 3px" class="header col-md-12 col-xs-12">Ship to</h3></span>
                        </div>
                        <div class="style-5" style="padding: 5px;">
                            <div>
                                <table class="noinputborders">
                                    <tbody>
                                        <?php
                                            $item = $ascope["mode"] == 'edit' || $ascope["mode"] == 'view'? $data->getEditItem($ascope["item"], "Shipping") : $data->getNewItem($ascope["item"], "Shipping" );
                                            $tableCategories = $data->editCategories["Shipping"];
                                            $tableItems = makeTableItems($item, $tableCategories);
                                            $items = $item;
                                        ?>
                                        <?php 
                                            foreach($tableItems["leftItems"] as $key =>$value)
                                            renderEditRow($translation, $ascope, $data, "Shipping", $items, $key, $value);
                                            //        renderRow($translation, $data, $tableCategories, $items, $key, $value);
                                        ?>
                                        <?php 
                                            foreach($tableItems["rightItems"] as $key =>$value)
                                            renderEditRow($translation, $ascope, $data, "Shipping", $items, $key, $value);
                                        ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                <?php endif; ?>
            </div>
            <div class="row">
                <?php foreach($data->simpleInterface["aboutPurchase"] as $key=>$value): ?>
                    <div class="style-5 col-md-2">
                        <label for="<?php echo $translation->translateLabel($key); ?>">
                            <?php echo $translation->translateLabel($key); ?>
                        </label>
                        <?php renderInputSimple($translation, $ascope, $data, "...fields", $headerItem, $value, $headerItem[$value]); ?>
                        <!--   <span readonly class="form-control" id="<?php echo $translation->translateLabel($key); ?>">
                             <?php echo formatValue($data, $data->editCategories['...fields'], $headerItem, $value, $headerItem[$value]); ?>&nbsp
                             </span> -->
                    </div>
                <?php endforeach; ?>
            </div>
            
            <!-- Detail table 
                 <div class="row">
                 <?php
                     //             if(property_exists($data, "detailTable"))
                     //                   require __DIR__ . "/../components/detailGrid.php";
                     ?>
                 </div>-->
            <!-- Detail table -->

            <?php if(property_exists($data, "detailTable")): ?>
                <div class="row">
                    <div id="subgrid" class="col-md-12 col-xs-12">
                    </div>

                    <script>
                     <?php if($ascope["mode"] == "new"): ?>
                     function newSubgridItemHook(){
                         return createItem(function(data){
                             var idFields = <?php echo json_encode($data->idFields); ?>, ind, keyString = "";
                             for(ind in idFields){
                                 if(keyString == "")
                                     keyString = data[idFields[ind]];
                                 else
                                     keyString += "__" + data[idFields[ind]];
                             }
                             var hash = "#/?page=grid&action=<?php echo $ascope["action"]; ?>&mode=edit&category=Main&item=" + encodeURIComponent(keyString);

                             var location = window.location.toString();
                             location = location.match(/(.*index.php)/)[1];
                             onlocationSkipUrls[location + hash] = true;
                             window.location.hash = hash;

                             setRecalc(data["<?php echo $data->idFields[3]; ?>"]);
                             subgridView("new", keyString);
                             newSubgridItemHook = false; 
                         });
                     }
                     <?php else: ?>
                     newSubgridItemHook = false;
                     <?php endif; ?>
                     function subgridView(subgridmode, keyString){
                         var detailRewrite = {
                             "ViewQuotes" : "ViewQuotesDetail",
                             "ViewOrdersSimple" : "ViewOrdersDetail",
                             "ViewOrders" : "ViewOrdersDetail",
                             "ViewInvoicesSimple" : "ViewInvoicesDetail",
                             "ViewInvoices" : "ViewInvoicesDetail",
                             "ViewServiceQuotes" : "ViewServiceQuotesDetail",
                             "ViewServiceOrders" : "ViewServiceOrdersDetail",
                             "ViewServiceInvoices" : "ViewServiceInvoicesDetail",
                             "ViewPurchasesSimple" : "ViewPurchasesDetail",
                             "MemorizedGLTransactions" : "LedgerTransactionsDetail",
                             "ViewGLTransactions" : "LedgerTransactionsDetail",
                             "ViewClosedGLTransactions" : "LedgerTransactionsDetail",
                             "ReceivePurchases" : "ReceivePurchasesDetail",
                             "BankDeposits" : "LedgerTransactionsDetail"
                         }, ind;
                         var path = new String(window.location);
                         path = path.replace(/#\/\?/, "?");
                         path = path.replace(/page\=grid/, "page=subgrid");
                         path = path.replace(/mode\=view|mode\=edit|mode\=new/, "mode=subgrid");
                         if(keyString){
                             path = path.replace(/mode\=subgrid/, "mode=new");
                             if(path.search(/item\=/) == -1)
                                 path += "&item=" + keyString;
                         }

                         var prevPath;
                         for(ind in detailRewrite){
                             prevPath = path;
                             path = path.replace(new RegExp(ind), detailRewrite[ind]);
                             if(path != prevPath)
                                 break;
                         }
                         $.get(path + "<?php echo (property_exists($data, "detailSubgridModes") && key_exists("edit", $data->detailSubgridModes) ? "&modes=" . implode("__", $data->detailSubgridModes["edit"]) : ""); ?>")
                          .done(function(data){
                              setTimeout(function(){
                                  $("#subgrid").html(data);
                                  datatableInitialized = true;
                                  setTimeout(function(){
                                      var buttons = $('.subgrid-buttons');
                                      var tableFooter = $('.subgrid-table-footer');
                                      tableFooter.prepend(buttons);
                                  },300);
                              },0);
                          })
                          .error(function(xhr){
                              // if(xhr.status == 401)
                              //    else
                              //   alert("Unable to load page");
                          });
                     }
                     subgridView();
                     /*function subgridView(cb){
                        var detailRewrite = {
                        "ViewQuotes$" : "ViewQuotesDetail",
                        "ViewOrders$" : "ViewOrdersDetail",
                        "ViewInvoices$" : "ViewInvoicesDetail",
                        "ViewServiceQuotes$" : "ViewServiceQuotesDetail",
                        "ViewServiceOrders$" : "ViewServiceOrdersDetail",
                        "ViewServiceInvoices$" : "ViewServiceInvoicesDetail"
                        }, ind;
                        var path = new String(window.location);
                        path = path.replace(/index\#\//, "");
                        path = path.replace(/\/grid|\/view|\/edit|\/new/g, "\/subgrid");
                        for(ind in detailRewrite)
                        path = path.replace(new RegExp(ind), detailRewrite[ind]);
                        console.log(path);
                        $.get(path)
                        .done(function(data){
                        setTimeout(function(){
                        $("#subgrid").html(data);
                        datatableInitialized = true;
                        //      var table = $('#example23').DataTable( {
                        //         dom : "<'subgrid-table-header row'<'col-sm-6'l><'col-sm-6'f>><'subgrid-table-content row't><'subgrid-table-footer row'<'col-sm-4'i><'col-sm-7'p>>"
                        //          dom : "<'subgrid-table-header row'><'subgrid-table-content row't><'subgrid-table-footer row'<'col-sm-4'i>>"
                        //      });
                        setTimeout(function(){
                        var buttons = $('.subgrid-buttons');
                        var tableFooter = $('.subgrid-table-footer');
                        tableFooter.prepend(buttons);
                        },300);
                        //     if(cb)
                        //         cb();
                        },0);
                        })
                        .error(function(xhr){
                        // if(xhr.status == 401)
                        //   window.location = "index.php?page=login";
                        //    else
                        //   alert("Unable to load page");
                        });
                        }
                        subgridView(function(){
                        //window.scrollTo(0,0);
                        });*/
                    </script>
                </div>
            <?php endif; ?>

            <!-- footer -->
            <div class="row" style="margin-top: 40px">
                <!-- get this test select block from Quickbook "Estimate" page -->
                <div class="col-md-3 col-xs-12 pull-left to-bottom">
                    <label for="customer_message">Customer message</label>
                    <select id="customer_message" class="form-control">
                        <option value="1">All work is complete!</option>
                        <option value="2">It's been pleasure working with you!</option>
                        <option value="3">Please remit to above address.</option>
                        <option value="4">Thank you for your business.</option>
                        <option value="4">We appreciate your prompt payment</option>
                    </select>
                </div>
                <!-- end -->
                <div class="col-md-4 col-xs-12 col-md-offset-8 grid-items">
                    <?php foreach($data->simpleInterface["totalFields"] as $key=>$value): ?>
                        <div class="row">
                            <label class="col-md-4"><?php echo $translation->translateLabel($key); ?>:</label>
                            <div class="col-md-8 text-right"><?php echo $currencySymbol["symbol"]; ?><?php echo formatValue($data, $data->editCategories['...fields'], $headerItem, $value, $headerItem[$value]); ?></div>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php
                if(file_exists(__DIR__ . "/../../../../" . $PartsPath . "viewFooter.php"))
                    require __DIR__ . "/../../../../" . $PartsPath . "viewFooter.php";
                if(file_exists(__DIR__ . "/../../../../" . $PartsPath . "vieweditFooter.php"))
                    require __DIR__ . "/../../../../" . $PartsPath . "vieweditFooter.php";
            ?>

            <div class="row" style="margin-top: 20px;">
                <div class="col-md-3 col-xs-12 pull-left">
                    <?php
                        $item = $ascope["mode"] == 'edit' || $ascope["mode"] == 'view'? $data->getEditItem($ascope["item"], "Memos") :
                                $data->getNewItem($ascope["item"], "Memos");
                        $tableCategories = $data->editCategories["Memos"];
                        $tableItems = makeTableItems($item, $tableCategories);
                        $items = $item;
                    ?>
                    <div class="form-inline" style="width: 100%">
                        <div class="form-group"  style="width: 100%">
                            <label class="col-md-2 pull-left" for="memo">
                                <?php echo $translation->translateLabel("Memo"); ?>
                            </label>
                            <div class="col-md-10 style-5" style="padding-right: 0;">
                                <?php renderInputSimple($translation, $ascope, $data, "...fields", $headerItem, "HeaderMemo1", $headerItem["HeaderMemo1"]); ?>
                                <!--<span class="form-control" id="memo" style="width: 100%; white-space: nowrap; overflow: hidden;">
                                     <?php echo $tableItems["leftItems"]["HeaderMemo1"]; ?>
                                     </span> -->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-9 col-xs-12 text-right">
                    <!--
                         buttons Edit and Cancel
                         for translation uses translation model
                         for category(which tab is activated) uses $ascope of controller
                    -->
                    <?php if($security->can("update")): ?>
                        <?php if(key_exists("reportType", $data)): ?>
                            <?php $currentCompany = $data->getCurrentCompany()[0]; ?>
                            <!-- <a href="<?php /*echo "/docreports/" . $data->reportType . "/" . explode("__", $ascope["item"])[3]*/ ?>" target="_blank" class="btn btn-info" onclick="<?php /*echo ($ascope["mode"] == "view" ? "saveItem()" : "createItem()"); echo $currentCompany->AccountingCopy == 1 ? ";window.open('" .  /*$public_prefix ."/docreports/" . $data->reportType . "accountingcopy/" . explode("__", $ascope["item"])[3] . "')" : "";*/  /*echo $currentCompany->FileCopy == 1 ? ";window.open('" . $public_prefix ."/docreports/" . $data->reportType . "filecopy/" . explode("__", $ascope["item"])[3] . "')" :*/ "";?>">
                                 <?php echo $translation->translateLabel("Save & Print"); ?>
                                 </a> -->
                        <?php endif; ?>
                        <a class="btn btn-info" onclick="<?php echo ($ascope["mode"] != "new" ? "saveItem()" : "createItem()"); ?>">
                            <?php echo $translation->translateLabel("Save"); ?>
                        </a>
                        <?php if(property_exists($data, "docType")): ?>
                            <?php if($ascope["mode"] != "new"): ?>
                                <a class="btn btn-info <?php echo !$headerItem["Posted"] ? "disabled" : "";?>" href="javascript:;" onclick="saveItemAndPrint()">
                                    <?php
                                        echo $translation->translateLabel("Save & Print");
                                    ?>
                                </a>
                            <?php endif; ?>
                            <a class="btn btn-info <?php echo !$headerItem["Posted"] ? "disabled" : "";?>" href="javascript:;" onclick="callDetailPrint(context.item)">
                                <?php
                                    echo $translation->translateLabel("Print");
                                ?>
                            </a>

                            <a class="btn btn-info <?php echo !$headerItem["Posted"] ? "disabled" : "";?>" href="javascript:;" onclick="callDetailEmail(context.item)">
                                <?php
                                    echo $translation->translateLabel("Email");
                                ?>
                            </a>
                        <?php endif; ?>
                        <?php
                            if(file_exists(__DIR__ . "/../../../../" . $PartsPath . "viewActions.php"))
                                require __DIR__ . "/../../../../" . $PartsPath . "viewActions.php";
                            if(file_exists(__DIR__ . "/../../../../" . $PartsPath . "vieweditActions.php"))
                                require __DIR__ . "/../../../../" . $PartsPath . "vieweditActions.php";
                        ?>
                    <?php endif; ?>
                    <a class="btn btn-info" href="<?php echo $linksMaker->makeGridItemViewCancel($ascope["path"]); ?>">
                        <?php echo $translation->translateLabel("Exit"); ?>
                    </a>
                </div>
            </div>
        </form>
    </div>
    <!-- 
         <div class="right_bar">
         <div class="toggle" onclick="toggleRightBar();"></div>
         <div class="right_bar_wrap">
         <ul class="nav nav-tabs">
         <li class="active"><a href="#tab_name" data-toggle="tab">Name</a></li>
         <li><a href="#tab_transactions" data-toggle="tab">Transactions</a></li>
         </ul>
         <div class="tab-content">
         <div class="tab-pane fade in active" id="tab_name">
         <div class="tab-group">
         <div class="tab-group-title">Summary</div>
         <div class="tab-group-text"></div>
         </div>
         <div class="tab-group">
         <div class="tab-group-title">Resent Transactions</div>
         <div class="tab-group-text"></div>
         </div>
         <div class="tab-group">
         <div class="tab-group-title">Notes</div>
         <div class="tab-group-text"></div>
         </div>
         </div>
         <div class="tab-pane fade" id="tab_transactions">
         <div class="tab-group">
         <div class="tab-group-title">Summary</div>
         <div class="tab-group-text"></div>
         </div>
         <div class="tab-group">
         <div class="tab-group-title">Related Transaction</div>
         <div class="tab-group-text"></div>
         </div>
         <div class="tab-group">
         <div class="tab-group-title">Notes</div>
         <div class="tab-group-text"></div>
         </div>
         </div>
         </div>
         </div>
         </div> -->
</div>

<script>
 function fillSameInputs(value, key, event) {
     var elements = $('input[name=' + key + ']');
     var elementsKeys = Object.keys(elements);


     for (var k = 0; k < elementsKeys.length; k++) {
         $(elements[elementsKeys[k]]).val(event.value);
     }
 }

 function validateForm(itemData) {
     var itemDataArray = itemData.serializeArray();

     var categories = <?php echo json_encode($data->editCategories); ?>;
     var categoriesKeys = Object.keys(categories);
     var columnNames = <?php echo json_encode($data->columnNames); ?>;
     var validationError = false;
     var validationErrorMessage = '';
     var isAlert = false;

     function getDbObject(key) {
         for (var i = 0; i < categoriesKeys.length; i++) {
             if (categories[categoriesKeys[i]].hasOwnProperty(key)) {
                 return categories[categoriesKeys[i]][key];
             }
         }

         return null;
     }

     function isNumeric(value) {
         var re = /^-{0,1}\d*\.{0,1}\d+$/;
         return (re.test(value));
     }

     function isDecimal(value) {
         var re = /^-{0,1}\d*\.{0,1}\d+$/;
         return (re.test(value.replace(/,/g,'')));
     }

     for (var i = 0; i < itemDataArray.length; i++) {
         if ((itemDataArray[i].name !== 'category') && (itemDataArray[i].name !== 'id')) {
             var dataObject = getDbObject(itemDataArray[i].name);

             if (dataObject) {
                 var dataType = dataObject.dbType.replace(/\(.*/,'');
                 var dataLength;
                 var re = /\((.*)\)/;
                 
                 if (dataType !== 'datatime' && dataType !== 'timestamp') {
                     if (dataObject.required && !itemDataArray[i].value) {
                         validationError = true;
                         validationErrorMessage = 'cannot be empty.';
                         $('#' + itemDataArray[i].name).css('border', '1px solid red');
                     } else {
                         $('#' + itemDataArray[i].name).css('border', 'none');
                         switch (dataType) {
                             case 'decimal':
                                 if (itemDataArray[i].value && !isDecimal(itemDataArray[i].value)) {
                                     var elements = $('input[name=' + itemDataArray[i].name + ']');
                                     var elementsKeys = Object.keys(elements);


                                     for (var k = 0; k < elementsKeys.length; k++) {
                                         $(elements[elementsKeys[k]]).css('border', '1px solid red');
                                     }
                                     validationError = true;
                                     validationErrorMessage = 'must contain a number.';
                                 }
                                 break;
                             case 'smallint':
                             case 'bigint':
                             case 'int':
                             case 'float':
                                 if (itemDataArray[i].value && !isNumeric(itemDataArray[i].value)) {
                                     var elements = $('input[name=' + itemDataArray[i].name + ']');
                                     var elementsKeys = Object.keys(elements);


                                     for (var k = 0; k < elementsKeys.length; k++) {
                                         $(elements[elementsKeys[k]]).css('border', '1px solid red');
                                     }
                                     validationError = true;
                                     validationErrorMessage = 'must contain a number.';
                                 }
                                 break;
                             case 'char':
                                 if (itemDataArray[i].value.length > 1) {
                                     var elements = $('input[name=' + itemDataArray[i].name + ']');
                                     var elementsKeys = Object.keys(elements);


                                     for (var k = 0; k < elementsKeys.length; k++) {
                                         $(elements[elementsKeys[k]]).css('border', '1px solid red');
                                     }
                                     validationError = true;
                                     validationErrorMessage = 'cannot contain more than 1 character.';
                                 }
                                 break;
                             case 'varchar':
                                 dataLength = dataObject.dbType.match(re)[1];

                                 if (itemDataArray[i].value.length > dataLength) {
                                     var elements = $('input[name=' + itemDataArray[i].name + ']');
                                     var elementsKeys = Object.keys(elements);


                                     for (var k = 0; k < elementsKeys.length; k++) {
                                         $(elements[elementsKeys[k]]).css('border', '1px solid red');
                                     }
                                     validationError = true;
                                     validationErrorMessage = 'cannot contain more than ' + dataLength + ' character(s).';
                                 }
                                 break;
                             default:
                                 break;
                         }
                     }
                 }

                 if (validationError && !isAlert) {
                     translatedFieldName = columnNames.hasOwnProperty(itemDataArray[i].name) ? columnNames[itemDataArray[i].name] : itemDataArray[i].name;
                     isAlert = true;
                     alert(translatedFieldName + ' field ' + validationErrorMessage);
                 }
             } else {
                 //todo error handling
             }
         }
     }

     return !validationError;
 }
 
 //handler of save button if we in new mode. Just doing XHR request to save data
 function createItem(cb){
     var itemData = $("#itemData");

     if (validateForm(itemData)) {
         $.post("<?php echo $linksMaker->makeGridItemNew($ascope["path"]); ?>", itemData.serialize(), null, 'json')
          .success(function(data) {
              //       console.log('ok');
              if(cb)
                  cb(data);
              else
                  window.location = "<?php echo $linksMaker->makeGridItemViewCancel($ascope["path"]); ?>";
          })
          .error(function(err){
              if (err) {
                  if (err.status == 200) {
                      window.location = "<?php echo $linksMaker->makeGridItemViewCancel($ascope["path"]); ?>";
                  };
              }

              //   console.log(err);
          });
         return false;
     }
     return true;
 }
 //handler of save button if we in edit mode. Just doing XHR request to save data
 function saveItem(cb){
     var itemData = $("#itemData");
     if (validateForm(itemData)) {
         $.post("<?php echo $linksMaker->makeGridItemSave($ascope["path"]); ?>", itemData.serialize(), null, 'json')
          .success(function(data) {
              //   console.log("<?php echo $linksMaker->makeGridLink($ascope["path"]); ?>");
              serverProcedureAnyCall('<?php echo $ascope["path"]; ?>', 'Post', {
                  <?php echo $data->idField; ?> : '<?php echo $headerItem[$data->idField]; ?>'
              }, function(){
                  callRecalc('<?php echo $headerItem[$data->idField]; ?>');
                  if(cb)
                      cb();
                  else
                      window.location = "<?php echo $linksMaker->makeGridLink($ascope["path"]); ?>";
              });
          })
          .error(function(err){
              console.log(err);
          });
     }
 }

 function saveItemAndPrint(){
     saveItem(function(){
         callDetailPrint(context.item, function(){
             window.location = "<?php echo $linksMaker->makeGridLink($ascope["path"]); ?>";
         });
     });
 }

 //handler delete button from rows. Just doing XHR request to delete item and redirect to grid if success
 function orderDetailDelete(item){
     if(confirm("Are you sure?")){
         $.post("<?php echo $linksMaker->makeEmbeddedgridItemDeleteLink($ascope["path"], "detailDelete", $ascope["item"]);?>" + item, {})
          .success(function(data) {
              $.post(localStorage.getItem("autorecalcLink"), JSON.parse(localStorage.getItem("autorecalcData")))
               .success(function(data) {
                   onlocation(window.location);
               })
               .error(function(err){
                   onlocation(window.location);
               });
          })
          .error(function(err){
              console.log('wrong');
          });
     }
 }
 
 function toggleRightBar() {
     $('body').toggleClass('right_minimized');
 }
</script>

<?php require __DIR__ . "/../../../../dialogChooser.php"; ?>
