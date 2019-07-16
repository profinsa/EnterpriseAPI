CREATE FUNCTION ISNUMERIC (inputValue VARCHAR(50)) BEGIN
    IF (inputValue REGEXP ('^[0-9]+$'))
    THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END