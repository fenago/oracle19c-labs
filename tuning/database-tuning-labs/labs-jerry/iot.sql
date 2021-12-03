CREATE TABLE person_iot 
(ssn_sm,rec_prec,name_ind,states_us,dob,apft_score,
 eth_gp,martl_stat,race_pop_gp,rel_denom,sex,hgt_ind,wt_ind,loc_data_pers,
CONSTRAINT  PK_ PRIMARY KEY (ssn_sm,rec_prec)) 
organization index tablespace example
INCLUDING apft_score
OVERFLOW TABLESPACE USER_DATA
as select ssn_sm, rec_prec, name_ind, states_us, dob,
apft_score, eth_gp, martl_stat, race_pop_gp, rel_denom,
sex, hgt_ind, wt_ind, loc_data_pers
from pers_person_tbl
/
