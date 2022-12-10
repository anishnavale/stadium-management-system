--Author: Aditya, Anish, Sweta, Sejal
--Comments: Game Day Module
--          Note: Run this script logged in as 'APP_ADMIN' user for Oracle Autonomous Database

PURGE RECYCLEBIN;
SET SERVEROUTPUT ON;

--Game Day Module : PACK_GAME_DAY BODY
CREATE OR REPLACE
PACKAGE BODY PACK_GAME_DAY AS

--PROCEDURES
    
    --proc : PROC_ADD_NEW_SECTION(in_ticket_id, in_date_time)
    PROCEDURE PROC_VERIFY_TICKET(
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
      FROM APP_ADMIN.ticket t
      inner join APP_ADMIN.match m on t.match_id = m.match_id
      WHERE rfd_id is NULL and ticket_id = in_ticket_id and to_char(m.m_start_time, 'dd-mm-yy') = to_char(in_date_time, 'dd-mm-yy') and extract(hour from (m.m_start_time - in_date_time)) between -1 and 3;
      
      SELECT count(*) into is_true1
      FROM APP_ADMIN.verification
      where in_ticket_id = ticket_id;
    
      IF is_true != 1 or is_true1 != 0 THEN
            dbms_output.put_line('Invalid Ticket');
        ELSE
            INSERT INTO APP_ADMIN.verification (ticket_id, v_date_time)
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
    END PROC_VERIFY_TICKET;
END PACK_GAME_DAY;
/

-- Test Cases

-- Correct Ticket, Wrong Timestamp
execute PROC_VERIFY_TICKET(19,systimestamp);

-- Non-Existing Ticket, Correct Timestamp
execute PROC_VERIFY_TICKET(113,TO_DATE('2022-12-20 09:40:00','yyyy-mm-dd hh24:mi:ss'));

-- Correct Ticket, Correct Timestamp
execute PROC_VERIFY_TICKET(24,TO_DATE('2022-12-20 09:40:00','yyyy-mm-dd hh24:mi:ss'));

-- Used Ticket, Correct Timestamp
execute PROC_VERIFY_TICKET(24,TO_DATE('2022-12-20 09:40:00','yyyy-mm-dd hh24:mi:ss'));

--delete from verification where ticket_id = 24;