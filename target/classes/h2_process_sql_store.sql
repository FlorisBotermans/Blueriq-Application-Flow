/**
 * Create Tables
 */
CREATE TABLE attributevalues
  (
     valuetype           VARCHAR(31) NOT NULL,
     id                  BIGINT AUTO_INCREMENT NOT NULL,
     type                NVARCHAR(255),
     booleanvalue        INT,
     currencyvalue       FLOAT,
     datetimevalue       DATETIME2,
     datevalue           DATETIME2,
     entityvalue         NVARCHAR(255),
     integervalue        BIGINT,
     numbervalue         FLOAT,
     percentagevalue     FLOAT,
     stringvalue         NVARCHAR(255),
     instanceattributeid BIGINT,

     CONSTRAINT pk_attributevalues PRIMARY KEY ( id )
  );

CREATE TABLE cases
  (
     id            BIGINT AUTO_INCREMENT NOT NULL,
     applicationid NVARCHAR(100),
     creationdate  DATETIME2,
     lockedby      NVARCHAR(50),
     name          NVARCHAR(100),
     status        NVARCHAR(6),

     CONSTRAINT pk_cases PRIMARY KEY ( id )
  );

CREATE TABLE customfields
  (
     id     BIGINT AUTO_INCREMENT NOT NULL,
     name   NVARCHAR(255),
     value  NVARCHAR(255),
     taskid BIGINT NOT NULL,

     CONSTRAINT pk_customfields PRIMARY KEY ( id )
  );

CREATE TABLE delayedevents
  (
     id      BIGINT AUTO_INCREMENT NOT NULL,
     caseid  BIGINT NOT NULL,
     eventid BIGINT NOT NULL,

     CONSTRAINT pk_delayedevents PRIMARY KEY ( id )
  );

CREATE TABLE events
  (
     id              BIGINT AUTO_INCREMENT NOT NULL,
     applicationid   NVARCHAR(255),
     content         NCLOB,
     name            NVARCHAR(255) NOT NULL,
     replayedeventid BIGINT,
     status          NVARCHAR(10) NOT NULL,
     taskid          BIGINT,
     timestamp       DATETIME2,
     type            NVARCHAR(7) NOT NULL,
     username        NVARCHAR(255),
     caseid          BIGINT,

     CONSTRAINT pk_events PRIMARY KEY ( id )
  );

CREATE TABLE instanceattributes
  (
     id            BIGINT AUTO_INCREMENT NOT NULL,
     attributename NVARCHAR(100),
     instanceid    BIGINT,

     CONSTRAINT pk_instanceattributes PRIMARY KEY ( id )
  );

CREATE TABLE instances
  (
     id           BIGINT AUTO_INCREMENT NOT NULL,
     entityname   NVARCHAR(50),
     instanceid   NVARCHAR(100),
     instancename NVARCHAR(100),
     caseid       BIGINT,

     CONSTRAINT pk_instances PRIMARY KEY ( id )
  );

CREATE TABLE process_releases
  (
     id          BIGINT AUTO_INCREMENT NOT NULL,
     description NVARCHAR(150),
     releasedate DATETIME2 NOT NULL,
     version     NVARCHAR(100) NOT NULL,

     CONSTRAINT pk_process_releases PRIMARY KEY ( id )
  );

CREATE TABLE roles
  (
     id     BIGINT AUTO_INCREMENT NOT NULL,
     role   NVARCHAR(255),
     taskid BIGINT,

     CONSTRAINT pk_roles PRIMARY KEY ( id )
  );

CREATE TABLE tasks
  (
     id                BIGINT AUTO_INCREMENT NOT NULL,
     conditional       INT NOT NULL,
     duedate           DATETIME2,
     eventname         NVARCHAR(255),
     executedby        NVARCHAR(255),
     exitstate         NVARCHAR(255),
     isrequired        INT NOT NULL,
     isuserset         INT NOT NULL,
     lastprioritycheck DATETIME2,
     name              NVARCHAR(255),
     nodeid            NVARCHAR(100),
     parentid          BIGINT,
     priority          INT,
     startdate         DATETIME2,
     status            NVARCHAR(10) NOT NULL,
     timeoutdate       DATETIME2,
     type              NVARCHAR(10) NOT NULL,
     caseid            BIGINT,

     CONSTRAINT pk_tasks PRIMARY KEY ( id )
  );

CREATE TABLE teams
  (
     id     BIGINT AUTO_INCREMENT NOT NULL,
     team   NVARCHAR(255),
     taskid BIGINT,

     CONSTRAINT pk_teams PRIMARY KEY ( id )
  );

CREATE TABLE unauthorized_users
  (
     id     BIGINT AUTO_INCREMENT NOT NULL,
     userid NVARCHAR(255),
     taskid BIGINT NOT NULL,

     CONSTRAINT pk_unauthorized_users PRIMARY KEY ( id )
  );

CREATE TABLE users
  (
     id       BIGINT AUTO_INCREMENT NOT NULL,
     username NVARCHAR(255),
     taskid   BIGINT NOT NULL,

     CONSTRAINT pk_users PRIMARY KEY ( id )
  );

CREATE TABLE cases_displaynames
  (
     id          BIGINT AUTO_INCREMENT NOT NULL,
     displayname NVARCHAR(255),
     language    NVARCHAR(20),
     caseid      BIGINT,

     CONSTRAINT pk_cases_displaynames PRIMARY KEY ( id )
  );

CREATE TABLE tasks_displaynames
  (
     id          BIGINT AUTO_INCREMENT NOT NULL,
     displayname NVARCHAR(255),
     language    NVARCHAR(20),
     taskid      BIGINT,

     CONSTRAINT pk_tasks_displaynames PRIMARY KEY ( id )
  );

/** 
 * Create sequences 
 */
CREATE SEQUENCE s_process_releaseid START WITH 1 INCREMENT BY 1 MINVALUE 0;
 
CREATE SEQUENCE attributevalues_s START WITH 1 INCREMENT BY 1 MINVALUE 0;

CREATE SEQUENCE cases_s START WITH 1 INCREMENT BY 1 MINVALUE 0;

CREATE SEQUENCE delayed_events_s START WITH 1 INCREMENT BY 1 MINVALUE 0;

CREATE SEQUENCE events_s START WITH 1 INCREMENT BY 1 MINVALUE 0; 

CREATE SEQUENCE instanceattributes_s START WITH 1 INCREMENT BY 1 MINVALUE 0;

CREATE SEQUENCE instances_s START WITH 1 INCREMENT BY 1 MINVALUE 0; 

CREATE SEQUENCE roles_s START WITH 1 INCREMENT BY 1 MINVALUE 0;

CREATE SEQUENCE taskproperties_s START WITH 1 INCREMENT BY 1 MINVALUE 0; 

CREATE SEQUENCE tasks_s START WITH 1 INCREMENT BY 1 MINVALUE 0;

CREATE SEQUENCE teams_s START WITH 1 INCREMENT BY 1 MINVALUE 0; 

CREATE SEQUENCE unauthorized_users_s START WITH 1 INCREMENT BY 1 MINVALUE 0;

CREATE SEQUENCE users_s START WITH 1 INCREMENT BY 1 MINVALUE 0; 

CREATE SEQUENCE casesdisplaynames_s START WITH 1 INCREMENT BY 1 MINVALUE 0;

CREATE SEQUENCE tasksdisplaynames_s START WITH 1 INCREMENT BY 1 MINVALUE 0; 

/** 
 * Create foreign keys 
 */
ALTER TABLE attributevalues
  ADD CONSTRAINT fk_av_instanceattributes FOREIGN KEY ( instanceattributeid
  ) REFERENCES instanceattributes;

ALTER TABLE customfields
  ADD CONSTRAINT fk_customfields_tasks FOREIGN KEY ( taskid ) REFERENCES
  tasks;

ALTER TABLE delayedevents
  ADD CONSTRAINT fk_delayed_events FOREIGN KEY ( eventid ) REFERENCES
  events;

ALTER TABLE events
  ADD CONSTRAINT fk_events_cases FOREIGN KEY ( caseid ) REFERENCES cases;

ALTER TABLE instanceattributes
  ADD CONSTRAINT fk_ia_instances FOREIGN KEY ( instanceid ) REFERENCES
  instances;

ALTER TABLE instances
  ADD CONSTRAINT fk_instances_cases FOREIGN KEY ( caseid ) REFERENCES
  cases;

ALTER TABLE roles
  ADD CONSTRAINT fk_roles_tasks FOREIGN KEY ( taskid ) REFERENCES tasks;

ALTER TABLE tasks
  ADD CONSTRAINT fk_tasks_cases FOREIGN KEY ( caseid ) REFERENCES cases;

ALTER TABLE teams
  ADD CONSTRAINT fk_teams_tasks FOREIGN KEY ( taskid ) REFERENCES tasks;

ALTER TABLE unauthorized_users
  ADD CONSTRAINT fk_unauthorized_users_tasks FOREIGN KEY ( taskid )
  REFERENCES tasks;

ALTER TABLE users
  ADD CONSTRAINT fk_users_tasks FOREIGN KEY ( taskid ) REFERENCES tasks;

ALTER TABLE cases_displaynames
  ADD CONSTRAINT fk_displaynames_cases FOREIGN KEY ( caseid ) REFERENCES
  cases;

ALTER TABLE tasks_displaynames
  ADD CONSTRAINT fk_displaynames_tasks FOREIGN KEY ( taskid ) REFERENCES
  tasks;

/** 
 * Create indexes 
 */
CREATE INDEX idx_av_instanceattributes
  ON attributevalues ( instanceattributeid );

CREATE INDEX idx_cases_appid
  ON cases ( applicationid );

CREATE INDEX idx_cases_status
  ON cases ( status );

CREATE INDEX idx_cases_lockedby
  ON cases ( lockedby );

CREATE INDEX idx_customfield_tasks
  ON customFields ( taskid );

CREATE INDEX idx_customfield_name
  ON customFields ( name );

CREATE INDEX idx_events_case_task
  ON events ( caseid, taskid );

CREATE INDEX idx_delayedevents_event_case
  ON delayedevents ( eventid, caseid );

CREATE INDEX idx_ia_attributename
  ON instanceattributes ( attributename );

CREATE INDEX idx_ia_instances
  ON instanceattributes ( instanceid );

CREATE INDEX idx_ia_aname_id_iid
  ON instanceattributes ( attributename, id, instanceid );
  
CREATE INDEX idx_instances_cases
  ON instances ( caseid );

CREATE INDEX idx_instances_iname
  ON instances ( instancename );

CREATE INDEX idx_instances_ename
  ON instances ( entityname );

CREATE INDEX idx_instances_ename_id_cases
  ON instances ( entityname, id, caseid );
  
CREATE INDEX idx_roles_tasks
  ON roles ( taskid, role );

CREATE INDEX idx_tasks_type
  ON tasks ( type );

CREATE INDEX idx_tasks_lastcheck
  ON tasks ( lastprioritycheck );

CREATE INDEX idx_tasks_cases
  ON tasks ( caseid );

CREATE INDEX idx_tasks_cases_type_status
  ON tasks ( caseid, type, status );
  
CREATE INDEX idx_tasks_cases_status_event
  ON tasks ( caseid, status, eventname );

CREATE INDEX idx_tasks_timeoutdate
  ON tasks ( timeoutdate );

CREATE INDEX idx_tasks_status
  ON tasks ( status );


CREATE INDEX idx_tasks_parentid
  ON tasks ( parentid );

CREATE INDEX idx_tasks_nodeid
  ON tasks ( nodeid );
  
CREATE INDEX idx_tasks_typestatus
  ON tasks ( type, status );
  
CREATE INDEX idx_teams_tasks
  ON teams ( taskid, team );

CREATE INDEX idx_unauthorized_users_tasks
  ON unauthorized_users ( taskid, userid );
  
CREATE INDEX idx_unauthorized_users_userid
  ON unauthorized_users ( userid );

CREATE INDEX idx_users_tasks
  ON users ( taskid, username );

CREATE INDEX idx_av_valuetype
  ON attributevalues ( valuetype );

CREATE INDEX idx_av_type
  ON attributevalues ( type );

CREATE INDEX idx_av_booleanvalue
  ON attributevalues ( booleanvalue );

CREATE INDEX idx_av_currencyvalue
  ON attributevalues ( currencyvalue );

CREATE INDEX idx_av_datetimevalue
  ON attributevalues ( datetimevalue );

CREATE INDEX idx_av_datevalue
  ON attributevalues ( datevalue );

CREATE INDEX idx_av_entityvalue
  ON attributevalues ( entityvalue );

CREATE INDEX idx_av_integervalue
  ON attributevalues ( integervalue );

CREATE INDEX idx_av_numbervalue
  ON attributevalues ( numbervalue );

CREATE INDEX idx_av_percentagevalue
  ON attributevalues ( percentagevalue );

CREATE INDEX idx_av_stringvalue
  ON attributevalues ( stringvalue );

CREATE INDEX idx_displaynames_cases
  ON cases_displaynames ( caseid );

CREATE INDEX idx_displaynames_tasks
  ON tasks_displaynames ( taskid );

/** 
 * Insert release record 
 */
INSERT INTO process_releases
            (id, 
			 version,
             releasedate,
             description)
VALUES      ( NEXT VALUE FOR s_process_releaseid,
			  '10.0.0',
              CURRENT_TIMESTAMP,
              'Initial creation' );
