set echo on

exec dbms_stats.publish_pending_stats('stats','tabjfv');

@ show_public_stats TABJFV

@ show_pending_stats TABJFV

