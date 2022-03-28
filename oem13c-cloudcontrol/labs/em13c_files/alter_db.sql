-- This script is intended for classroom/demo environmnets only
-- It should be run on EM-monitored databases to ensure that
-- the moniotring password is standard and that logins never expire.
-- Note that if the database is not an EM repository 
-- the MGMT_ADMIN_USER_PROFILE
-- will not exist so the script correctly shows an error.
-- created by dhansell

set echo on
alter user dbsnmp identified by dbsnmp account unlock;
alter profile default limit password_life_time unlimited;
alter profile default limit PASSWORD_GRACE_TIME unlimited;
alter profile MGMT_ADMIN_USER_PROFILE limit password_life_time unlimited;
