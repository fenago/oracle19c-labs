DECLARE
FUNCTION HELLO RETURN VARCHAR2 IS
BEGIN
RETURN 'WORLD';
END;
BEGIN
DBMS_OUTPUT.PUT_LINE(HELLO);
END;
/
