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

  Last Modified: 07.12.2016
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

    protected $model = false;
    protected $mode = "view";
    protected $item;

    public function __construct($useraccessperm, $perm){
        $this->permissions = $perm;
        $this->useraccess = $useraccessperm;
    }

    public function setModel($model, $item, $mode){
        $this->model = $model;
        $this->item = $item;
        $this->mode = $mode;
    }

    public function checkMenu($name){
        if(key_exists($this->menuFlags[$name], $this->useraccess) && $this->useraccess[$this->menuFlags[$name]])
           return true;
        return false;
    }
    
    public function can($action){
        $user = $_SESSION["user"];
        if($this->permissions[$action] == "any" || $this->permissions[$action] == "Always")
            return 1;
        $perms = explode("|", $this->permissions[$action]);
        
        $lockedBy;
        if($this->mode == "view" && $this->model && $this->item != 'all' && ($lockedBy = $this->model->lockedBy($this->item)) && $lockedBy->LockedBy != $user["EmployeeID"])
            return false;
        
        foreach($perms as $value)
            if(key_exists($value, $this->useraccess) && $this->useraccess[$value])
                return true;
        return false;
    }
    
    public function isAdmin(){
        if($this->useraccess["ADSetup"] || $this->useraccess["ADSecurity"])
            return true;
        
        return false;
    }

    public function isGLAdmin(){
        if($this->useraccess["GLSetup"])
            return true;
        
        return false;
    }
}
