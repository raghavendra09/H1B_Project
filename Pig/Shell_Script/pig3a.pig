h1b= LOAD '/user/hive/warehouse/h1b.db/h1b' using PigStorage('\t') AS
(s_no:int,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:double,year:int ,worksite1:chararray,longitute:double, latitute:double);

fil  = filter h1b by job_title == 'DATA SCIENTIST';
dis = foreach fil generate soc_name,job_title;
grup = group dis by soc_name;
con = foreach grup generate group,COUNT(dis.job_title) as total;
odr = order con by total desc;

dump odr;

