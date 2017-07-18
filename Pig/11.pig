
totalrecgrup = group h1b ALL;
totalrec = foreach totalrecgrup generate COUNT(h1b.soc_name)as totalApplications;

rec = foreach h1b generate job_title,case_status;
fil_suc = FILTER rec by case_status == 'CERTIFIED' or case_status == 'CERTIFIED-WITHDRAWN';
rec1 = foreach fil_suc generate job_title,case_status;
groupby = group rec1 by job_title;
coutofEmplye = foreach groupby generate $0,COUNT(rec1.case_status) as cerftifiedApplications;

d = foreach coutofEmplye generate $0,(cerftifiedApplications/(double)totalrec.totalApplications)*100;

odr = order d by $1 desc;
lim = LIMIT odr 10;

dump lim;

STORE lim INTO '10.pig' using PigStorage('\t');
