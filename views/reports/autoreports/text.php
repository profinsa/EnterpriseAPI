<form class="form-inline col-md-12">
    <div class="checkbox">
	<label>
	    <input type="checkbox" onclick="textShowHeader(event);" <?php echo key_exists("showHeader", $_GET) && $_GET["showHeader"] == "true" ? "checked" : ""; ?>> <?php echo $translation->translateLabel("Show Header"); ?>
	</label>
    </div>
    <a href="javascript:;" class="btn btn-default" onclick="downloadCsv();"><?php echo $translation->translateLabel("Download"); ?></a>
</form>
<div id="csvContainer" class="col-md-12" style="margin-top:20px;font-size:12pt;">
    <?php
    $tableData = $data->getData();
    ?>
    <?php if(count($tableData)): ?>
	<?php
	$fileContent = "";
	if(key_exists("showHeader", $_GET) && $_GET["showHeader"] == "true"){
	    $columns = [];
	    foreach($tableData[0] as $key=>$value)
		$columns[] = $translation->translateLabel($key);
	    echo implode(",", $columns) . "<br/>";
	    $fileContent = implode(",", $columns) . "\\n";
	}
	foreach($tableData as $row){
	    $values = [];
	    foreach($row as $value)
		$values[] = $value;
	    echo implode(",", $values) . "<br/>";
	    $fileContent .= implode(",", $values) . "\\n";
	}
	?>
    <?php endif; ?>
</div>
<script>
 function downloadFile(filename, text) {
     var element = document.createElement('a');
     element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(text));
     element.setAttribute('download', filename);

     element.style.display = 'none';
     document.body.appendChild(element);

     element.click();

     document.body.removeChild(element);
 }

 function downloadCsv(){
     //console.log(document.getElementById("csvContainer").textContent);
     downloadFile("<?php echo $_GET["title"] . ".csv";?>", "<?php echo $fileContent; ?>");
 }
 
 function textShowHeader(event){
     var url = window.location.href, match;
     match = url.match(/showHeader\=(\w+)/);
     if(match)
	 url = url.replace(/showHeader\=\w+/, "showHeader=" + JSON.stringify(event.target.checked));
     else
	 url = url + "&showHeader=" + JSON.stringify(event.target.checked);
     window.location = url;
 }
</script>
