CREATE PROCEDURE SWP_RaiseError (ErrNum int, ErrMsg varchar(255)) BEGIN
	set @SWV_Stmt = concat('select SWF_RaiseError('', ErrNum, ': ',ErrMsg,'')');
	prepare Stmt from @SWV_Stmt;
	execute Stmt;
	deallocate prepare Stmt;
END