/* Basic stream of input values to work with */
CREATE STREAM input (value STRING)
    WITH (KAFKA_TOPIC='input', VALUE_FORMAT='DELIMITED', key='ROWTIME');

/* Stream with every input value an human readable timestamp */
CREATE STREAM input_with_readable_timestamp AS
    SELECT TIMESTAMPTOSTRING(ROWTIME, 'yyyy-MM-dd HH:mm:ss') ,ROWKEY, value FROM input;

/* Table to see the the number of messages per sensor in one Minute */
CREATE TABLE data_sensor_per_min AS
    SELECT ROWKEY, count(*) FROM INPUT
        WINDOW TUMBLING (SIZE 60 SECONDS)
        GROUP BY ROWKEY;

/* Get a stream with Timestamp and value */
/* Timestamp is used in windowed aggr */
create stream inputStream (timestamp BIGINT, valueinw DOUBLE) with (KAFKA_TOPIC='input', VALUE_FORMAT='AVRO', TIMESTAMP='timestamp');

/*
Name                 : INPUTSTREAM
 Field     | Type                       
---------------------------------------
 ROWTIME   | BIGINT           (system) 
 ROWKEY    | VARCHAR(STRING)  (system) 
 TIMESTAMP | BIGINT                     
 VALUEINW  | DOUBLE                     
---------------------------------------
*/

CREATE TABLE avg_power_per_device_6h AS
    SELECT ROWKEY,
           TIMESTAMPTOSTRING(windowstart(), 'yyyy-MM-dd HH:mm:ss') AS window_start,
           TIMESTAMPTOSTRING(windowend(), 'yyyy-MM-dd HH:mm:ss') AS window_end,
           sum(valueinw) / count(valueinw) AS avg
    FROM inputstream
    WINDOW TUMBLING (SIZE 6 HOURS) GROUP BY ROWKEY;
/*
Name                 : AVG_POWER_PER_DEVICE_6H
 Field        | Type                      
------------------------------------------
 ROWTIME      | BIGINT           (system) 
 ROWKEY       | VARCHAR(STRING)  (system) 
 WINDOW_START | VARCHAR(STRING)           
 WINDOW_END   | VARCHAR(STRING)           
 AVG          | DOUBLE                    
------------------------------------------
*/
select * from avg_power_per_device_6h
    where ((window_start LIKE '%00:00:00') AND
        (CHECKDATE(STRINGTOTIMESTAMP(window_start, 'yyyy-MM-dd HH:mm:ss'), 'SATURDAY') LIKE 'T%'))
    limit 20;
