<?php
    //$modules = $data->getModules();
    $topics = $data->getTopics();
    $currentDocument = $data->getDocument();
?>
<!DOCTYPE html>
<html class="no-js">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>Welcome - Integral Accounting Enterprise (All Versions)</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Language" content="en">
        <meta name="description" content="Help documentation, installation instructions, technical reference guide and user manual for all Integral Accounting Enterprise Versions." />
        <!--        <base href="//stfbinc.helpdocs.com/" /> -->
        <link rel="stylesheet" href="assets/css/help/photoswipe.css"> 
        <link rel="stylesheet" href="assets/css/help/default-skin.css"> 
        <link rel="stylesheet" href="assets/css/help/styles.css" media="screen, handheld">
        <link rel="stylesheet" href="assets/css/help/print.css" media="print">
        <link rel="stylesheet" href="assets/css/help/1542823544.css" media="screen, handheld" />
        <script src="assets/js/help/modernizr-2.6.2-respond-1.1.0.min.js"></script>
        <script src="assets/js/help/photoswipe.js"></script> 
        <script src="assets/js/help/photoswipe-ui-default.js"></script>
        <script src="assets/js/help/jquery-1.11.1.min.js"></script>
        <script src="assets/js/help/bootstrap.min.js"></script>
        <script src="assets/js/help/plugins.js"></script>
        <script src="assets/js/help/main.js"></script>
	<?php require './views/components/commonJavascript.php';?>
    </head>
    <body>        
        <div class="site--wrap">
            <header class="site--header custom-site-header-color">
                <div class="container">
                    <a href="//stfbinc.helpdocs.com" class="brand-logo">
                        <img src="https://s3.amazonaws.com/tw-desk/i/113954/doclogo/72179.20180523160644009.72179.201805231606440090wnSy.jpg" alt="Integral Accounting Enterprise (All Versions)">
                        
                    </a>
                    <a href="#" class="menu-toggle visible-xs" tabindex="1">
                        <span class="text-hide">Menu</span>
                        <span class="menu-lines">
                            <span></span>
                            <span></span>
                            <span></span>
                        </span>
                    </a>
                    <nav class="header--nav">
                        <ul>
                            <li><a href="https://www.stfb.com">STFB Inc. Home Page</a></li>
                            <li><a href="#contact-form" data-toggle="modal" data-target="#contact-form">Submit a Request</a></li>
                        </ul>
                    </nav>
                </div>
            </header>
            <section class="site--main">
                <div class="search--row search-inner">
                    <div class="container">
                        <div class="row-content">
                            <h1 class="row-title"><a href="//stfbinc.helpdocs.com">Knowledge Base</a></h1>
                            <ul class="history-path">
                                <li><a href="//stfbinc.helpdocs.com//"></a></li>
                            </ul>
                        </div>
                        <form action="//stfbinc.helpdocs.com/search" method="GET" class="search-form">
                            <input type="text" placeholder="Search" class="search_input" name="query" value="">
                            <input type="button" value="Search" class="search_submit">
                        </form>
                    </div>
                </div>
                <div class="container content-main">
                    <section class="category--structure">
                        <aside class="left-sidebar">
                            <ul class="list-links js_tinynav hidden-xs">
                                <!--                                 <li><a href="//stfbinc.helpdocs.com/categories">All Articles</a></li>
                                     <li>
                                     <a href="<?php echo $linksMaker->makeHelpLinkById("welcome"); ?>">Welcome</a>
                                     </li>-->
                                <?php foreach($topics as $name=>$topic): ?>
                                    <?php if(count($topic["modules"])): ?>
                                        <li>
                                            <a data-toggle="collapse" data-target="#collapse-<?php echo $topic["TopicID"]; ?>" class="have_drop collapsed"></a>
                                            <a data-toggle="collapse" data-target="#collapse-<?php echo $topic["TopicID"]; ?>" class="cat-name" href="#"><?php echo $topic["TopicName"]; ?></a>
                                            <ul class="collapse" id="collapse-<?php echo $topic["TopicID"]; ?>">
                                                <?php foreach($topic["modules"] as $moduleId=>$module): ?>
                                                    <?php if(count($module["documents"])): ?>
                                                        <li>
                                                            <a data-toggle="collapse" data-target="#collapse-<?php echo $topic["TopicID"] . $module["ModuleID"]; ?>" class="have_drop collapsed"></a>
                                                            <a data-toggle="collapse" data-target="#collapse-<?php echo $topic["TopicID"] . $module["ModuleID"]; ?>" class="cat-name" href="#"><?php echo $module["ModuleName"]; ?></a>
                                                            <ul class="collapse" id="collapse-<?php echo $topic["TopicID"] . $module["ModuleID"]; ?>">
                                                                <?php foreach($module["documents"] as $documentId=>$document): ?>
                                                                    <li><a href="<?php echo $linksMaker->makeHelpLinkById($document["DocumentTitleID"]); ?>"><?php echo $document["DocumentTitle"]; ?></a></li>
                                                                <?php endforeach; ?>
                                                            </ul>
                                                            
                                                        </li>
                                                    <?php endif; ?>
                                                <?php endforeach; ?>
                                            </ul>
                                        </li>
                                    <?php endif; ?>
                                <?php endforeach; ?>
                                <!--                                <li>
                                     <a href="//stfbinc.helpdocs.com/getting-started">Getting Started</a>
                                     
                                     </li>
                                     <li>
                                     <a data-toggle="collapse" data-target="#collapse-1315" class="have_drop collapsed"></a>
                                     <a class="cat-name" href="//stfbinc.helpdocs.com/installation">Installation</a>
                                     <ul class="collapse" id="collapse-1315">
                                     <li>
                                     <a href="//stfbinc.helpdocs.com/integral-accounting-enterprise-x-specific-information">Integral Accounting Enterprise X Specific Information </a>
                                     
                                     </li>
                                     </ul>
                                     
                                     </li> -->
                                <!--                                 <li>
                                     <a data-toggle="collapse" data-target="#collapse-1318" class="have_drop collapsed"></a>
                                     <a class="cat-name" href="//stfbinc.helpdocs.com/user-manual">User Manual</a>
                                     <ul class="collapse" id="collapse-1318">
                                     <li>
                                     <a data-toggle="collapse" data-target="#collapse-1350" class="have_drop collapsed"></a>
                                     <a class="cat-name" href="//stfbinc.helpdocs.com/accounts-receivable">Accounts Receivable</a>
                                     <ul class="collapse" id="collapse-1350">
                                     <li><a href="//stfbinc.helpdocs.com/orders">Orders</a></li>
                                     <li><a href="//stfbinc.helpdocs.com/invoices">Invoices</a></li>
                                     <li><a href="//stfbinc.helpdocs.com/cash-receipts">Cash Receipts</a></li>
                                     <li><a href="//stfbinc.helpdocs.com/credit-memos">Credit Memos</a></li>
                                     </ul>
                                     </li>
                                -->                                   
                                
                                <!--                                 <li>
                                     <a href="//stfbinc.helpdocs.com/cart">Cart</a>
                                     
                                     </li> -->
                                
                                
                            </ul>
                        </aside>
                        <section class="right-content" style="line-height: 1.5;">
                            <?php echo $currentDocument->DocumentContents; ?>
                            <!--                           <header>
                                 <form method="GET">
                                 <select tabindex="-1" style="margin-top: 8px;" class="form-control pull-right input-sort" name="order" onchange="this.form.submit();">
                                 <option value="relevance">Sort by relevance</option>
                                 <option value="popularity">Sort by popularity</option>
                                 <option value="title">Sort by title</option>
                                 <option value="dateadded">Sort by date</option>
                                 </select>
                                 </form>
                                 
                                 <h2>Welcome</h2>
                                 
                                 </header>
                                 <section class="content-hold">
                                 <ul class="articles-list">
                                 
                                 <li>
                                 <a href="//stfbinc.helpdocs.com/welcome/welcome2">
                                 <span class="icon-hold">
                                 <img src="//stfbinc.helpdocs.com/public/images/icons/i-article.svg" width="14px" height="18px">
                                 </span>
                                 Welcome
                                 </a>
                                 </li>
                                 
                                 <li>
                                 <a href="//stfbinc.helpdocs.com/welcome/user-manual2">
                                 <span class="icon-hold">
                                 <img src="//stfbinc.helpdocs.com/public/images/icons/i-article.svg" width="14px" height="18px">
                                 </span>
                                 User Manual
                                 </a>
                                 </li>
                                 
                                 <li>
                                 <a href="//stfbinc.helpdocs.com/welcome/features-overview">
                                 <span class="icon-hold">
                                 <img src="//stfbinc.helpdocs.com/public/images/icons/i-article.svg" width="14px" height="18px">
                                 </span>
                                 Features Overview
                                 </a>
                                 </li>
                                 
                                 <li>
                                 <a href="//stfbinc.helpdocs.com/welcome/gaap-compliance">
                                 <span class="icon-hold">
                                 <img src="//stfbinc.helpdocs.com/public/images/icons/i-article.svg" width="14px" height="18px">
                                 </span>
                                 GAAP Compliance
                                 </a>
                                 </li>
                                 
                                 <li>
                                 <a href="//stfbinc.helpdocs.com/welcome/ias-compliance">
                                 <span class="icon-hold">
                                 <img src="//stfbinc.helpdocs.com/public/images/icons/i-article.svg" width="14px" height="18px">
                                 </span>
                                 IAS Compliance
                                 </a>
                                 </li>
                                 
                                 <li>
                                 <a href="//stfbinc.helpdocs.com/welcome/international-features">
                                 <span class="icon-hold">
                                 <img src="//stfbinc.helpdocs.com/public/images/icons/i-article.svg" width="14px" height="18px">
                                 </span>
                                 International Features
                                 </a>
                                 </li>
                                 
                                 <li>
                                 <a href="//stfbinc.helpdocs.com/welcome/license-agreement-compliance">
                                 <span class="icon-hold">
                                 <img src="//stfbinc.helpdocs.com/public/images/icons/i-article.svg" width="14px" height="18px">
                                 </span>
                                 License Agreement Compliance
                                 </a>
                                 </li>
                                 
                                 <li>
                                 <a href="//stfbinc.helpdocs.com/welcome/maintenance-agreement">
                                 <span class="icon-hold">
                                 <img src="//stfbinc.helpdocs.com/public/images/icons/i-article.svg" width="14px" height="18px">
                                 </span>
                                 Maintenance Agreement
                                 </a>
                                 </li>
                                 
                                 <li>
                                 <a href="//stfbinc.helpdocs.com/welcome/sox-compliance">
                                 <span class="icon-hold">
                                 <img src="//stfbinc.helpdocs.com/public/images/icons/i-article.svg" width="14px" height="18px">
                                 </span>
                                 SOX Compliance
                                 </a>
                                 </li>
                                 
                                 </ul>
                                 </section>
                                 </section>
                            -->
                        </section>
                </div>
                <div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="pswp__bg"></div>
                    <div class="pswp__scroll-wrap">
                        <div class="pswp__container">
                            <div class="pswp__item"></div>
                            <div class="pswp__item"></div>
                            <div class="pswp__item"></div>
                        </div>
                        <div class="pswp__ui pswp__ui--hidden">
                            <div class="pswp__top-bar">
                                <div class="pswp__counter"></div>
                                <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>
                                <button class="pswp__button pswp__button--share" title="Share"></button>
                                <button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>
                                <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>
                                
                                
                                <div class="pswp__preloader">
                                    <div class="pswp__preloader__icn">
                                        <div class="pswp__preloader__cut">
                                            <div class="pswp__preloader__donut"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
                                <div class="pswp__share-tooltip"></div> 
                            </div>
                            <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)">
                            </button>
                            <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)">
                            </button>
                            <div class="pswp__caption">
                                <div class="pswp__caption__center"></div>
                            </div>
                        </div>
                    </div>
                </div>
                    </section>
                    <footer class="site--footer">
                        <div class="container">
                            <p class="copyrights">
                                &copy; 2019 STFB Inc. Integral Accounting and the STFB Inc Logo are Trademarks of STFB Inc.</p>
                        </div>
                    </footer>
        </div>
        
        
        <div class="modal fade" id="contact-form" tabindex="-1" role="dialog" aria-labelledby="contact-form-header" aria-hidden="true">
            <div class="modal-dialog">
                <form  action="#" onsubmit="return onRequestSubmit(event);" id="requestForm">
                    <input type="hidden" name="timer" value="0" id="ft" />
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="contact-form-header">Get in Touch</h4>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="articleId" value="0" />
                            <!-- <div class="form-group">
                                 <div class="col-labels">
                                 <span class="in_label">Your Name</span>
                                 </div>
                                 <div class="col-inputs">
                                 <div class="form-group">
                                 <input type="text" class="form-control" name="name" required="true" id="contact-form-name" />
                                 </div>
                                 </div>
                                 </div>  -->
                            <div class="form-group">
                                <div class="col-labels">
                                    <span class="in_label">Email</span>
                                </div>
                                <div class="col-inputs">
                                    <div class="form-group">
                                        <input type="email" class="form-control" name="email" required="true" id="CustomerEmail" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-labels">
                                    <span class="in_label">Subject</span>
                                </div>
                                <div class="col-inputs">
                                    <div class="form-group">
                                        <input type="text" class="form-control" name="subject" required="true" id="SupportQuestion" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-labels">
                                    <span class="in_label">Message</span>
                                </div>
                                <div class="col-inputs">
                                    <div class="form-group">
                                        <textarea class="form-control" name="message" required="true" id="SupportDescription"></textarea>
                                    </div>
                                </div>
                            </div>
                            <!-- <div class="form-group">
                                 <div class="col-labels">
                                 <span class="in_label">Attachments</span>
                                 </div>
                                 <div class="col-inputs">
                                 <div class="form-group">
                                 <input type="file" class="form-control" name="attachment" />
                                 </div>
                                 </div>
                                 </div> -->
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <input type="submit" class="btn btn-primary" value="Send Inquiry" id="requestButton" />
                        </div>
                    </div>
                </form>
                <script type="text/javascript">
                 $(document).ready(function() {

                     if(window.location.href.indexOf('#contact-form') != -1) {
                         $('#contact-form').modal('show');
                     }

                 });
                 function onRequestSubmit(event){
                     var loginform = $('#requestForm');
                     $("#contact-form").hide();
                     //console.log(loginform);
                     //console.log(loginform.serialize());
                     
                     serverProcedureAnyCall("Payroll/EmployeeManagement/ViewEmployees", "saveCurrentSession", {}, function(data, error){
                         console.log(data);
                         serverProcedureAnyCallWithParams("CRMHelpDesk/HelpDesk/ViewSupportRequests", "", "getNewItemAllRemote", { id : "<?php echo $linksMaker->makeHelpKeyString(); ?>"}, function(data, error){
                             var values = JSON.parse(data);
                             values.CustomerId = "test";
                             values.CustomerEmail = $("#CustomerEmail").val();
                             values.SupportQuestion = $("#SupportQuestion").val();
                             values.SupportDescription = $("#SupportDescription").val();

                             //updating customer information
                             values.id = "<?php echo $linksMaker->makeHelpKeyString(); ?>";
                             values.type = "Main";
                             serverProcedureAnyCallWithParams("CRMHelpDesk/HelpDesk/ViewSupportRequests", "", "insertItemRemote", values, function(data, error){
                                 serverProcedureAnyCall("Payroll/EmployeeManagement/ViewEmployees", "restorePreviousSession", {}, function(data, error){
                                     console.log(data);
                                 });
                                 console.log("request is sent");
	                     });
                         });
                     });
                     return false;
                 }
                 if(window.location.protocol != "https:" && window.location.href.indexOf("helpdocs.com") != -1) {
                     window.location.href = "https:" + window.location.href.substring(window.location.protocol.length);
                 }
                 //window.baseURL = "//stfbinc.helpdocs.com";
                 //window.urlPrefix = "//stfbinc.helpdocs.com";
                </script>
            </div>
        </div>
    </body>
</html>
