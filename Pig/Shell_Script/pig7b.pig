h1b= LOAD '/user/hive/warehouse/h1b.db/h1b' using PigStorage('\t') AS
(s_no:int,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:double,year:int ,worksite1:chararray,longitute:double, latitute:double);

dis = foreach h1b generate year,soc_name;
groupby = group dis by year;
con = foreach groupby generate $0,COUNT(dis.soc_name);

dump con;
