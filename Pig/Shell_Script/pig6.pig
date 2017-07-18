h1b= LOAD '/user/hive/warehouse/h1b.db/h1b' using PigStorage('\t') AS
(s_no:int,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:double,year:int ,worksite1:chararray,longitute:double, latitute:double);


totalrecgrup = group h1b ALL;
totalrec = foreach totalrecgrup generate COUNT(h1b.soc_name)as totalApplications;
dis = foreach h1b generate year,case_status;
grp = GROUP dis by year;
con = foreach grp generate $0,COUNT($1) as case_application;
perc = foreach con generate $0,ROUND_TO(((case_application/(double)totalrec.totalApplications)*100),2);
odr = order perc by $1 desc;

dump odr;

