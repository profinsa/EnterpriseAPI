<script>
 function Customer_CreateFromLead(LeadID) {
     $.post("<?php echo "index.php?page=grid&action=CRMHelpDesk/CRM/ViewLeads&procedure=Customer_CreateFromLead"?>", {
         "LeadID": LeadID
     })
      .success(function(data) {
          onlocation(window.location);
      })
      .error(function(xhr){
          alert(xhr.responseText);
      });
 }
</script>
