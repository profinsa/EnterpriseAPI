<script>
 function generateKeyString(props){
     var key, keyString = "<?php echo $ascope["user"]["CompanyID"] . "__" . $ascope["user"]["DivisionID"] . "__" . $ascope["user"]["DepartmentID"] . "__"; ?>";
     for(key in props)
	 keyString += props[key];
     return keyString;
 }
 var linksMaker = {
     makeEmbeddedgridItemNewLink : function(viewpath, backpath, keyString, item){
	 return "index.php#/?page=grid&action=" + viewpath + "&mode=new&category=Main&item=" + keyString + "&back=" + encodeURIComponent("index.php#/?page=grid&action=" + backpath + "&mode=view&category=Main&item=" + item);
     }
     
 };
</script>
