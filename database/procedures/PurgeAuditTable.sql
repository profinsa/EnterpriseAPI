CREATE PROCEDURE PurgeAuditTable () Begin
   Truncate Table AuditLogin;
   Truncate Table AuditLoginHistory;
   Truncate Table AuditTrail;
   Truncate Table AuditTrailHistory;
End