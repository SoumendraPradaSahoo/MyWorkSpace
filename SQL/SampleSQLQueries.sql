select * from nbp_PolicyNumber;

select * from nbp_partialsave where policynumber in ('21910028');

select distinct(status) from nbp_partialsave;

update nbp_partialsave set status = 'n' where policynumber in ('21820001');



a - acknowledged
f - fail
d - soft deleted
n - in-progress