<?php
/*
Name of Page: Security

Method: Response for security management

Date created: Nikita Zaharov, 24.02.2016

Use: Provide simple methods for checking user rights. Searches in permissionGenerated page permissions and then check user rights

Input parameters:
type of right or menu item name

Output parameters:
true if right is 
false if is not

Called from:
+ most index and grid controller. Also from gridView

Calls:

Last Modified: 24.02.2016
Last Modified by: Nikita Zaharov
*/

class Security{
    protected $permissions;
    protected $useraccess;
    protected $menuFlags = [
        "AccountsReceivable" => "MTARView",
        "AccountsPayable" => "MTAPView",
        "GeneralLedger" => "MTGLView",
        "Inventory" => "MTInventoryView",
        "MRP" => "MTMRPView",
        "FundAccounting" => "MTFundView",
        "CRMHelpDesk" => "MTCRMView",
        "Payroll" => "MTPayrollView",
        "SystemSetup" => "MTSystemView",
        "Reports" => "MTReportsView"
    ];

    public function __construct($useraccessperm, $perm){
        $this->permissions = $perm;
        $this->useraccess = $useraccessperm;
    }

    public function checkMenu($name){
        if(key_exists($this->menuFlags[$name], $this->useraccess) && $this->useraccess[$this->menuFlags[$name]])
           return 1;
        return 0;
    }
    
    public function can($action){
        if($this->permissions[$action] == "any" || $this->permissions[$action] == "Always")
            return 1;
        $perms = explode("|", $this->permissions[$action]);
        foreach($perms as $value)
            if(key_exists($value, $this->useraccess) && $this->useraccess[$value])
                return 1;
        return 0;
    }
}
