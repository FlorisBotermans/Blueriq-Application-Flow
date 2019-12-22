/**
 * Create Tables
 */
CREATE TABLE reports
  (
     id                 NUMERIC(19, 0) IDENTITY NOT NULL,
     source_application NVARCHAR(255) NOT NULL,
     export_xml         NVARCHAR(max) NOT NULL,
     source_service     NVARCHAR(255) NOT NULL,
     creation_datetime  DATETIME2 NOT NULL,
     user_name          NVARCHAR(255),
	 
     CONSTRAINT pk_reports PRIMARY KEY (id)
  );

CREATE TABLE reports_releases
  (
     id          NUMERIC(19, 0) IDENTITY NOT NULL,
     description NVARCHAR(150) NULL,
     releasedate DATETIME2 NOT NULL,
     version     NVARCHAR(100) NOT NULL,
	 
     CONSTRAINT pk_reports_releases PRIMARY KEY (id)
  );

/** 
 * Insert release record 
 */
INSERT INTO reports_releases
            (version,
             releasedate,
             description)
VALUES     ('10.0.0',
            CURRENT_TIMESTAMP,
            'Initial creation');
