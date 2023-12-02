#-- update the table
sqlplus -S /nolog >> /tmp/setup.log 2>&1 <<EOF
connect / as sysdba
alter session set container=orclpdb1;
UPDATE bar91.BARCOPY SET salary = salary+1;
COMMIT;

EOF
echo "Setup complete." >> /tmp/setup.log
