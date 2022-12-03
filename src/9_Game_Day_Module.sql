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
  exp_NULL_VALUE exception;
BEGIN
    
    if in_ticket_id is NULL
    or in_date_time is NULL
    then raise exp_NULL_VALUE;
    end if;
    
  SELECT count(*)
  INTO is_true
  FROM ticket
  WHERE rfd_id is NULL and ticket_id = in_ticket_id;

  IF is_true != 1 THEN
        dbms_output.put_line('Invalid Ticket');
    ELSE
    INSERT INTO verification (ticket_id, v_date_time)
    VALUES (in_ticket_id, in_date_time);
    commit;
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

