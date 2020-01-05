/* Basic stream of input values to work with */
CREATE STREAM input (value STRING) WITH (KAFKA_TOPIC='input', VALUE_FORMAT='DELIMITED', key='ROWTIME');

/* Stream with every input value an human readable timestamp */
CREATE STREAM input_with_readable_timestamp AS SELECT TIMESTAMPTOSTRING(ROWTIME, 'yyyy-MM-dd HH:mm:ss') ,ROWKEY, value FROM input;

/* Table to see the the number of messages per sensor in one Minute */
CREATE TABLE data_sensor_per_min AS SELECT ROWKEY, count(*) FROM INPUT WINDOW TUMBLING (SIZE 60 SECONDS) GROUP BY ROWKEY;
