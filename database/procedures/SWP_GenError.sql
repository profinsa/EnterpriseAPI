CREATE PROCEDURE SWP_GenError (_Message VARCHAR(128)) BEGIN
   INSERT INTO SWT_GenError (Error_Message) VALUES (_Message);
   INSERT INTO SWT_GenError (Error_Message) VALUES (_Message);
END