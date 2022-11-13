CREATE OR REPLACE FUNCTION public.call_pids(rule_cd_input text)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
DECLARE 
    r record;
	r01 record;
	rtn text;
	dilimiter varchar(1);
	press_old varchar;
BEGIN
	-- increase 1
    select rule_dilimiter  into dilimiter from cd_rule_m  where rule_cd = rule_cd_input;
	for r in select * from cd_rule_cond_m crcm 
				where crcm.rule_uid = (select crm.rule_uid from cd_rule_m crm where crm.rule_cd = rule_cd_input)
	loop 
		
		for	r01 in select * from cd_rule_cond_d crcd 
						where crcd.rule_cond_dtl_type = 'NUMBER' and crcd.rule_cond_uid = cast(r.rule_cond_uid as varchar)
		loop 
			select press_value into press_old from cd_rule_sr_p crsp 
					where obj_uid = cast(r01.rule_cond_dtl_uid as varchar);
			update cd_rule_sr_p set press_value = (select lpad(cast((cast(press_old as integer)+1) as varchar), length(press_old), '0') from cd_rule_sr_p
														where obj_uid = cast(r01.rule_cond_dtl_uid as varchar)) 
				where obj_uid = cast(r01.rule_cond_dtl_uid as varchar);
		end loop;
	
		for r01 in select
						case 
							when rule_cond_dtl_type = 'NUMBER' then (select press_value from cd_rule_sr_p crsp where obj_uid = rule_cond_dtl_uid)
							else rule_cond_dtl_init_data
						end
						
					from cd_rule_cond_d crcm  
						where rule_cond_uid = cast(r.rule_cond_uid as varchar) order by rule_cond_dtl_ord
		loop 
			select concat(rtn, r01.rule_cond_dtl_init_data)  into rtn;
		end loop;
		select concat(rtn, dilimiter) into rtn;
	end loop;
--remove dilimiter end
	SELECT substring(rtn, 1, length(rtn)-1) into rtn; 
--	create rule
return rtn;
END; $function$
;

select public.call_pids('PIDS_ABC_00')