create function updateFirstUserName () returns void as
$$
begin
update cpu
set ram = 0
where cores = 0;
end ;
$$
language plpgsql ;
