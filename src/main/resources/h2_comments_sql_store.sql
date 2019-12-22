/** 
 * Create Tables 
 */ 
CREATE TABLE comment_Entries
  (
     id            BIGINT AUTO_INCREMENT NOT NULL,
     applicationId NVARCHAR2(100) NOT NULL,
     commentText   NCLOB NOT NULL,
     insertionDate TIMESTAMP NOT NULL,
     referenceId   NVARCHAR2(100) NOT NULL,
     userId        NVARCHAR2(50) NOT NULL,
	 CONSTRAINT pk_comment_entries PRIMARY KEY (id)
  );

CREATE TABLE comment_Releases
  (
     id          BIGINT AUTO_INCREMENT NOT NULL,
     description NVARCHAR2(150),
     releaseDate TIMESTAMP NOT NULL,
     version     NVARCHAR2(100) NOT NULL,
 	 CONSTRAINT pk_comment_releases PRIMARY KEY (id)
  );

CREATE TABLE comment_TitleText
  (
     id             BIGINT AUTO_INCREMENT NOT NULL,
     languageCode   NVARCHAR2(50),
     value          NVARCHAR2(100) NOT NULL,
     commentEntryId BIGINT,
 	 CONSTRAINT pk_comment_titletext PRIMARY KEY (id)
  );

/** 
 * Create sequences 
 */
CREATE SEQUENCE s_comment_textid START WITH 1 INCREMENT BY 1 MINVALUE 0;

CREATE SEQUENCE s_comment_entryid START WITH 1 INCREMENT BY 1 MINVALUE 0;

CREATE SEQUENCE s_comment_releasesid START WITH 1 INCREMENT BY 1 MINVALUE 0;

/**  
 * Create indexes  
 */ 
CREATE INDEX IDX_CE_Date
  ON comment_Entries (insertionDate);

CREATE INDEX IDX_CE_UserId
  ON comment_Entries (userId);

CREATE INDEX IDX_CE_ApplicationId
  ON comment_Entries (applicationId);

CREATE INDEX IDX_CE_ReferenceId
  ON comment_Entries (referenceId);

CREATE INDEX IDX_CT_commentEntry
  ON comment_TitleText (commentEntryId);

/**  
 * Create foreign keys  
 */ 
ALTER TABLE comment_TitleText
  ADD CONSTRAINT FK_CT_commentEntry FOREIGN KEY (commentEntryId) REFERENCES
  comment_Entries;

/** 
 * Insert release record 
 */
INSERT INTO comment_Releases
            (id,
             version,
             releasedate,
             description)
VALUES      (NEXT VALUE FOR s_comment_releasesid,
             '10.0.0',
             CURRENT_TIMESTAMP(),
             'Initial creation');
