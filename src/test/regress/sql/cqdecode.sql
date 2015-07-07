-- Decode all boolean literal types.

SET debug_sync_stream_insert = 'on';

CREATE CONTINUOUS VIEW test_bool AS SELECT b::boolean FROM cqdecode_stream;

ACTIVATE test_bool;

INSERT INTO cqdecode_stream (b) VALUES (TRUE), (true), ('true'), ('t'), ('y'), ('on'), ('1'::boolean), (1::boolean);
INSERT INTO cqdecode_stream (b) VALUES (FALSE), (false), ('false'), ('f'), ('n'), ('off'), ('0'::boolean), (0::boolean);

DEACTIVATE test_bool;

SELECT b, COUNT(*) FROM test_bool GROUP BY b;

DROP CONTINUOUS VIEW test_bool;