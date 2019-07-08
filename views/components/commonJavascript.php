<script>
 function redirectBlank(url) {
     var a = document.createElement('a');
     a.target="_blank";
     a.href=url;
     a.click();

 }
 function downloadFile(filename, text) {
     var element = document.createElement('a');
     element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(text));
     element.setAttribute('download', filename);

     element.style.display = 'none';
     document.body.appendChild(element);

     element.click();

     document.body.removeChild(element);
 }

 function getFormData($form){
     var unindexed_array = $form.serializeArray();
     var indexed_array = {};

     $.map(unindexed_array, function(n, i){
         indexed_array[n['name']] = n['value'];
     });

     return indexed_array;
 }

 function generateKeyString(props){
     <?php if(isset($ascope)): ?>
     var key, keyString = "<?php echo $ascope["user"]["CompanyID"] . "__" . $ascope["user"]["DivisionID"] . "__" . $ascope["user"]["DepartmentID"] . "__"; ?>";
     for(key in props)
         keyString += props[key];
     return keyString;
     <?php endif; ?>
 }

 //global object used for creatink links to any part of application
 var linksMaker = {
     makeDashboardLink : function(type){
         return "index.php#/?page=dashboard" + (type ? "&screen=" + type : "");
     },
     makeGridLink : function (path){
         return "index.php#/?page=grid&action=" + path + "&mode=grid&category=Main&item=all";
     },
     makeGridItemView : function(path, item, category){
         return "index.php#/?page=grid&action=" + path + "&mode=view&category=" + (category ? category : "Main") + "&item=" + item;
     },
     makeEmbeddedgridItemNewLink : function(viewpath, backpath, keyString, item){
         return "index.php#/?page=grid&action=" + viewpath + "&mode=new&category=Main&item=" + keyString + "&back=" + encodeURIComponent("index.php#/?page=grid&action=" + backpath + "&mode=view&category=Main&item=" + item);
     },
     makeEmbeddedgridItemEditLink : function(viewpath, backpath, keyString, item){
         return "index.php#/?page=grid&action=" + viewpath + "&mode=edit&category=Main&item=" + keyString + "&back=" + encodeURIComponent("index.php#/?page=grid&action=" + backpath + "&mode=view&category=Main&item=" + item);
     },
     makeProcedureLink : function (path, procedure){
         return "index.php?page=grid&action=" + path + "&procedure=" + procedure;
     },
     makeAutoreportsViewLink : function(type, name, id, title, options){
         return "index.php?page=autoreports&getreport=" + name + "&type=" + type + "&title=" + title + "&" + options;
     },
     makeDocreportsLink : function(type, id){
         return "index.php?page=docreports&type=" + type + "&id=" + id;
     },
     makeReportsEngineLink : function(report){
         return  "index.php#/?page=grid&action=Reports/Autoreport/GenericReportDetail&mode=new&category=Main&item=" + generateKeyString() + "&report=" + report;
     }
 };

 //setting up recalc for detail items to recalculation after changing and adding detail record to header record
 function setRecalc(id){
     var recalcLink = linksMaker.makeProcedureLink(context.path, "Recalc");
     //automatic recalc if we back from detail
     localStorage.setItem("recalclLink", recalcLink);
     localStorage.setItem("autorecalcLink", recalcLink);
     var autorecalcData = {};
     autorecalcData[context.data.idFields[3]] = id;
     localStorage.setItem("autorecalcData", JSON.stringify(autorecalcData));
 }

 //calling Recalc
 function callRecalc(id){
     var autorecalcData = {};
     autorecalcData[context.data.idFields[3]] = id;
     serverProcedureCall('Recalc', autorecalcData, true);
 }
 //calling procedure from server

 <?php if(isset($ascope) && key_exists("mode", $ascope)): ?>
 function serverProcedureCall(methodName, props, reloadPage, jsonRequest, successAlert){
     $.post("<?php echo $linksMaker->makeProcedureLink($ascope["path"], ""); ?>" + methodName, jsonRequest ? JSON.stringify(props) : props, 'text')
      .success(function(data) {
          if(successAlert)
              alert(data);
          if(reloadPage)
              onlocation(window.location);
      })
      .error(function(xhr){
          alert(xhr.responseText);
      });
 }
 <?php endif; ?>
 function serverProcedureAnyCall(path, methodName, props, cb, jsonRequest, successAlert){
     $.post(linksMaker.makeProcedureLink(path, methodName), jsonRequest ? JSON.stringify(props) : props, 'text')
      .success(function(data) {
          if(successAlert)
              alert(data);
          if(cb)
              cb(data);
      })
      .error(function(xhr){
          alert(xhr.responseText);
      });
 }

 function getCurrentPageValues(){
     var values = {};
     <?php
         if(isset($ascope) && key_exists("mode", $ascope)){
             if($ascope["mode"] == "view" || $ascope["mode"] == "edit"){
                 if(property_exists($data, "editCategories")){
                     $values = [];
                     foreach($data->editCategories as $name=>$category){
                         $cvalues = $data->getEditItem($ascope["item"], $name);
                         foreach($cvalues as $key=>$value){
                             $values[$key] = $value;
                         }
                         echo "values = " . json_encode($values, JSON_PRETTY_PRINT) . ";";
                     }
                 }
             }
         }
     ?>
     var ind, elem;
     for(ind in values){
         elem = $('#' + ind);
         if(elem.length)
             values[ind] = elem.val()
     }
     return values;
     //     return ["ee", "ddd"];
 }

 function recalcDetailClient(){
     <?php if(isset($ascope) && key_exists("path", $ascope)): ?>
     serverProcedureAnyCall("<?php echo $ascope["path"]; ?>", "recalcForClient", getFormData($("#itemData")), function(res){
         var item = JSON.parse(res), ind;
         for(ind in item)
             $("input[name=" + ind + "]").val(item[ind]);
         //  console.log(res);
     });
     <?php endif; ?>
 }

 function datetimeToISO(datetime){
     var date = new Date(datetime),
         iso = date.getFullYear() + '-' + (date.getMonth()+1) + '-' + date.getDate();
     iso = iso.replace(/(^|\D)(\d)(?!\d)/g, '$10$2');
     return iso;
 }
</script>
