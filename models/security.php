<?php
/*
  Name of Page: Security

  Method: Response for security management

  Date created: Nikita Zaharov, 24.02.2017

  Use: Provide simple methods for checking user rights. Searches in permissionGenerated page permissions and then check user rights

  Input parameters:
  type of right or menu item name

  Output parameters:
  true if right is 
  false if is not

  Called from:
  + most index and grid controller. Also from gridView

  Calls:

  Last Modified: 19.09.2019
  Last Modified by: Nikita Zaharov
*/

class Security{
    public $permissions;
    public $useraccess;
    public $menuFlags = [
        "CommonTasks" => "MTARView",
        "GeneralLedger" => "MTGLView",
        "Financials" => "MTGLView",
        "AccountsReceivable" => "MTARView",
        "AccountsPayable" => "MTAPView",
        "Inventory" => "MTInventoryView",
        "FundAccounting" => "MTFundView",
        "Payroll" => "MTPayrollView",
        "CRMHelpDesk" => "MTCRMView",
        "ProjectsJobs" => "MTARView",
        "ECommerce" => "MTARView",
        "MRP" => "MTMRPView",
        "HelpDesk" => "MTCRMView",
        "SystemSetup" => "MTSystemView",
        "Reports" => "MTReportsView",
        "MetaAdmin" => "MetaView"
    ];

    public $menuToProfileFlags = [
        "CommonTasks" => "ProfileARModule",
        "GeneralLedger" => "ProfileGLModule",
        "Financials" => "ProfileFinancialsModule",
        "AccountsReceivable" => "ProfileARModule",
        "AccountsPayable" => "ProfileAPModule",
        "Inventory" => "ProfileInventoryModule",
        "FundAccounting" => "ProfileFundModule",
        "Payroll" => "ProfilePayrollModule",
        "CRMHelpDesk" => "ProfileCRMModule",
        "ProjectsJobs" => "ProfileARModule",
        "ECommerce" => "ProfileARModule",
        "MRP" => "ProfileMRPModule",
        "HelpDesk" => "ProfileCRMModule",
        "SystemSetup" => "ProfileSystemModule",
        "Reports" => "ProfileReportsModule"
    ];

    public $model = false;
    public $mode = "view";
    public $item;
    public $config = null;
    public $productProfile = null;

    public function __construct($useraccessperm, $perm){
        $this->config = config();
        if(key_exists("productProfile", $this->config)){
            $this->productProfile = json_decode(file_get_contents(__DIR__ . "/../Admin/ProductProfiles/" . $this->config["productProfile"] . ".json"), true);
        }
        $this->permissions = $perm;
        $this->useraccess = $useraccessperm;
    }

    public function setModel($model, $item, $mode){
        $this->model = $model;
        $this->item = $item;
        $this->mode = $mode;
    }

    public function checkMenu($name){
        if(key_exists($this->menuFlags[$name], $this->useraccess) &&
           $this->useraccess[$this->menuFlags[$name]] &&
           (!key_exists("productProfile", $this->config) || (key_exists($this->menuToProfileFlags[$name], $this->productProfile) &&
                                                             $this->productProfile[$this->menuToProfileFlags[$name]])))
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
