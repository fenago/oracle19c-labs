/*  prompt for a employee id. Update the employee row by setting the */
/*  bonus for an employee based upon the following commission scale  */
/*	    commission			    bonus = % of commissions */
/*	      >= 500.01 		     10%		     */
/*	      < 500.01 but >= 400.00	     08%		     */
/*	      < 400.01 but >= 300.00	     06%		     */
/*	      < 300.01 but >= 200.00	     04%		     */
/*	      < 200.01 but >= 100.00	     02%		     */
/*	      < 100.01 but > = 0.00	     00%		     */
DECLARE
bonus       staff.comm%TYPE;
commission  staff.comm%TYPE;
emp_id      staff.id%TYPE := &p_emp_id;
bonus_amt   staff.comm%TYPE;
BEGIN
select comm  into commission from staff
where  id = &emp_id;
IF (commission > 0 and commission < 100.01)
   then bonus_amt := 0;
elsif (commission >100.00 and commission < 200.01)
   then bonus_amt := .02 * commission;
elsif (commission >200.00 and commission <300.01)
then bonus_amt := .04 * commission;
elsif (commission >300.00 and commission < 400.01)
then bonus_amt := .06 * commission;
elsif (commission >400.00 and commission < 500.01)
then bonus_amt := .08 * commission;
else
   bonus_amt := .10 * commission;
end if;
UPDATE staff 
set comm = (comm + bonus_amt)
where  id = emp_id;
COMMIT;
END;
/
