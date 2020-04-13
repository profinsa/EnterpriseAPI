CREATE FUNCTION BankTransaction_Control (v_CompanyID NATIONAL VARCHAR(36), 
	v_DivisionID NATIONAL VARCHAR(36),
	v_DepartmentID NATIONAL VARCHAR(36),
	v_BankTransactionID NATIONAL VARCHAR(36)) BEGIN




















   DECLARE v_ReturnStatus SMALLINT;
   DECLARE v_ErrorMessage NATIONAL VARCHAR(200);
   DECLARE v_Success BOOLEAN;
   DECLARE v_DocumentTypeID NATIONAL VARCHAR(36);
   DECLARE v_Posted BOOLEAN;


   DECLARE v_ErrorID INT;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   BEGIN
      SET @SWV_Error = 1;
   END;
   select   TransactionType, Posted INTO v_DocumentTypeID,v_Posted FROM
   BankTransactions WHERE
   CompanyID = v_CompanyID AND
   DivisionID = v_DivisionID AND
   DepartmentID = v_DepartmentID AND
   BankTransactionID = v_BankTransactionID;

   IF v_Posted = 1 then

      RETURN 0;
   end if;

   IF LOWER(v_DocumentTypeID) = LOWER('Deposit') then


      SET @SWV_Error = 0;
      SET v_ReturnStatus = Bank_PostDeposit2(v_CompanyID,v_DivisionID,v_DepartmentID,v_BankTransactionID,v_Success);
	
      IF @SWV_Error <> 0 OR v_ReturnStatus = -1 OR v_Success <> 1 then
	
         SET v_ErrorMessage = 'Bank_PostDeposit call failed';
         CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'BankTransaction_Control',v_ErrorMessage,
         v_ErrorID);
         CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankTransactionID',
         v_BankTransactionID);
         RETURN -1;
      end if;
   ELSE 
      IF LOWER(v_DocumentTypeID) = LOWER('Transfer') then


         SET @SWV_Error = 0;
         CALL Bank_PostTransfer(v_CompanyID,v_DivisionID,v_DepartmentID,v_BankTransactionID,v_Success, v_ReturnStatus);
	
         IF @SWV_Error <> 0 OR v_ReturnStatus = -1 OR v_Success <> 1 then
	
            SET v_ErrorMessage = 'Bank_PostTransfer call failed';
            CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'BankTransaction_Control',v_ErrorMessage,
            v_ErrorID);
            CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankTransactionID',
            v_BankTransactionID);
            RETURN -1;
         end if;
      ELSE 
         IF LOWER(v_DocumentTypeID) = LOWER('Withdrawal') then


            SET @SWV_Error = 0;
            SET v_ReturnStatus = Bank_PostWithdrawal2(v_CompanyID,v_DivisionID,v_DepartmentID,v_BankTransactionID,v_Success);
	
            IF @SWV_Error <> 0 OR v_ReturnStatus = -1 OR v_Success <> 1 then
	
               SET v_ErrorMessage = 'Bank_PostWithdrawal call failed';
               CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'BankTransaction_Control',v_ErrorMessage,
               v_ErrorID);
               CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankTransactionID',
               v_BankTransactionID);
               RETURN -1;
            end if;
         ELSE 
            IF LOWER(v_DocumentTypeID) = LOWER('Adjustment') then


               SET @SWV_Error = 0;
               SET v_ReturnStatus = Bank_PostAdjustment2(v_CompanyID,v_DivisionID,v_DepartmentID,v_BankTransactionID,v_Success);
	
               IF @SWV_Error <> 0 OR v_ReturnStatus = -1 OR v_Success <> 1 then
	
                  SET v_ErrorMessage = 'Bank_PostAdjustment call failed';
                  CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'BankTransaction_Control',v_ErrorMessage,
                  v_ErrorID);
                  CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankTransactionID',
                  v_BankTransactionID);
                  RETURN -1;
               end if;
            ELSE 
               IF LOWER(v_DocumentTypeID) = LOWER('Service Fee') then


                  SET @SWV_Error = 0;
                  SET v_ReturnStatus = Bank_PostServiceFee2(v_CompanyID,v_DivisionID,v_DepartmentID,v_BankTransactionID,v_Success);
	
                  IF @SWV_Error <> 0 OR v_ReturnStatus = -1 OR v_Success <> 1 then
	
                     SET v_ErrorMessage = 'Bank_PostServiceFee call failed';
                     CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'BankTransaction_Control',v_ErrorMessage,
                     v_ErrorID);
                     CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankTransactionID',
                     v_BankTransactionID);
                     RETURN -1;
                  end if;
               ELSE 
                  IF LOWER(v_DocumentTypeID) = LOWER('Check') then


                     SET @SWV_Error = 0;
                     SET v_ReturnStatus = Bank_PostCheck2(v_CompanyID,v_DivisionID,v_DepartmentID,v_BankTransactionID,v_Success);
	
                     IF @SWV_Error <> 0 OR v_ReturnStatus = -1 OR v_Success <> 1 then
	
                        SET v_ErrorMessage = 'Bank_PostCheck call failed';
                        CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'BankTransaction_Control',v_ErrorMessage,
                        v_ErrorID);
                        CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankTransactionID',
                        v_BankTransactionID);
                        RETURN -1;
                     end if;
                  ELSE 
                     IF LOWER(v_DocumentTypeID) = LOWER('Outbound Wire') then


                        SET @SWV_Error = 0;
                        SET v_ReturnStatus = Bank_PostOutboundWire2(v_CompanyID,v_DivisionID,v_DepartmentID,v_BankTransactionID,v_Success);
	
                        IF @SWV_Error <> 0 OR v_ReturnStatus = -1 OR v_Success <> 1 then
	
                           SET v_ErrorMessage = 'Bank_PostOutboundWire call failed';
                           CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'BankTransaction_Control',v_ErrorMessage,
                           v_ErrorID);
                           CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankTransactionID',
                           v_BankTransactionID);
                           RETURN -1;
                        end if;
                     ELSE 
                        IF LOWER(v_DocumentTypeID) = LOWER('Inbound Wire') then


                           SET @SWV_Error = 0;
                           SET v_ReturnStatus = Bank_PostInboundWire2(v_CompanyID,v_DivisionID,v_DepartmentID,v_BankTransactionID,v_Success);
	
                           IF @SWV_Error <> 0 OR v_ReturnStatus = -1 OR v_Success <> 1 then
	
                              SET v_ErrorMessage = 'Bank_PostInboundWire call failed';
                              CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'BankTransaction_Control',v_ErrorMessage,
                              v_ErrorID);
                              CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankTransactionID',
                              v_BankTransactionID);
                              RETURN -1;
                           end if;
                        ELSE
                           SET @SWV_Error = 0;
                           SET v_ReturnStatus = Bank_PostDeposit2(v_CompanyID,v_DivisionID,v_DepartmentID,v_BankTransactionID,v_Success);
	
                           IF @SWV_Error <> 0 OR v_ReturnStatus = -1 OR v_Success <> 1 then
	
                              SET v_ErrorMessage = 'Bank_PostDeposit call failed';
                              CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'BankTransaction_Control',v_ErrorMessage,
                              v_ErrorID);
                              CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankTransactionID',
                              v_BankTransactionID);
                              RETURN -1;
                           end if;
                        end if;
                     end if;
                  end if;
               end if;
            end if;
         end if;
      end if;
   end if;



   RETURN 0;









   CALL Error_InsertError(v_CompanyID,v_DivisionID,v_DepartmentID,'BankTransaction_Control',v_ErrorMessage,
   v_ErrorID);

   CALL Error_InsertErrorDetail(v_CompanyID,v_DivisionID,v_DepartmentID,v_ErrorID,'BankTransactionID',
   v_BankTransactionID);

   RETURN -1;
END