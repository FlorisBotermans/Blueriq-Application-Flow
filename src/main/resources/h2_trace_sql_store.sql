/** 
 * Create Tables 
 */ 
CREATE TABLE trace_entries
  (
     id            BIGINT AUTO_INCREMENT NOT NULL,
     applicationid NVARCHAR(100) NOT NULL,
     tracedate     DATETIME2,
     type          NVARCHAR(100) NOT NULL,
	 
	CONSTRAINT pk_trace_entries PRIMARY KEY (
		id
	)
  );

CREATE TABLE trace_properties
  (
     id           BIGINT AUTO_INCREMENT NOT NULL,
     name         NVARCHAR(100) NOT NULL,
     traceentryid BIGINT,
	 
	CONSTRAINT pk_trace_properties PRIMARY KEY (
		id
	)
  );

CREATE TABLE trace_propertyvalues
  (
     valuetype            VARCHAR(31) NOT NULL,
     id                   BIGINT AUTO_INCREMENT NOT NULL,
     type                 NVARCHAR(255),
     booleanvalue         INT,
     currencyvalue        FLOAT,
     datetimevalue        DATETIME2,
     datevalue            DATETIME2,
     entityvalue          NVARCHAR(255),
     integervalue         BIGINT,
     numbervalue          FLOAT,
     percentagevalue      FLOAT,
     stringvalue          NVARCHAR(255),
     binaryvalue          BLOB,
     traceentrypropertyid BIGINT,
	 
	CONSTRAINT pk_trace_propertyvalues PRIMARY KEY (
		id
	)
  );

CREATE TABLE trace_timeline
  (
     id            BIGINT AUTO_INCREMENT NOT NULL,
     action        NVARCHAR(100),
     caseid        BIGINT,
     name          NVARCHAR(100),
     tracedate     DATETIME2,
     type          NVARCHAR(100),
     typeid        NVARCHAR(255),
     userid        NVARCHAR(100),
     username      NVARCHAR(100),
     applicationid NVARCHAR(255),
	 
	CONSTRAINT pk_trace_timeline PRIMARY KEY (
		id
	)
  );


CREATE TABLE trace_displaynamevalues
  (
     id           BIGINT AUTO_INCREMENT NOT NULL,
     displayname  NVARCHAR(255) NOT NULL,
     languagecode NVARCHAR(19) NOT NULL,
     timelineid   BIGINT,
	 
	CONSTRAINT pk_trace_displaynamevalues PRIMARY KEY (
		id
	)
  );


CREATE TABLE trace_releases
  (
     id          BIGINT AUTO_INCREMENT NOT NULL,
     description NVARCHAR(150),
     releasedate DATETIME2 NOT NULL,
     version     NVARCHAR(100) NOT NULL,
	 
	CONSTRAINT pk_trace_releases PRIMARY KEY (
		id
	)
  );

/** 
 * Create sequences 
 */
CREATE SEQUENCE s_trace_entryid START WITH 1 INCREMENT BY 1 MINVALUE 0;

CREATE SEQUENCE s_trace_propertyid START WITH 1 INCREMENT BY 1 MINVALUE 0;

CREATE SEQUENCE s_trace_propertyvalueid START WITH 1 INCREMENT BY 1 MINVALUE 0;

CREATE SEQUENCE s_trace_timeline START WITH 1 INCREMENT BY 1 MINVALUE 0;

CREATE SEQUENCE s_trace_displaynamevalues START WITH 1 INCREMENT BY 1 MINVALUE 0;

CREATE SEQUENCE s_trace_releaseid START WITH 1 INCREMENT BY 1 MINVALUE 0;

/**  
 * Create foreign keys  
 */ 
ALTER TABLE trace_properties
  ADD CONSTRAINT fk_ep_traceentry FOREIGN KEY (traceentryid) REFERENCES
  trace_entries;

ALTER TABLE trace_propertyvalues
  ADD CONSTRAINT fk_pv_traceentryproperty FOREIGN KEY (traceentrypropertyid) REFERENCES 
  trace_properties;

ALTER TABLE trace_displaynamevalues
  ADD CONSTRAINT fk_timeline_dnv FOREIGN KEY (timelineid) REFERENCES
  trace_timeline ON DELETE CASCADE;

/**  
 * Create indexes  
 */ 
CREATE INDEX idx_traceentrytracedate
  ON trace_entries (tracedate);

CREATE INDEX idx_traceentrytype
  ON trace_entries (type);
  
CREATE INDEX idx_traceentrypropertyname
  ON trace_properties (name);

CREATE INDEX idx_ep_traceentry
  ON trace_properties (traceentryid);

CREATE INDEX idx_pv_traceentryproperty
  ON trace_propertyvalues (traceentrypropertyid);

CREATE INDEX idx_timelineentrytype
  ON trace_timeline (type);

CREATE INDEX idx_timelineentrytracedate
  ON trace_timeline (tracedate);

CREATE INDEX idx_timelineentrycaseid
  ON trace_timeline (caseid);
  
CREATE INDEX idx_timelineentry_type_cid_aid 
  ON trace_timeline (type, caseid, applicationid);  

/** 
 * Insert release record 
 */
INSERT INTO trace_releases
            (id,
			 version,
             releasedate,
             description)
VALUES     (NEXT VALUE FOR s_trace_releaseid,
			'10.0.0',
            CURRENT_TIMESTAMP,
            'Initial creation');
