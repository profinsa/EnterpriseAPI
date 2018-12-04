<script>
 function generateKeyString(props){
     var key, keyString = "<?php echo $ascope["user"]["CompanyID"] . "__" . $ascope["user"]["DivisionID"] . "__" . $ascope["user"]["DepartmentID"] . "__"; ?>";
     for(key in props)
	 keyString += props[key];
     return keyString;
 }

 //global object used for creatink links to any part of application
 var linksMaker = {
     makeEmbeddedgridItemNewLink : function(viewpath, backpath, keyString, item){
	 return "index.php#/?page=grid&action=" + viewpath + "&mode=new&category=Main&item=" + keyString + "&back=" + encodeURIComponent("index.php#/?page=grid&action=" + backpath + "&mode=view&category=Main&item=" + item);
     },
     makeProcedureLink : function (path, procedure){
         return "index.php?page=grid&action=" + path + "&procedure=" + procedure;
     }
 };

 function setRecalc(id){
     var recalcLink = linksMaker.makeProcedureLink(path, "Recalc");
     //automatic recalc if we back from detail
     localStorage.setItem("recalclLink", recalcLink);
     localStorage.setItem("autorecalcLink", recalcLink);
     var autorecalcData = {};
     autorecalcData[env.idFileds] = id;
     localStorage.setItem("autorecalcData", JSON.stringify(autorecalcData));
 }
</script>
