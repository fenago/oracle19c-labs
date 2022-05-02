
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
declare
  V_SOURCE_FOLDER varchar2(700) := XFILES_CONSTANTS.FOLDER_HOME || '/src/WebDemo';
  V_TARGET_FOLDER varchar2(700) := XFILES_CONSTANTS.FOLDER_ROOT || '/WebDemo';
  V_RESULT        boolean;
begin 
  if dbms_xdb.existsResource(V_TARGET_FOLDER) then
    dbms_xdb.deleteResource(V_TARGET_FOLDER,DBMS_XDB.DELETE_RECURSIVE_FORCE);
  end if;

  V_RESULT := dbms_xdb.createFolder(V_TARGET_FOLDER);
  dbms_xdb.link(V_SOURCE_FOLDER || '/xsl',V_TARGET_FOLDER,'xsl',DBMS_XDB.LINK_TYPE_WEAK);
  dbms_xdb.link(V_SOURCE_FOLDER || '/runtime.html',V_TARGET_FOLDER,'runtime.html',DBMS_XDB.LINK_TYPE_WEAK);
  
end;
/
  
