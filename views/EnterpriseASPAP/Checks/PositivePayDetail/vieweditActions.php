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

 function downloadCsv(data){
     downloadFile("positive pay.csv", data);
 }
 
 function CreateFile(){
    // console.log(new Date($("#EndDate").val()).setHours(23,59,59,999));
    var st = new Date($("#StartDate").val());
    var dt = new Date($("#EndDate").val());

    $.post("<?php echo $linksMaker->makeProcedureLink($ascope["path"], "getPositivePayTable"); ?>",{
        "GLBankAccount" : $("#GLBankAccount").val(),
        "StartDate" : new Date(st.setHours(st.getHours() + 3)).toISOString(),
        "EndDate" : new Date(new Date(new Date(dt.setHours(dt.getHours() + 26)).setMinutes(59)).setSeconds(59)).toISOString()
    })
    .success(function(data) {
        downloadCsv(data);
    })
    .error(function(err){
        // alert('Something goes wrong');
    });
 }
</script>

<a class="btn btn-info" href="javascript:;" onclick="CreateFile()">
    <?php
    echo $translation->translateLabel("Create File");
    ?>
</a>
