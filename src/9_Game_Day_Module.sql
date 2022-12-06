--Author: Aditya, Anish, Sweta, Sejal
--Comments: Game Day Module
--          Note: Run this script logged in as 'APP_ADMIN' user for Oracle Autonomous Database

PURGE RECYCLEBIN;

SET SERVEROUTPUT ON;
    
CREATE OR REPLACE PROCEDURE PROC_VERIFY_TICKET(
    in_ticket_id NUMBER,
    in_date_time TIMESTAMP
)
IS
  is_true NUMBER;
  is_true1 NUMBER;
  exp_NULL_VALUE exception;
BEGIN
    
    if in_ticket_id is NULL
    or in_date_time is NULL
    then raise exp_NULL_VALUE;
    end if;
    
  SELECT count(*)
  INTO is_true
  FROM ticket t
  inner join match m on t.match_id = m.match_id
  WHERE rfd_id is NULL and ticket_id = in_ticket_id
  and extract(hour from (m.m_start_time - systimestamp)) between -1 and 3;
  
  SELECT count(*) into is_true1
  FROM verification
  where in_ticket_id = ticket_id;

  IF is_true != 1 and is_true1 = 0 THEN
        dbms_output.put_line('Invalid Ticket');
    ELSE
    INSERT INTO verification (ticket_id, v_date_time)
    VALUES (in_ticket_id, in_date_time);
    commit;
    dbms_output.put_line('Valid Ticket');
    END IF;
    
    exception
        when exp_NULL_VALUE
    then
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('TicketID: ' || in_ticket_id);
        dbms_output.put_line('V_Date_Time: ' || in_date_time);
        dbms_output.put_line('---------------------------');
END;
/


execute PROC_VERIFY_TICKET(1,systimestamp);
