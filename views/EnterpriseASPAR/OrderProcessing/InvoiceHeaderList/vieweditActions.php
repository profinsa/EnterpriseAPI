<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('RecalcShipping', { InvoiceNumber : '<?php echo $headerItem["OrderNumber"]; ?>'}, true);">
    <?php
        echo $translation->translateLabel("Recalc Invoice Shipping");
    ?>
</a>

<a class="btn btn-info" href="javascript:;" onclick="callRecalc('<?php echo $headerItem["InvoiceNumber"]; ?>')">
    <?php
        echo $translation->translateLabel("Recalc");
    ?>
</a>

<?php if(!$headerItem["Posted"]): ?>
    <a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Post', { InvoiceNumber : '<?php echo $headerItem["InvoiceNumber"]; ?>'}, true);">
        <?php
            echo $translation->translateLabel("Post");
        ?>
    </a>    
<?php endif; ?>


<a class="btn btn-info" href="javascript:;" onclick="serverProcedureCall('Memorize', { id : '<?php echo $ascope["item"]; ?>', Memorize : '<?php echo $headerItem["Memorize"]; ?>'}, true);">
    <?php
        if(!$headerItem["Memorize"])
            echo $translation->translateLabel("Memorize");
        else
            echo $translation->translateLabel("UnMemorize");
    ?>
</a>
<?php
    $paymentFields = [
        "Test" => [
            "CreditCardTypeID" =>[
                "label" => "Credit Card Type",
                "fieldName" => "CreditCardTypeID"
            ],
            "CreditCardName" =>[
                "label" => "Credit Card Name",
                "fieldName" => "CreditCardName"
            ],
            "CreditCardNumber" =>[
                "label" => "Credit Card Number",
                "fieldName" => "CreditCardNumber"
            ],
            "CreditCardExpDate" =>[
                "label" => "Credit Card Expiration Date",
                "fieldName" => "CreditCardExpDate"
            ],
            "CreditCardCSVNumber" =>[
                "label" => "Credit Card CSV Number",
                "fieldName" => "CreditCardCSVNumber"
            ],
            "Total" => [
                "label" => "Total",
                "fieldName" => "Total"
            ]
        ],
        "Paypal" => [
            "Total" => [
                "label" => "Total",
                "fieldName" => "Total"
            ]
        ]
    ];
?>
<?php foreach($paymentFields as $paymentType=>$fields): ?>
    <div id="receivePaymentDialog<?php echo $paymentType; ?>" class="modal fade  bs-example-modal-md" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-sm modal-dialog-center" style="width:600px !important" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h2 class="modal-title">
                        <?php echo $translation->translateLabel("Receive Payment Form"); ?>
                    </h2>
                </div>
                <div class="modal-body">
                    <form action="#" id="receivePaymentForm"  onsubmit="return false"> 
                        <div class="col-lg-12 col-md-12" style="margin-bottom:10px">
                            <?php foreach($fields as $fieldName=>$def): ?>
                                <div class="col-md-12" style="margin-bottom:5px;">
                                    <div class="col-md-6">
                                        <label>
                                            <?php echo $translation->translateLabel($def["label"]);  ?>
                                        </label>
                                    </div>
                                    <div class="col-md-6">
                                        <?php echo renderInput($ascope, $data, $data->editCategories["...fields"], $data->editCategories["...fields"][$fieldName], $fieldName, $headerItem[$fieldName], $keyString, 1); ?>
                                        <!-- <input type="text" name="<?php echo $fieldName; ?>" placeholder="" value="<?php echo $headerItem[$fieldName]; ?>" class="pull-right" /> -->
                                    </div>
                                </div>
                            <?php endforeach; ?>
                        </div>
                    </form>
                </div>
                <div class="modal-footer" style=border-top:none">
                    <button type="button" class="btn btn-primary" id="processButton">
                        <?php echo $translation->translateLabel("Process"); ?>
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        <?php echo $translation->translateLabel("Cancel"); ?>
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <script>
     $('#processButton').click(function(){
         var registerform = $('#registerForm');
         var requiredFields = [
             "CustomerPhone", 
             "CustomerPassword", 
             "CustomerFirstName",
             "CustomerLastName",
             "CustomerName",
             "CustomerEmail"
         ], ind, success = true;
         
         for(ind in requiredFields){
             $("input[name=" + requiredFields[ind] + "]").removeClass("has-error");
             if($("input[name=" + requiredFields[ind] + "]").val() == ""){
                 $("input[name=" + requiredFields[ind] + "]").addClass("has-error");
                 success = false;
             }
         }
         
         if(success){
             serverEnterpriseXProcedureAnyCall("AccountsReceivable/Customers/ViewCustomers", "getNewItemAllRemote", { id : ""}, function(data, error){
                 var values = JSON.parse(data);
                 values.CustomerID = values.CustomerFirstName = $("input[name=CustomerFirstName]").val();
                 values.CustomerLastName = $("input[name=CustomerLastName]").val();
                 values.CustomerName = $("input[name=CustomerName]").val();
                 values.CustomerEmail = $("input[name=CustomerEmail]").val();
                 values.CustomerLogin = values.CustomerPhone = $("input[name=CustomerPhone]").val();
                 values.CustomerPassword = $("input[name=CustomerPassword]").val();
                 values.CustomerWebPage = $("input[name=CustomerWebPage]").val();
                 values.CustomerAddress1 = $("input[name=CustomerAddress1]").val();
                 values.CustomerAddress2 = $("input[name=CustomerAddress2]").val();
                 values.CustomerAddress3 = $("input[name=CustomerAddress3]").val();
                 values.CustomerCounty = $("input[name=CustomerCountry]").val();
                 values.CustomerState = $("input[name=CustomerState]").val();
                 values.CustomerCity = $("input[name=CustomerCity]").val();
                 values.CustomerZip = $("input[name=CustomerZip]").val();
                 console.log(values);
                 
                 serverEnterpriseXProcedureAnyCall("AccountsReceivable/Customers/ViewCustomers", "insertItemRemote", values, function(data, error){
                     serverProcedureAnyCall("users", "loginWithoutCaptcha", {
                         username : values.CustomerLogin,
                         password : values.CustomerPassword
                     }, function(data, error){
                         if(data)
                             location.reload();

                     });
                 });
             });
         }else{
             serverProcedureAnyCall("users", "getCaptcha", {}, function(data, error){
                 document.getElementById('imgRegisterCaptcha').src = data.captcha;
                 registerCaptcha = data.captchaPhrase;
             });     
         }
         return;
     });
    </script>
<?php endforeach; ?>

<script>
 function receivePayment(type){
     console.log('receiving ' + type);
     $("#receivePaymentDialog" + type).modal("show");
     //     var Numbers = [], ind;

     //   for(ind in gridItemsSelected)
     //     Numbers.push(gridItemsSelected[ind].InvoiceNumber);

     //    serverProcedureCall('CopyToHistory', { InvoiceNumbers :Numbers.join(',') }, true);
 }
</script>
<span class="dropdown">
    <button class="btn btn-info grid-actions-button dropdown-toggle" type="button" data-toggle="dropdown">Receive Payment With
        <span class="caret"></span></button>
    <ul class="dropdown-menu">
        <li><a href="javascript:;" onclick="receivePayment('Test')">Test</a></li>
        <li><a href="javascript:;" onclick="receivePayment('Paypal')">Paypall</a></li>
    </ul>
</span>

