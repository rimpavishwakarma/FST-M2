inputDialouges = Load 'hdfs:///user/root/projectinput/' USING PigStorage('\t') AS (name: chararray, line: chararray);
ranked = RANK inputDialogues;
OnlyDialouges = FILTER ranked BY (rank_inputDialogues > 2);
groupByName = GROUP OnlyDialogues BY name;
names = FOREACH groupByName GENERATE $0 AS name, COUNT($1) AS no_of_lines;
nameOrdered = ORDER names BY no_of_lines DESC;
STORE nameOrdered INTO 'hdfs:///user/root/projectinput/output' USING PigStorage ('\t');
