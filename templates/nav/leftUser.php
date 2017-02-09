<div class="user-profile">
    <div class="dropdown user-pro-body">
        <div><img src="dependencies/plugins/images/users/varun.jpg" alt="user-img" class="img-circle"></div>
        <a href="#" class="dropdown-toggle u-dropdown" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><?php echo $_app->scope["page"]->user["EmployeeUserName"];  ?><span class="caret"></span></a>
        <ul class="dropdown-menu animated flipInY">
            <!-- <li><a href="#"><i class="ti-user"></i> My Profile</a></li>
		 <li><a href="#"><i class="ti-wallet"></i> My Balance</a></li>
		 <li><a href="#"><i class="ti-email"></i> Inbox</a></li>
		 <li role="separator" class="divider"></li>
		 <li><a href="#"><i class="ti-settings"></i> Account Setting</a></li>
		 <li role="separator" class="divider"></li>- -->
            <li><a href="index.php?page=login"><i class="fa fa-power-off"></i><?php echo $_translation->translateLabel("Log out"); ?></a></li>
        </ul>
    </div>
</div>

