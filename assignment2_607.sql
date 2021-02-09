DROP TABLE IF EXISTS raw_results;

CREATE TABLE raw_results 
(
  timestamp varchar(100) NOT NULL
  ,joker varchar(100)
  ,marriage_story varchar(100)
  ,once_upon_a_time varchar(100)
  ,parasite varchar(100)
  ,ford_v_ferrari varchar(100)
  ,little_women varchar(100)
);

SELECT * FROM raw_results;

-- Load the CSV data in, format from Lab
LOAD DATA INFILE '/Users/clairemeyer/Data/survey_results.csv' 
	INTO TABLE raw_results
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(timestamp, joker, marriage_story, once_upon_a_time, parasite, ford_v_ferrari, little_women)
;

-- View table
SELECT * FROM raw_results;

-- Add an ID field for survey participants 
ALTER TABLE raw_results
ADD COLUMN participant_id int NOT NULL AUTO_INCREMENT PRIMARY KEY;

-- Reshape the data into something easier for analysis
DROP TABLE IF EXISTS final_results; 

CREATE TABLE final_results 
(
  id int
  ,timestamp varchar(100) NOT NULL
  ,film varchar(100)
  ,score varchar(100)
);

INSERT INTO final_results 
SELECT
participant_id
,timestamp
,'joker' as film
,CASE WHEN joker = '' THEN 0 ELSE joker END as score
FROM raw_results
;

INSERT INTO final_results 
SELECT
participant_id
,timestamp
,'marriage_story' as film
,CASE WHEN marriage_story = '' THEN 0 ELSE marriage_story END as score
FROM raw_results
;

INSERT INTO final_results 
SELECT
participant_id
,timestamp
,'once_upon_a_time' as film
,CASE WHEN once_upon_a_time = '' THEN 0 ELSE once_upon_a_time END as score
FROM raw_results
;

INSERT INTO final_results 
SELECT
participant_id
,timestamp
,'parasite' as film
,CASE WHEN parasite = '' THEN 0 ELSE parasite END as score
FROM raw_results
;

INSERT INTO final_results 
SELECT
participant_id
,timestamp
,'ford_v_ferrari' as film
,CASE WHEN ford_v_ferrari = '' THEN 0 ELSE ford_v_ferrari END as score
FROM raw_results
;

INSERT INTO final_results 
SELECT
participant_id
,timestamp
,'little_women' as film
,CASE WHEN little_women = '' THEN 0 ELSE little_women END as score
FROM raw_results
;

-- Confirm values

SELECT * FROM final_results;

-- Push into CSV, format from Lab 
SELECT * FROM final_results
INTO OUTFILE '/Users/clairemeyer/Data/transformed_survey.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n';

