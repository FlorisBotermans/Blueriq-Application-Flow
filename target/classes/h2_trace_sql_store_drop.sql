/**   
 * Drop indexes  
 */ 
DROP INDEX IF EXISTS idx_traceentrytracedate;
DROP INDEX IF EXISTS idx_traceentrytype;
DROP INDEX IF EXISTS idx_traceentrypropertyname;
DROP INDEX IF EXISTS idx_ep_traceentry;
DROP INDEX IF EXISTS idx_pv_traceentryproperty;
DROP INDEX IF EXISTS idx_timelineentrytype;
DROP INDEX IF EXISTS idx_timelineentrytracedate;
DROP INDEX IF EXISTS idx_timelineentrycaseid;

/**   
 * Drop foreign keys   
 */ 
ALTER TABLE trace_properties 
    DROP CONSTRAINT IF EXISTS fk_ep_traceentry; 

ALTER TABLE trace_propertyvalues 
    DROP CONSTRAINT IF EXISTS fk_pv_traceentryproperty; 

ALTER TABLE trace_displaynamevalues 
    DROP CONSTRAINT IF EXISTS fk_timeline_dnv; 

/**   
 * Drop sequences  
 */ 
DROP SEQUENCE IF EXISTS s_trace_entryid; 
DROP SEQUENCE IF EXISTS s_trace_propertyid; 
DROP SEQUENCE IF EXISTS s_trace_propertyvalueid; 
DROP SEQUENCE IF EXISTS s_trace_timeline; 
DROP SEQUENCE IF EXISTS s_trace_displaynamevalues; 
DROP SEQUENCE IF EXISTS s_trace_releaseid; 

/**   
 * Drop tables  
 */ 
DROP TABLE IF EXISTS trace_entries; 
DROP TABLE IF EXISTS trace_properties; 
DROP TABLE IF EXISTS trace_propertyvalues; 
DROP TABLE IF EXISTS trace_displaynamevalues; 
DROP TABLE IF EXISTS trace_timeline; 
DROP TABLE IF EXISTS trace_releases; 