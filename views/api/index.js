var linkSoftwarePrefix = "/EnterpriseX/";
<?php
require "views/components/commonJavascript.js.php";
?>

function makeHelpCredentialsString(type){
    if(type == "help")
        //production
        return "&config=STFBEnterprise&CompanyID=STFB&DivisionID=DEFAULT&DepartmentID=DEFAULT&EmployeeID=Demo&EmployeePassword=DemoDemo";
    //test
    //return "&config=common&CompanyID=DINOS&DivisionID=DEFAULT&DepartmentID=DEFAULT&EmployeeID=Demo&EmployeePassword=Demo";
    if(type == "common")
        return "&config=common&CompanyID=DINOS&DivisionID=DEFAULT&DepartmentID=DEFAULT&EmployeeID=Demo&EmployeePassword=Demo";                     
}

function makeHelpKeyString(){
    //production
    return "STFB__DEFAULT__DEFAULT";
    //test
    //return "DINOS__DEFAULT__DEFAULT";
}

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
    "<input type=\"text\" class=\"form-control\" id=\"LeadCompany\" name=\"LeadCompany\" placeholder=\"\">" +
    "</div>" +

    "<div class=\"form-group\">" + 
    "<label for=\"LeadFirstName\">First Name</label>" +
    "<input type=\"text\" class=\"form-control\" id=\"LeadFirstName\" name=\"LeadFirstName\" placeholder=\"\">" +
    "</div>" +

    "<div class=\"form-group\">" + 
    "<label for=\"LeadLastName\">Last Name</label>" +
    "<input type=\"text\" class=\"form-control\" id=\"LeadLastName\" + name=\"LeadLastName\" placeholder=\"\">" +
    "</div>" +

    "<div class=\"form-group\">" + 
    "<label for=\"LeadAddress1\">Address</label>" +
    "<input type=\"text\" class=\"form-control\" id=\"LeadAddress1\" name=\"LeadAddress1\" placeholder=\"\">" +
    "</div>" +

    "<div class=\"form-group\">" + 
    "<label for=\"LeadPhone\">Phone Number</label>" +
    "<input type=\"text\" class=\"form-control\" id=\"LeadPhone\" name=\"LeadPhone\" placeholder=\"\">" +
    "</div>" +
    "<input type=\"hidden\" id=\"LeadMemo2\" name=\"LeadMemo2\">" +
    
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

var _projectName, _link;

function viewDemoPageSubmit(){
    var projectName = $("#LeadMemo2").val();

    if($("#LeadEmail").val() == "")
        $("#LeadEmail").css("border", "1px solid red");
    else {
        var viewedPages = localStorage.getItem("viewedPages");
        if(viewedPages == null){
            viewedPages = {};
            viewedPages[_projectName] = "viewed";
            localStorage.setItem("viewedPages", JSON.stringify(viewedPages));
        }else{
            viewedPages = JSON.parse(viewedPages);
            viewedPages[_projectName] = "viewed";
            localStorage.setItem("viewedPages", JSON.stringify(viewedPages));
        }
        var viewPageForm = $("#viewPageForm"),
            formArray = viewPageForm.serializeArray();
        console.log(formArray);
        serverProcedureAnyCall("Payroll/EmployeeManagement/ViewEmployees", "saveCurrentSession", {}, function(data, error){                             
            var values = {};
            values.LeadID = values.LeadEmail = $("#LeadEmail").val();
            values.LeadCompany  = $("#LeadCompany").val();
            values.LeadFirstName - $("#LeadFirstName").val();
            values.LeadLastName = $("#LeadLastName").val();
            values.LeadAddress1 = $("#LeadAddress1").val();
            values.LeadPhone = $("#LeadPhone").val();
            values.LeadMemo1 = $("#LeadMemo1").val();
            values.LeadMemo2 = _projectName;

            //updating customer information
            values.id = makeHelpKeyString();
            values.type = "Main";
            serverProcedureAnyCallWithParams("CRMHelpDesk/CRM/ViewLeads", makeHelpCredentialsString("help"), "insertLeadForViewDemo", values, function(data, error){
                alert("Thanks you for interest!");
                serverProcedureAnyCall("Payroll/EmployeeManagement/ViewEmployees", "restorePreviousSession", {}, function(data, error){
                    window.location = _link;
                    console.log(data);
                });
            });
        });
        ///         if(formArray
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

    $("#LeadMemo2").val(_projectName = projectName);
    _link = link;
    if(!viewed){
        $("body").append(viewPageModal);
        $("#viewPageModal").modal("show");
    }else
    window.location = link;
}
