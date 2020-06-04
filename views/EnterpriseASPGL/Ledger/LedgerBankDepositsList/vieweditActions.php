<script>
 var recalcLink = "<?php echo $linksMaker->makeProcedureLink($ascope["path"], "Recalc"); ?>",
     recalcData = {
	 "GLTransactionNumber" : "<?php echo $item["GLTransactionNumber"]; ?>"
     };

 //automatic recalc if we back from detail
 localStorage.setItem("recalclLink", recalcLink);
 localStorage.setItem("autorecalcLink", recalcLink);
 localStorage.setItem("autorecalcData", JSON.stringify(recalcData));

 function saveClicked(){
     if("<?php echo $ascope["mode"]; ?>" == "new"){
	 alert("<?php echo $translation->translateLabel("Please add at least one transaction!"); ?>");
	 return;
     }
     
     $.post("<?php echo $linksMaker->makeProcedureLink($ascope["path"], "Save"); ?>",{
         "GLTransactionNumber" : "<?php echo $item["GLTransactionNumber"]; ?>"
     })
      .success(function(data) {
	  window.location = "<?php echo $linksMaker->makeGridItemViewCancel($ascope["path"]); ?>";
      })
      .error(function(xhr){
	  alert(xhr.responseText);
      });
 }
 $("#saveButton")[0].onclick = "";
 $("#saveButton").click(saveClicked);

</script>
<!-- <a class="btn btn-info" href="javascript:;" onclick="saveClicked()">
    <?php echo $translation->translateLabel("Save"); ?>
     </a> -->
