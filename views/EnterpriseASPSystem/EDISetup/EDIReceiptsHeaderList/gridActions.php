<div id="uploadExcelModal" class="modal fade  bs-example-modal-sm" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm" role="document"  style="display:table; width: 300px !important">
	<div class="modal-content">
	    <div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		<h4 class="modal-title">
		    <?php echo $translation->translateLabel("Upload Excel"); ?>
		</h4>
	    </div>
	    <div class="modal-body">
		<div style="margin-top:10px;"></div>
		<form class="form-material form-horizontal m-t-30">
		    <div class="row">
			<div class="col-md-6 col-xs6">
			    <input type="file" id="excelFile" name="excelFile" class="form-control" value="" />
			</div>
		    </div>
		</form>
	    </div>
	    <div class="modal-footer">
		<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="uploadExcelClicked()">
		    <?php echo $translation->translateLabel("Save"); ?>
		</button>
		<button type="button" class="btn btn-primary" data-dismiss="modal">
		    <?php echo $translation->translateLabel("Cancel"); ?>
		</button>
	    </div>
	</div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
 function uploadExcelClicked(){
     var formData = new FormData();

     //console.log(attachments[1].files);
     formData.append('file[0]', $("#excelFile")[0].files[0]);

     $.ajax({
         url : '<?php echo $linksMaker->makeProcedureLink("SystemSetup/EDISetup/EDIReceipts", "uploadExcel"); ?>',
         type : 'POST',
         data : formData,
         processData: false,  // tell jQuery not to process the data
         contentType: false,  // tell jQuery not to set contentType
         success : function(e) {
	     onlocation(window.location);
         }
     });
 };
 
 function postSelected(){
     var ReceiptIDs = [], ind;
     for(ind in gridItemsSelected)
         ReceiptIDs.push(gridItemsSelected[ind].ReceiptID);

     serverProcedureAnyCall("<?php echo $ascope["path"]; ?>", 'PostSelected', { ReceiptIDs :ReceiptIDs.join(',') }, function(data){
	 var receipts = JSON.parse(data), ind;
	 var receiptsArr = [];
	 for(ind in receipts)
	     receiptsArr.push(receipts[ind].ReceiptID);
	 
	 console.log(data);
	 serverProcedureAnyCall("AccountsReceivable/CashReceiptsScreens/ViewCashReceipts", 'PostSelected', { ReceiptIDs : receiptsArr.join(',') }, function(){
	     onlocation(location);
	     console.log('receipts posted');
	 });
     });
 }

 function postAll(){
     serverProcedureAnyCall("<?php echo $ascope["path"]; ?>", 'PostAll', {}, function(data){
	 var receipts = JSON.parse(data), ind;
	 var receiptsArr = [];
	 for(ind in receipts)
	     receiptsArr.push(receipts[ind].ReceiptID);

	 console.log(data);
	 //	 console.log(receiptsArr.join(','));
	 serverProcedureAnyCall("AccountsReceivable/CashReceiptsScreens/ViewCashReceipts", 'PostSelected', { ReceiptIDs : receiptsArr.join(',') }, function(){
	     onlocation(location);
	     console.log("receipts posted");
	 });
     });
 }

</script>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="$('#uploadExcelModal').modal('show')">
    <?php
	echo $translation->translateLabel("Upload Excel");
    ?>
</a>
<a class="btn btn-info grid-actions-button" href="javascript:;" onclick="postSelected()">
    <?php
	echo $translation->translateLabel("Post Selected");
    ?>
</a>
<a class="btn btn-info grid-actions-button grid-last-actions-button" href="javascript:;" onclick="postAll()">
    <?php
	echo $translation->translateLabel("Post All");
    ?>
</a>
