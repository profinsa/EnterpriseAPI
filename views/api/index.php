<?php
    require "views/components/commonJavascript.js.php";
?>

 var viewPageModal = 
     "<div class=\"modal fade\" id=\"viewPageModal\">" +
     "<div class=\"modal-dialog\">" +
     "<div class=\"modal-content\">" +
     "<div class=\"modal-header\">" +
     "<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button>" +
     "<h4 class=\"modal-title\">The demo access form</h4>" +
     "</div>" +
     "<div class=\"modal-body\">" +
     "<form role=\"form\" id=\"viewPageForm\">" +
     "<div class=\"form-group\">" +
     "<label for=\"LeadEmail\">Email Address</label>" +
     "<input type=\"email\" class=\"form-control\" name=\"LeadeEmail\" id=\"LeadEmail\" placeholder=\"Enter email\" required>" +
     "</div>" + 

     "<div class=\"form-group\">" + 
     "<label for=\"LeadCompany\">Company Name</label>" +
     "<input type=\"text\" class=\"form-control\" id=\"LeadCompany\" name=\"LeadCompany\" placeholder=\"Password\">" +
     "</div>" +

     "<div class=\"form-group\">" + 
     "<label for=\"LeadFirstName\">First Name</label>" +
     "<input type=\"text\" class=\"form-control\" id=\"LeadFirstName\" name=\"LeadFirstName\" placeholder=\"Password\">" +
     "</div>" +

     "<div class=\"form-group\">" + 
     "<label for=\"LeadLastName\">Last Name</label>" +
     "<input type=\"text\" class=\"form-control\" id=\"LeadLastName\" + name=\"LeadLastName\" placeholder=\"Password\">" +
     "</div>" +

     "<div class=\"form-group\">" + 
     "<label for=\"LeadAddress1\">Address</label>" +
     "<input type=\"text\" class=\"form-control\" id=\"LeadAddress1\" name=\"LeadAddress1\" placeholder=\"Password\">" +
     "</div>" +

     "<div class=\"form-group\">" + 
     "<label for=\"LeadPhone\">Phone Number</label>" +
     "<input type=\"text\" class=\"form-control\" id=\"LeadPhone\" name=\"LeadPhone\" placeholder=\"Password\">" +
     "</div>" +

     "<input select type=\"hidden\" class=\"form-control\" id=\"LeadMemo2\" name=\"LeadMemo2\">" +
     
     "<div class=\"form-group\">" + 
     "<label for=\"LeadMemo1\">Notes</label>" +
     "<input type=\"text\" class=\"form-control\" id=\"LeadMemo1\" name=\"LeadMemo1\" placeholder=\"Notes\">" +
     "</div>" +

     "<div class=\"modal-footer\">" +
     "<button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">Cancel</button>" +
     "<button type=\"button\" class=\"btn btn-primary\" onclick=\"viewDemoPageSubmit()\">Send</button>" +
     "</div>" +
     
     "</div><!-- /.modal-content -->" +
     "</div><!-- /.modal-dialog -->" +
     "</div><!-- /.modal -->";

 function viewDemoPageSubmit(){
     console.log($("#LeadEmail")[0]);
     if($("#LeadEmail").val() == "")
         $("#LeadEmail").css("border", "1px solid red");
     else {
         var viewedPages = localStorage.getItem("viewedPages");
         if(viewedPages == null){
             viewedPages = {};
             viewedPages[projectName] = "viewed";
             localStorage.setItem("viewedPages", JSON.stringify(viewedPages));
         }else{
             viewedPages = JSON.parse(viewedPages);
             viewedPages[projectName] = "viewed";
             localStorage.setItem("viewedPages", JSON.stringify(viewedPages));
         }
         //var viewPageForm = $("#viewPageForm"),
         //  formArray = viewPageFormArray.serializeArray();
         //         if(formArray
         //       console.log(.serialize());
     }
 }
 
 function viewDemoPage(projectName, link){
     var viewedPages = localStorage.getItem("viewedPages"),
         viewed = false;
     if(viewedPages != null){
         viewedPages = JSON.parse(viewedPages);
         if(viewedPages[projectName])
             viewed = true;
     }

     //         if(!viewed){
     $("body").append(viewPageModal);
     $("#viewPageModal").modal("show");
     //       }else
     //     window.location = link;
 }


