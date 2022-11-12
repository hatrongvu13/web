create table cd_rule_m
(
	rule_uid varchar(100),
	rule_init_data varchar(100),
	rule_cd varchar(100)
);

create table cd_rule_cond_m 
(
	rule_cond_uid varchar(100),
	rule_uid varchar(100),
	rule_cond_int_data varchar(100),
	rule_cond_ord int,
	rule_cond_digit int,
	del_yn char(1) default 'N'
);

create table cd_rule_cond_d
(
	rule_cond_dtl_uid varchar(100),
	rule_cond_uid varchar(100),
	rule_cond_dtl_type varchar(10),
	rule_cond_dtl_init_data varchar(100),
	rule_cond_dtl_ord int,
	rule_cond_dtl_digit int,
	del_yn char(1) default 'N'
);

create table cd_rule_sr_p 
(
	rule_sr_p_uid varchar(100),
	obj_uid varchar(100),
	press_value varchar(100),
	del_yn char(1) default 'N'
);
