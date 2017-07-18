h1b= LOAD '/user/hive/warehouse/h1b.db/h1b' using PigStorage('\t') AS
(s_no:int,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:double,year:int ,worksite1:chararray,longitute:double, latitute:double);

fil = filter h1b by job_title == 'DATA ENGINEER';
disp = foreach fil generate soc_name,year;
grupby = group disp by $1;
con = foreach grupby generate $0,COUNT(disp.soc_name);

dump con;

