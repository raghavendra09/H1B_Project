h1b= LOAD '/user/hive/warehouse/h1b.db/h1b' using PigStorage('\t') AS
(s_no:int,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:double,year:int ,worksite1:chararray,longitute:double, latitute:double);

disp = foreach h1b generate job_title;
grupby = group disp by $0;
con = foreach grupby generate $0,COUNT(disp.$0);
ord = order con by $1 desc;
lmt = limit ord 5;

dump lmt;

