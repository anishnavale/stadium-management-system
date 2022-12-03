--Author: Aditya, Anish, Sweta, Sejal
--Comments: Script to generate reports from SMS tables
--          Note: Run this script logged in as 'APP_ADMIN' user for Oracle Autonomous Database

select * from match;
select * from ticket;

PURGE RECYCLEBIN;

SET SERVEROUTPUT ON;

DECLARE
    is_true NUMBER;
BEGIN
    dbms_output.put_line('---------------------------');
    dbms_output.put_line('CHECKING IF SEQUENCES RELATED TO MATCH TABLE ALREADY EXISTS');
    dbms_output.put_line('---------------------------');
    SELECT
        COUNT(*)
    INTO is_true
    FROM
        all_sequences
    WHERE
        sequence_name = 'SEQ_MAT';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: SEQ_MAT Already exists, dropping SEQUENCE');
        EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_MAT';
    END IF;
    
    SELECT
        COUNT(*)
    INTO is_true
    FROM
        all_sequences
    WHERE
        sequence_name = 'SEQ_REF';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: SEQ_REF Already exists, dropping SEQUENCE');
        EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_REF';
    END IF;
    
END;
/

CREATE SEQUENCE SEQ_MAT
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    MINVALUE 1 
    NOCYCLE
    ORDER;
    
CREATE SEQUENCE SEQ_REF
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    MINVALUE 1 
    NOCYCLE
    ORDER;
    
CREATE OR REPLACE PROCEDURE PROC_ADD_NEW_MATCH(
    in_league_name VARCHAR,
    in_team1 VARCHAR,
    in_team2 VARCHAR,
    in_start_time TIMESTAMP,
    in_end_time TIMESTAMP,
    in_match_active VARCHAR
)
IS
  is_true NUMBER;
  exp_NULL_VALUE exception;
BEGIN
    
    if in_league_name is NULL
    or in_team1 is NULL
    or in_team2 is NULL
    or in_start_time is NULL
    or in_end_time is NULL
    or in_match_active is NULL
    then raise exp_NULL_VALUE;
    end if;
    
  SELECT count(*)
  INTO is_true
  FROM match
  WHERE in_start_time between m_start_time and m_end_time or
  in_end_time between m_start_time and m_end_time;

  IF is_true > 0 THEN
        dbms_output.put_line('Time Conflict');
    ELSE
    INSERT INTO match (match_id, league_name, team1, team2, m_start_time, m_end_time, match_active)
    VALUES (SEQ_MAT.nextval,in_league_name,in_team1,in_team2,in_start_time,in_end_time,in_match_active);
    commit;
    END IF;
    
    exception
        when exp_NULL_VALUE
    then
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('League_Name: ' || in_league_name);
        dbms_output.put_line('Team1: ' || in_team1);
        dbms_output.put_line('Team2: ' || in_team2);
        dbms_output.put_line('M_Start_Time: ' || in_start_time);
        dbms_output.put_line('M_End_Time: ' || in_end_time);
        dbms_output.put_line('MatchActive: ' || in_match_active);
        dbms_output.put_line('---------------------------');
END;
/

CREATE OR REPLACE PROCEDURE PROC_MODIFY_MATCH(
    in_match_id NUMBER,
    in_league_name VARCHAR,
    in_team1 VARCHAR,
    in_team2 VARCHAR,
    in_start_time TIMESTAMP,
    in_end_time TIMESTAMP,
    in_match_active VARCHAR
)
IS
  is_true NUMBER;
  exp_NULL_VALUE exception;
BEGIN
    if in_league_name is NULL
    or in_team1 is NULL
    or in_team2 is NULL
    or in_start_time is NULL
    or in_end_time is NULL
    or in_match_active is NULL
    then raise exp_NULL_VALUE;
    end if;
    
  SELECT count(*)
  INTO is_true
  FROM match
  WHERE in_start_time between m_start_time and m_end_time or
  in_end_time between m_start_time and m_end_time
  and in_start_time < in_end_time;

  IF is_true > 0 THEN
        dbms_output.put_line('Time Conflict');
    ELSE
    UPDATE MATCH SET
    league_name = in_league_name, team1 = in_team1, team2 = in_team2, m_start_time = in_start_time, m_end_time = in_end_time, match_active = in_match_active
    WHERE match_id = in_match_id;
    commit;
    END IF;
    
    exception
        when exp_NULL_VALUE
    then
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('League_Name: ' || in_league_name);
        dbms_output.put_line('Team1: ' || in_team1);
        dbms_output.put_line('Team2: ' || in_team2);
        dbms_output.put_line('M_Start_Time: ' || in_start_time);
        dbms_output.put_line('M_End_Time: ' || in_end_time);
        dbms_output.put_line('MatchActive: ' || in_match_active);
        dbms_output.put_line('---------------------------');
END;
/

CREATE OR REPLACE PROCEDURE PROC_INACTIVATE_MATCH(
    in_match_id NUMBER,
    in_reason VARCHAR
)
IS
  is_true NUMBER;
BEGIN
  SELECT count(*)
  INTO is_true
  FROM match
  WHERE in_start_time between m_start_time and m_end_time or
  in_end_time between m_start_time and m_end_time;

    UPDATE TICKET SET
    RFD_ID = 5
    WHERE MATCH_ID = in_match_id;
    commit;
END;
/


