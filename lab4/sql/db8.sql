select * from optimal_requirements where id_os in (select id_os from os where bits > 20); 
select * from minimal_requirements where id_cpu in (select id_cpu from cpu WHERE ram IN('2')); 
