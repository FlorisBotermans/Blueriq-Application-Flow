/**  
 * Drop foreign keys  
 */
ALTER TABLE comment_TitleText DROP CONSTRAINT IF EXISTS FK_CT_commentEntry;

/**
 * Drop indexes
 */
DROP INDEX IF EXISTS IDX_CT_commentEntry;
DROP INDEX IF EXISTS IDX_CE_ReferenceId;
DROP INDEX IF EXISTS IDX_CE_ApplicationId;
DROP INDEX IF EXISTS IDX_CE_UserId;
DROP INDEX IF EXISTS IDX_CE_Date;

/**  
 * Drop sequences
 */ 
DROP SEQUENCE IF EXISTS s_comment_releasesid; 
DROP SEQUENCE IF EXISTS s_comment_entryid; 
DROP SEQUENCE IF EXISTS s_comment_textid;

/**  
 * Drop tables
 */
DROP TABLE IF EXISTS comment_TitleText;
DROP TABLE IF EXISTS comment_Releases;
DROP TABLE IF EXISTS comment_Entries;
