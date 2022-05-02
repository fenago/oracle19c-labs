
/* ================================================  
 * Oracle XFiles Demonstration.  
 *    
 * Copyright (c) 2014 Oracle and/or its affiliates.  All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * ================================================
 */

--
set define off
--
-- Release specific scritps
--
var XDBPM_ZIP_SUPPORT VARCHAR2(120)
--
declare
  V_XDBPM_ZIP_SUPPORT VARCHAR2(120);
begin
$IF DBMS_DB_VERSION.VER_LE_10_2 $THEN
  V_XDBPM_ZIP_SUPPORT := 'XDBPM_DO_NOTHING.sql';
$ELSE
  V_XDBPM_ZIP_SUPPORT := 'XDBPM_ZIP_SUPPORT_11100.sql';
$END
  :XDBPM_ZIP_SUPPORT := V_XDBPM_ZIP_SUPPORT;
end;
/
undef XDBPM_ZIP_SUPPORT
--
column XDBPM_ZIP_SUPPORT new_value XDBPM_ZIP_SUPPORT
--
select :XDBPM_ZIP_SUPPORT XDBPM_ZIP_SUPPORT 
  from dual
/
select '&XDBPM_ZIP_SUPPORT'
  from DUAL
/
set define on
--
@@&XDBPM_ZIP_SUPPORT
--
