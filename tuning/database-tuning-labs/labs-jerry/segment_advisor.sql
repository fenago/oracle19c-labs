SET SERVEROUTPUT ON SIZE 1000000
SET LINESIZE 200
SET VERIFY OFF

DECLARE
  l_object_id     NUMBER;
  l_task_name     VARCHAR2(32767) := 'SEGMENT_ADVISOR_TASK';
  l_object_type   VARCHAR2(32767) := UPPER('&1');
  l_attr1         VARCHAR2(32767) := UPPER('&2');
  l_attr2         VARCHAR2(32767) := UPPER('&3');
BEGIN
  IF l_attr2 = 'NULL' THEN
    l_attr2 := NULL;
  END IF;

  DBMS_ADVISOR.create_task (
    advisor_name      => 'Segment Advisor',
    task_name         => l_task_name);

  DBMS_ADVISOR.create_object (
    task_name   => l_task_name,
    object_type => l_object_type,
    attr1       => l_attr1,
    attr2       => l_attr2,
    attr3       => NULL,
    attr4       => 'null',
    attr5       => NULL,
    object_id   => l_object_id);

  DBMS_ADVISOR.set_task_parameter (
    task_name => l_task_name,
    parameter => 'RECOMMEND_ALL',
    value     => 'TRUE');

  DBMS_ADVISOR.execute_task(task_name => l_task_name);

