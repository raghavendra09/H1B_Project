h1b= LOAD '/user/hive/warehouse/h1b.db/h1b' using PigStorage('\t') AS
(s_no:int,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:double,year:int ,worksite1:chararray,longitute:double, latitute:double);

totalrecgrup = group h1b ALL;
totalrec = foreach totalrecgrup generate COUNT(h1b.soc_name)as totalApplications;

rec = foreach h1b generate employer_name,case_status;
fil_suc = FILTER rec by case_status == 'CERTIFIED' or case_status == 'CERTIFIED-WITHDRAWN';
rec1 = foreach fil_suc generate employer_name,case_status;
groupby = group rec1 by employer_name;
coutofEmplye = foreach groupby generate $0,COUNT(rec1.case_status) as cerftifiedApplications;

perc = foreach coutofEmplye generate $0,(cerftifiedApplications/(double)totalrec.totalApplications)*100;

odr = order perc by $1 desc;
lim = LIMIT odr 10;

dump lim;
