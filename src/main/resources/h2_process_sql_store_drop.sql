/** 
 * Drop indexes
 */
DROP INDEX IF EXISTS idx_av_instanceattributes;
DROP INDEX IF EXISTS idx_cases_appid;
DROP INDEX IF EXISTS idx_cases_status;
DROP INDEX IF EXISTS idx_cases_lockedby;
DROP INDEX IF EXISTS idx_customfield_tasks;
DROP INDEX IF EXISTS idx_customfield_name;
DROP INDEX IF EXISTS idx_events_case_task;
DROP INDEX IF EXISTS idx_delayedevents_event_case;
DROP INDEX IF EXISTS idx_ia_attributename;
DROP INDEX IF EXISTS idx_ia_instances;
DROP INDEX IF EXISTS idx_ia_aname_id_iid;
DROP INDEX IF EXISTS idx_instances_cases;
DROP INDEX IF EXISTS idx_instances_iname;
DROP INDEX IF EXISTS idx_instances_ename;
DROP INDEX IF EXISTS idx_instances_ename_id_cases;
DROP INDEX IF EXISTS idx_roles_tasks;
DROP INDEX IF EXISTS idx_tasks_type;
DROP INDEX IF EXISTS idx_tasks_lastcheck;
DROP INDEX IF EXISTS idx_tasks_cases;
DROP INDEX IF EXISTS idx_tasks_cases_type_status;
DROP INDEX IF EXISTS idx_tasks_cases_status_event;
DROP INDEX IF EXISTS idx_tasks_timeoutdate;
DROP INDEX IF EXISTS idx_tasks_status;
DROP INDEX IF EXISTS idx_tasks_parentid;
DROP INDEX IF EXISTS idx_tasks_nodeid;
DROP INDEX IF EXISTS idx_tasks_typestatus;
DROP INDEX IF EXISTS idx_teams_tasks;
DROP INDEX IF EXISTS idx_unauthorized_users_tasks;
DROP INDEX IF EXISTS idx_unauthorized_users_userid;
DROP INDEX IF EXISTS idx_users_tasks;
DROP INDEX IF EXISTS idx_av_valuetype;
DROP INDEX IF EXISTS idx_av_type;
DROP INDEX IF EXISTS idx_av_booleanvalue;
DROP INDEX IF EXISTS idx_av_currencyvalue;
DROP INDEX IF EXISTS idx_av_datetimevalue;
DROP INDEX IF EXISTS idx_av_datevalue;
DROP INDEX IF EXISTS idx_av_entityvalue;
DROP INDEX IF EXISTS idx_av_integervalue;
DROP INDEX IF EXISTS idx_av_numbervalue;
DROP INDEX IF EXISTS idx_av_percentagevalue;
DROP INDEX IF EXISTS idx_av_stringvalue;
DROP INDEX IF EXISTS idx_displaynames_cases;
DROP INDEX IF EXISTS idx_displaynames_tasks;

/** 
 * Drop foreign keys 
 */
ALTER TABLE attributevalues
  DROP CONSTRAINT IF EXISTS fk_av_instanceattributes; 
ALTER TABLE customfields 
  DROP CONSTRAINT IF EXISTS fk_customfields_tasks; 
ALTER TABLE delayedevents 
  DROP CONSTRAINT IF EXISTS fk_delayed_events; 
ALTER TABLE events 
  DROP CONSTRAINT IF EXISTS fk_events_cases; 
ALTER TABLE instanceattributes 
  DROP CONSTRAINT IF EXISTS fk_ia_instances; 
ALTER TABLE instances 
  DROP CONSTRAINT IF EXISTS fk_instances_cases; 
ALTER TABLE roles 
  DROP CONSTRAINT IF EXISTS fk_roles_tasks; 
ALTER TABLE tasks 
  DROP CONSTRAINT IF EXISTS fk_tasks_cases; 
ALTER TABLE teams 
  DROP CONSTRAINT IF EXISTS fk_teams_tasks; 
ALTER TABLE unauthorized_users 
  DROP CONSTRAINT IF EXISTS fk_unauthorized_users_tasks; 
ALTER TABLE users
  DROP CONSTRAINT IF EXISTS fk_users_tasks; 
ALTER TABLE cases_displaynames 
  DROP CONSTRAINT IF EXISTS fk_displaynames_cases; 
ALTER TABLE tasks_displaynames
  DROP CONSTRAINT IF EXISTS fk_displaynames_tasks; 

/** 
 * Drop sequences
 */
DROP SEQUENCE IF EXISTS s_process_releaseid;
DROP SEQUENCE IF EXISTS attributevalues_s;
DROP SEQUENCE IF EXISTS cases_s;
DROP SEQUENCE IF EXISTS delayed_events_s;
DROP SEQUENCE IF EXISTS events_s;
DROP SEQUENCE IF EXISTS instanceattributes_s;
DROP SEQUENCE IF EXISTS instances_s;
DROP SEQUENCE IF EXISTS roles_s;
DROP SEQUENCE IF EXISTS taskproperties_s;
DROP SEQUENCE IF EXISTS tasks_s;
DROP SEQUENCE IF EXISTS teams_s;
DROP SEQUENCE IF EXISTS unauthorized_users_s;
DROP SEQUENCE IF EXISTS users_s;
DROP SEQUENCE IF EXISTS casesdisplaynames_s;
DROP SEQUENCE IF EXISTS tasksdisplaynames_s;

/** 
 * Drop tables
 */
DROP TABLE IF EXISTS attributevalues; 
DROP TABLE IF EXISTS cases; 
DROP TABLE IF EXISTS customfields; 
DROP TABLE IF EXISTS delayedevents; 
DROP TABLE IF EXISTS events; 
DROP TABLE IF EXISTS instanceattributes; 
DROP TABLE IF EXISTS instances; 
DROP TABLE IF EXISTS process_releases; 
DROP TABLE IF EXISTS roles; 
DROP TABLE IF EXISTS tasks; 
DROP TABLE IF EXISTS teams; 
DROP TABLE IF EXISTS unauthorized_users; 
DROP TABLE IF EXISTS users; 
DROP TABLE IF EXISTS cases_displaynames; 
DROP TABLE IF EXISTS tasks_displaynames; 