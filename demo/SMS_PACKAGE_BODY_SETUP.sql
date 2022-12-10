/*

PACKAGE BODY SETUP

*/


set serveroutput on;
PURGE RECYCLEBIN;

--Stadium Setup Module : PACK_STADIUM_MANAGEMENT BODY
create or replace PACKAGE BODY PACK_STADIUM_MANAGEMENT AS

--PROCEDURES

        --proc : PROC_ADD_NEW_SECTION(SectionName, GateName, GateStreet, GateCity, GateState, GatePincode)
        procedure 
        PROC_ADD_NEW_SECTION(
            SectionName VARCHAR2,
            GateName VARCHAR2,
            GateStreet VARCHAR2, 
            GateCity VARCHAR2, 
            GateState VARCHAR2,
            GatePincode VARCHAR2
        ) is 
            sectionCount NUMBER;
            gateCount NUMBER;
            e_code NUMBER;
            e_msg VARCHAR2(255);
            exp_NULL_VALUE exception;
            exp_SECTION_EXISTS exception;
            exp_GATE_EXISTS exception;
        begin

            if SectionName IS NULL 
            or GateName IS NULL 
            or GateStreet IS NULL 
            or GateCity IS NULL 
            or GateState IS NULL
            or GatePincode IS NULL
            then 
                raise exp_NULL_VALUE;
            end if;

            select count(1) into sectionCount from section where section_name=SectionName;
            select count(1) into gateCount from section where gate_name=GateName;

            if sectionCount>0
            then
                raise exp_SECTION_EXISTS;
            else    
                if gateCount>0
                then
                    raise exp_GATE_EXISTS; 

                else
                    insert into section values(SEQ_SEC_SECTION_ID.nextval,SectionName, GateName, GateStreet, GateCity, GateState, GatePincode);
                    commit;
                dbms_output.put_line('New Section Added: ' || SectionName); 
                end if;

            end if;



        exception

            when exp_NULL_VALUE
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SectionName: ' || SectionName);
                dbms_output.put_line('GateName: ' || GateName);
                dbms_output.put_line('GateStreet: ' || GateStreet);
                dbms_output.put_line('GateCity: ' || GateCity);
                dbms_output.put_line('GateState: ' || GateState);
                dbms_output.put_line('GatePincode: ' || GatePincode);
                dbms_output.put_line('---------------------------');

            when exp_SECTION_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SECTION ALREADY EXISTS, ASSIGN A NAME THAT IS NOT USED ALREADY'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SectionName: ' || SectionName);
                dbms_output.put_line('---------------------------');

            when exp_GATE_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('GATE ALREADY EXISTS, ASSIGN A NAME THAT IS NOT USED ALREADY'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('GateName: ' || GateName);
                dbms_output.put_line('---------------------------');

            when others
            then 
                dbms_output.put_line('Exception Occurred');
                e_code := SQLCODE;
                e_msg := SQLERRM;
                dbms_output.put_line('Error Code: ' || e_code);
                dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 

        end PROC_ADD_NEW_SECTION;

        --proc : PROC_UPDATE_SECTION(SectionID, GateName, GateStreet, GateCity, GateState, GatePincode)
        procedure 
        PROC_UPDATE_SECTION(
            SectionID NUMBER,
            GateName VARCHAR2,
            GateStreet VARCHAR2, 
            GateCity VARCHAR2, 
            GateState VARCHAR2,
            GatePincode VARCHAR2
        ) is 
            sectionCount NUMBER;
            gateCount NUMBER;
            e_code NUMBER;
            e_msg VARCHAR2(255);
            exp_NULL_VALUE exception;
            exp_SECTION_NOT_EXISTS exception;
            exp_GATE_EXISTS exception;
        begin

            if SectionID IS NULL 
            or GateName IS NULL 
            or GateStreet IS NULL 
            or GateCity IS NULL 
            or GateState IS NULL
            or GatePincode IS NULL
            then 
                raise exp_NULL_VALUE;
            end if;

            select count(1) into sectionCount from section where section_id=SectionID;
            select count(1) into gateCount from section where gate_name=GateName and section_id!=SectionID;


            if sectionCount>0
            then
                if gateCount>0
                then
                    raise exp_GATE_EXISTS;
                else
                    update section set
                    gate_name=GateName,
                    gate_street=GateStreet,
                    gate_state=GateState,
                    gate_pincode=GatePincode
                    where section_id=SectionID;
                    commit;
                    dbms_output.put_line('SectionID Updated: ' || SectionID); 
                end if;        
            else
                raise exp_SECTION_NOT_EXISTS;
            end if;


        exception

            when exp_NULL_VALUE
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SectionID: ' || SectionID);
                dbms_output.put_line('GateName: ' || GateName);
                dbms_output.put_line('GateStreet: ' || GateStreet);
                dbms_output.put_line('GateCity: ' || GateCity);
                dbms_output.put_line('GateState: ' || GateState);
                dbms_output.put_line('GatePincode: ' || GatePincode);
                dbms_output.put_line('---------------------------');

            when exp_SECTION_NOT_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SECTION DOES NOT EXISTS, GIVE THE CORRECT SECTION ID THAT EXISTS'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SectionID: ' || SectionID);
                dbms_output.put_line('---------------------------');

            when exp_GATE_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('GATE ALREADY EXISTS FOR ANOTHER SECTION, ASSIGN A NAME THAT IS NOT USED ALREADY'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('GateName: ' || GateName);
                dbms_output.put_line('---------------------------');

            when others
            then 
                dbms_output.put_line('Exception Occurred');
                e_code := SQLCODE;
                e_msg := SQLERRM;
                dbms_output.put_line('Error Code: ' || e_code);
                dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 

        end PROC_UPDATE_SECTION;

        --proc : PROC_ADD_NEW_CATEGORY(CategoryName)
        procedure
        PROC_ADD_NEW_CATEGORY(
            CategoryName VARCHAR
        ) is
            categoryCount NUMBER;
            e_code NUMBER;
            e_msg VARCHAR(255);
            exp_CATEGORY_EXISTS exception;
            exp_NULL_VALUE exception;
        begin

            if CategoryName IS NULL
            then
                raise exp_NULL_VALUE;
            end if;

            select count(1) into categoryCount from category where category_name=CategoryName;
            if categoryCount>0
            then
                raise exp_CATEGORY_EXISTS;
            else
                insert into category values(SEQ_CAT_CATEGORY_ID.nextval, CategoryName);
                commit;
                dbms_output.put_line('New Category Added: ' || categoryName); 
            end if;

        exception

            when exp_NULL_VALUE
                then
                    dbms_output.new_line;
                    dbms_output.put_line('---------------------------');
                    dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
                    dbms_output.put_line('---------------------------');
                    dbms_output.put_line('CategoryName: ' || CategoryName);
                    dbms_output.put_line('---------------------------');

            when exp_CATEGORY_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CATEGORY ALREADY EXISTS, ASSIGN A NAME THAT IS NOT USED ALREADY'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CategoryName: ' || CategoryName);
                dbms_output.put_line('---------------------------');
            when others
            then 
                dbms_output.put_line('Exception Occurred');
                e_code := SQLCODE;
                e_msg := SQLERRM;
                dbms_output.put_line('Error Code: ' || e_code);
                dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
        end PROC_ADD_NEW_CATEGORY;

        --proc : PROC_ADD_NEW_SECTION_CATEGORY(SectionID, CategoryID)
        procedure
        PROC_ADD_NEW_SECTION_CATEGORY(
            SectionID NUMBER,
            CategoryID NUMBER
        ) is
            sectionCount NUMBER;
            categoryCount NUMBER;
            sectionCategoryCount NUMBER;
            e_code NUMBER;
            e_msg VARCHAR(255);
            exp_SECTION_CATEGORY_EXISTS exception;
            exp_SECTION_NOT_EXISTS exception;
            exp_CATEGORY_NOT_EXISTS exception;
            exp_NULL_VALUE exception;
        begin

            if SectionID IS NULL
            or CategoryID IS NULL
            then
                raise exp_NULL_VALUE;
            end if;

            select count(1) into sectionCount from section
            where section_id=SectionID;

            select count(1) into categoryCount from category
            where category_id=CategoryID;

            select count(1) into sectionCategoryCount from section_category 
            where section_id=SectionID and category_id=CategoryID;

            if sectionCount<=0
                then
                    raise exp_SECTION_NOT_EXISTS;
            end if;

            if categoryCount<=0
                then
                    raise exp_CATEGORY_NOT_EXISTS;
            end if;


            if sectionCategoryCount>0
            then
                raise exp_SECTION_CATEGORY_EXISTS;
            else
                insert into section_category values(SEQ_SC_SC_ID.nextval, SectionID, CategoryID);
                commit;
                dbms_output.put_line('New Section Category Added: ' || '('||SectionID||')' || '('||CategoryID||')'); 
            end if;

        exception

            when exp_NULL_VALUE
                then
                    dbms_output.new_line;
                    dbms_output.put_line('---------------------------');
                    dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
                    dbms_output.put_line('---------------------------');
                    dbms_output.put_line('SectionID: ' || SectionID);
                    dbms_output.put_line('CategoryID: ' || CategoryID);
                    dbms_output.put_line('---------------------------');

            when exp_SECTION_NOT_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SECTION DOES NOT EXIST, USE ONE THAT EXISTS ALREADY, OR CREATE A NEW ONE'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SectionID: ' || SectionID);
                dbms_output.put_line('---------------------------');

            when exp_CATEGORY_NOT_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CATEGORY DOES NOT EXIST, USE ONE THAT EXISTS ALREADY, OR CREATE A NEW ONE'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CategoryID: ' || CategoryID);
                dbms_output.put_line('---------------------------');

            when exp_SECTION_CATEGORY_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SECTION CATEGORY ALREADY EXISTS, YOU CAN CREATE A SECTION CATEGORY ONLY ONCE'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SectionID: ' || SectionID);
                dbms_output.put_line('CategoryID: ' || CategoryID);
                dbms_output.put_line('---------------------------');

            when others
            then 
                dbms_output.put_line('Exception Occurred');
                e_code := SQLCODE;
                e_msg := SQLERRM;
                dbms_output.put_line('Error Code: ' || e_code);
                dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
        end PROC_ADD_NEW_SECTION_CATEGORY;

        --proc : PROC_ADD_NEW_SEATS(SectionCategoryID, SeatRow, NumberOfSeatsInRow)
        procedure
        PROC_ADD_NEW_SEATS(
            SectionCategoryID NUMBER,
            SeatRow VARCHAR,
            NumberOfSeatsInRow NUMBER
        ) is
            sectionCategoryCount NUMBER;
            seatRowCount NUMBER;
            e_code NUMBER;
            e_msg VARCHAR(255);
            exp_SECTION_CATEGORY_NOT_EXISTS exception;
            exp_SEAT_ROW_ALREADY_EXISTS exception;
            exp_NULL_VALUE exception;
            exp_INVALID_SEAT_COUNT exception;
        begin

            if SectionCategoryID IS NULL
            or SeatRow IS NULL
            or NumberOfSeatsInRow IS NULL
            then
                raise exp_NULL_VALUE;
            end if;

            select count(1) into sectionCategoryCount from section_category where sc_id=SectionCategoryID;
            if sectionCategoryCount<=0
            then
                raise exp_SECTION_CATEGORY_NOT_EXISTS;
            end if;

            select count(1) into seatRowCount from seat where seat_row=SeatRow and sc_id=SectionCategoryID;
            if seatRowCount>0
            then
                raise exp_SEAT_ROW_ALREADY_EXISTS;
            end if;

            if NumberOfSeatsInRow<=0
            then
                raise exp_INVALID_SEAT_COUNT;
            end if;

            for seatNo in 1..NumberOfSeatsInRow
            loop
                insert into seat values(SEQ_SEA_SEAT_ID.nextval, SectionCategoryID, SeatRow, seatNo);
            end loop;

            commit;
            dbms_output.put_line(NumberOfSeatsInRow || ' Seats added to '|| '('||'SectionCategoryID: '||SectionCategoryID||' ,'||' SeatRow: '||SeatRow||')');

        exception

            when exp_NULL_VALUE
                then
                    dbms_output.new_line;
                    dbms_output.put_line('---------------------------');
                    dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
                    dbms_output.put_line('---------------------------');
                    dbms_output.put_line('SectionCategoryID: ' || SectionCategoryID);
                    dbms_output.put_line('SeatRow: ' || SeatRow);
                    dbms_output.put_line('NumberOfSeatsInRow: ' || NumberOfSeatsInRow);
                    dbms_output.put_line('---------------------------');

            when exp_SECTION_CATEGORY_NOT_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SECTION CATEGORY DOES NOT EXISTS, CREATE SEATS FOR SECTION CATEGORY THAT EXISTS, OR FIRST CREATE A NEW ONE'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SectionCategoryID: ' || SectionCategoryID);
                dbms_output.put_line('---------------------------');

            when exp_SEAT_ROW_ALREADY_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SEAT ROW ALREADY EXISTS FOR SECTION CATEGORY, CREATE SEATS FOR SEAT ROW THAT DOES NOT EXIST'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SectionCategoryID: ' || SectionCategoryID);
                dbms_output.put_line('SeatRowID: ' || SeatRow);
                dbms_output.put_line('---------------------------');

            when exp_INVALID_SEAT_COUNT
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('INVALID SEAT COUNT FOR SEAT ROW, GIVE THE SEAT COUNT >=1'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('NumberOfSeatsInRow: ' || NumberOfSeatsInRow);
                dbms_output.put_line('---------------------------');

            when others
            then 
                dbms_output.put_line('Exception Occurred');
                e_code := SQLCODE;
                e_msg := SQLERRM;
                dbms_output.put_line('Error Code: ' || e_code);
                dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
        end PROC_ADD_NEW_SEATS;

END PACK_STADIUM_MANAGEMENT;
/

--Match Management Module : PACK_MATCH_MANAGEMENT BODY

create or replace PACKAGE BODY PACK_MATCH_MANAGEMENT AS

    --proc : PROC_ADD_NEW_MATCH(in_league_name, in_team1, in_team2, in_start_time, in_end_time, in_match_active)
    PROCEDURE PROC_ADD_NEW_MATCH(
        in_league_name VARCHAR,
        in_team1 VARCHAR,
        in_team2 VARCHAR,
        in_start_time TIMESTAMP,
        in_end_time TIMESTAMP,
        in_match_active VARCHAR
    )
    IS
      mid NUMBER;
      is_true NUMBER;
      exp_NULL_VALUE exception;
      exp_same_teams exception;
      exp_time_error exception;
    BEGIN

        if in_league_name is NULL
        or in_team1 is NULL
        or in_team2 is NULL
        or in_start_time is NULL
        or in_end_time is NULL
        or in_match_active is NULL
        then raise exp_NULL_VALUE;
        end if;

        if in_team1 = in_team2 
        then raise exp_same_teams;
        end if;

        if extract(hour from (in_end_time - in_start_time)) < 2
        then raise exp_time_error;
        end if;

      SELECT count(*)
      INTO is_true
      FROM match
      WHERE in_start_time between m_start_time and m_end_time or
      in_end_time between m_start_time and m_end_time;

      IF is_true > 0 THEN
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('Time Conflict');
            dbms_output.put_line('---------------------------');
        ELSE
        
        mid:=SEQ_MAT_MATCH_ID.nextval;
        INSERT INTO match (match_id, league_name, team1, team2, m_start_time, m_end_time, match_active)
        VALUES (mid,in_league_name,in_team1,in_team2,in_start_time,in_end_time,in_match_active);
        commit;
        dbms_output.put_line('Match Added: ' || mid);
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

            when exp_same_teams
        then 
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('CALLED PROC WITH SAME TEAM NAMES, PLEASE SEND DIFFERENT TEAM NAMES'); 
            dbms_output.put_line('---------------------------');

            when exp_time_error
        then 
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('CALLED PROC WITH TIME CONFLICT, THE TIME DIFFERENCE BETWEEN START TIME AND END TIME SHOULD BE ATLEAST 2 HOURS'); 
            dbms_output.put_line('---------------------------');

    END PROC_ADD_NEW_MATCH;


    --proc : PROC_MODIFY_MATCH(in_match_id, in_league_name, in_team1, in_team2, in_start_time, in_end_time, in_match_active)
    PROCEDURE PROC_MODIFY_MATCH(
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
      is_true1 NUMBER;
      exp_NULL_VALUE exception;
      exp_same_teams exception;
      exp_time_error exception;
      exp_MatchNotFound exception;
    BEGIN
        if in_league_name is NULL
        or in_team1 is NULL
        or in_team2 is NULL
        or in_start_time is NULL
        or in_end_time is NULL
        or in_match_active is NULL
        then raise exp_NULL_VALUE;
        end if;

        if in_team1 = in_team2 
        then raise exp_same_teams;
        end if;

        if extract(hour from (in_end_time - in_start_time)) < 2
        then raise exp_time_error;
        end if;

          SELECT count(*)
          INTO is_true
          FROM match
          WHERE match_id = in_match_id;
          
          if is_true=0
          then
            raise exp_MatchNotFound;
          end if;
          
          SELECT count(*)
          INTO is_true
          FROM match
          WHERE (in_start_time between m_start_time and m_end_time or
          in_end_time between m_start_time and m_end_time)
          and match_id != in_match_id;

          IF is_true > 0 THEN
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('Time Conflict');
                dbms_output.put_line('---------------------------');
            ELSE
            UPDATE MATCH SET
            league_name = in_league_name, team1 = in_team1, team2 = in_team2, m_start_time = in_start_time, m_end_time = in_end_time, match_active = in_match_active
            WHERE match_id = in_match_id;
            commit;
            dbms_output.put_line('Match Modified: ' || in_match_id);
            END IF;

            exception
            
            when exp_MatchNotFound
            then 
            
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('MATCH NOT FOUND, PLEASE ENTER A MATCH THAT EXISTS'); 
                dbms_output.put_line('Match ID: ' || in_match_id);
                dbms_output.put_line('---------------------------');
                
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

                when exp_same_teams
            then 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CALLED PROC WITH SAME TEAM NAMES, PLEASE SEND DIFFERENT TEAM NAMES'); 
                dbms_output.put_line('---------------------------');

                when exp_time_error
            then 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CALLED PROC WITH TIME CONFLICT, THE TIME DIFFERENCE BETWEEN START TIME AND END TIME SHOULD BE ATLEAST 2 HOURS'); 
                dbms_output.put_line('---------------------------');

    END PROC_MODIFY_MATCH;

END PACK_MATCH_MANAGEMENT;
/

--Pricing Management Module : PACK_PRICING_MANAGEMENT BODY
create or replace PACKAGE BODY PACK_PRICING_MANAGEMENT AS


    --proc_add_in_price_catlog
    procedure proc_add_in_price_catlog(match_id_val int, sc_id_val int, amount_val int)
    as
    a number;
    pcid NUMBER;
    e_code NUMBER;
    e_msg VARCHAR2(255);
    exp_NULL_VALUES exception;
    exp_INVALID_AMOUNT exception;
    exp_PC_ALREADYEXISTS exception;
    exp_MATCHNOTFOUND exception;
    exp_SCNOTFOUND exception;
    begin
    
        if match_id_val is NULL
        or sc_id_val is NULL
        or amount_val is NULL
        then
            raise exp_NULL_VALUES;
        end if;
        
        if amount_val<=0
        then
            raise exp_INVALID_AMOUNT;
        end if;
        
        select count(1) into a
        from match
        where match_id=match_id_val;
        
        if a<=0
        then
            raise exp_MATCHNOTFOUND;
        end if;
        
        select count(1) into a
        from section_category
        where sc_id=sc_id_val;
        
        if a<=0
        then
            raise exp_SCNOTFOUND;
        end if;
        
        select count(1) into a
        from price_catalog
        where match_id=match_id_val and sc_id=sc_id_val;
        
        if a>0
        then
            raise exp_PC_ALREADYEXISTS;
        end if;

        dbms_output.put_line('MatchID and SectionID is valid');
        dbms_output.put_line('Inserting data into price catlog');

        pcid:=SEQ_PC_PC_ID.nextval;
        insert into price_catalog values( pcid, match_id_val, sc_id_val, amount_val);
        dbms_output.put_line('Price Catalog added : ' || pcid);
        commit;
        
        exception
                
            when exp_NULL_VALUES
                then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('match_id_val: ' || match_id_val);
                dbms_output.put_line('sc_id_val: ' || sc_id_val);
                dbms_output.put_line('amount_val: ' || amount_val);
                dbms_output.put_line('---------------------------');
                                
            when exp_INVALID_AMOUNT
                then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('INVALID AMOUNT SENT, Send Amount More than $0'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('amount_val: ' || amount_val);
                dbms_output.put_line('---------------------------');
                
            when exp_MATCHNOTFOUND
                then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('MATCH NOT FOUND FOR THE PRICE CATALOG ENTRY'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('match_id_val: ' || match_id_val);
                dbms_output.put_line('---------------------------');
                
            when exp_SCNOTFOUND
                then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SECTION CATEGORY NOT FOUND FOR THE PRICE CATALOG ENTRY'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('sc_id_val: ' || sc_id_val);
                dbms_output.put_line('---------------------------');
                
            when exp_PC_ALREADYEXISTS
                then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('PRICE CATALOG ENTRY ALREADY EXISTS FOR MATCH - SECTION CATEGORY'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('match_id_val: ' || match_id_val);
                dbms_output.put_line('sc_id_val: ' || sc_id_val);
                dbms_output.put_line('---------------------------');
                
            when others
            then 
                dbms_output.put_line('Exception Occurred');
                e_code := SQLCODE;
                e_msg := SQLERRM;
                dbms_output.put_line('Error Code: ' || e_code);
                dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
                
    end proc_add_in_price_catlog;

    --proc_add_discount
    procedure proc_add_discount (coupon_name_val varchar2, discount_perc_val int, start_date timestamp, end_date timestamp)
    as
        did NUMBER;
        e_code NUMBER;
        e_msg VARCHAR2(255);
        exp_NULL_VALUES exception;
        exp_INVALID_DISCOUNT exception;
    begin
    
        if coupon_name_val is NULL
        or discount_perc_val is NULL
        or start_date is NULL
        or end_date is NULL
        then
            raise exp_NULL_VALUES;
        end if;
        
        if discount_perc_val between 1 and 100 then
            dbms_output.put_line('Valid Discount');
        else
            dbms_output.put_line('Invalid discount');
            raise exp_INVALID_DISCOUNT;
        end if;

        dbms_output.put_line('Inserting data into discount');

        did:=SEQ_DIS_DISCOUNT_ID.nextval;
        insert into discount values(did,coupon_name_val, discount_perc_val, start_date, end_date);
        commit;
        dbms_output.put_line('Inserted Discount : ' || did);
        
        exception
        
            when exp_NULL_VALUES
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('coupon_name_val: ' || coupon_name_val);
                dbms_output.put_line('discount_perc_val: ' || discount_perc_val);
                dbms_output.put_line('start_date: ' || to_char(start_date, 'DD-MON-YYYY HH:MI:SS AM'));
                dbms_output.put_line('end_date: ' || to_char(end_date, 'DD-MON-YYYY HH:MI:SS AM'));
                dbms_output.put_line('---------------------------');
            when exp_INVALID_DISCOUNT
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('DISCOUNT PERCENTAGE IS INVALID, IT SHOULD BE IN RANGE (1 to 100)'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('discount_perc_val: ' || discount_perc_val);
                dbms_output.put_line('---------------------------');
            when others
            then 
                dbms_output.put_line('Exception Occurred');
                e_code := SQLCODE;
                e_msg := SQLERRM;
                dbms_output.put_line('Error Code: ' || e_code);
                dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
    end proc_add_discount;

END PACK_PRICING_MANAGEMENT;
/

--Ticket Management Module : PACK_TICKET_MANAGEMENT BODY
create or replace PACKAGE BODY PACK_TICKET_MANAGEMENT AS
    
    --FUNC_CALC_PRICE_WITH_DISCOUNT
    function
    FUNC_CALC_PRICE_WITH_DISCOUNT(
        ActualTotalPrice NUMBER,
        DiscountPercentage NUMBER
    )
    return number
    is
        FinalDiscountPrice NUMBER;
    begin
        FinalDiscountPrice := ActualTotalPrice - ActualTotalPrice * (DiscountPercentage/100);
        return FinalDiscountPrice;    
    end FUNC_CALC_PRICE_WITH_DISCOUNT;

    --FUNC_CALC_PRICE_WITH_TAX
    function
    FUNC_CALC_PRICE_WITH_TAX(
        FinalDiscountPrice NUMBER
    )
    return number
    is
        FinalPrice NUMBER;
        TaxPercentage NUMBER;
    begin
        TaxPercentage := 10;
        FinalPrice := FinalDiscountPrice + FinalDiscountPrice * (TaxPercentage/100);
        return FinalPrice;    
    end FUNC_CALC_PRICE_WITH_TAX;

    --PROC_GET_ESTIMATE
    procedure
    PROC_GET_ESTIMATE(
        CustomerID NUMBER,
        MatchID NUMBER,
        ListOfSelectedSeatIDs seatIDList,
        DiscountCouponName VARCHAR,
        ActualTotalPrice OUT NUMBER,
        DiscountedTotalPrice OUT NUMBER,
        DiscountedTotalPriceWithTax OUT NUMBER,
        SavedPrice OUT NUMBER,
        CustomerWarning OUT VARCHAR,
        statusFlag OUT VARCHAR
    )
    is
        a NUMBER;
        s VARCHAR(1000);
        discountFlag NUMBER;
        e_code NUMBER;
        e_msg VARCHAR2(255);
        exp_NULL_VALUES exception;
        exp_customerNotFound exception;
        exp_matchNotFound exception;
        exp_seatsNotFound exception;    
    begin

        dbms_output.new_line;
        dbms_output.put_line('***************************');
        dbms_output.put_line('PROC_GET_ESTIMATE');
        dbms_output.put_line('***************************');
        if
        CustomerID is null or
        MatchID is null or
        ListOfSelectedSeatIDs is null
        then
            CustomerWarning:='CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES';
            raise exp_NULL_VALUES;
        end if;

        dbms_output.new_line;
        dbms_output.put_line('Checking if customer exists');
        select count(1) into a from customer where cust_id=CustomerID;
        if a!=1
            then 
            CustomerWarning:='BOOK THE TICKET FOR EXISTING CUSTOMER';
            raise exp_customerNotFound;
        end if;

        dbms_output.put_line('Checking if match exists');
        select count(1) into a from V_UPCOMING_MATCHES where match_id=MatchID;
        if a!=1
            then 
            CustomerWarning:='BOOK THE TICKET FOR UPCOMING MATCH';
            raise exp_matchNotFound;
        end if;

        dbms_output.put_line('Checking if seats exist');
        select count(1) into a from V_SHOW_SEAT_STATUS_CUSTOMER where seat_id member of ListOfSelectedSeatIDs and Booking_Status='N';
        if a!=ListOfSelectedSeatIDs.count
            then 
            CustomerWarning:='BOOK THE TICKET FOR SEATS WITH CORRECT/AVAILABLE SEAT IDS';
            raise exp_seatsNotFound;
        end if;


        dbms_output.put_line('Checking if discount coupon exist');
        if DiscountCouponName is null
        then
            discountFlag:=0;
        else
            select count(1) into a from V_DISCOUNTS 
            where upper(coupon_code)=upper(DiscountCouponName)
            and systimestamp between valid_from and valid_till;

            if a=0
            then
                discountFlag:=1;
            end if;

        end if;


        dbms_output.put_line('GETTING ESTIMATE');

        select SUM(ticket_cost) into ActualTotalPrice
        from V_SHOW_SEAT_STATUS_CUSTOMER 
        where match_id=MatchID and seat_id member of ListOfSelectedSeatIDs;


        if discountFlag=0
        then
            DiscountedTotalPrice:=ActualTotalPrice;
            DiscountedTotalPriceWithTax:=FUNC_CALC_PRICE_WITH_TAX(DiscountedTotalPrice);
            CustomerWarning:='DISCOUNT COUPON NOT APPLIED, SHOWING ACTUAL PRICE + TAXES'; 
            statusFlag:='EST_100_NODISCCOUPON';
        elsif discountFlag=1
        then
            DiscountedTotalPrice:=ActualTotalPrice;
            DiscountedTotalPriceWithTax:=FUNC_CALC_PRICE_WITH_TAX(DiscountedTotalPrice);
            CustomerWarning:='DISCOUNT COUPON NOT FOUND, SHOWING ACTUAL PRICE + TAXES'; 
            statusFlag:='EST_101_DISCNOTFOUND';
        else

            --Call the function to calculate the discounted price
            select discount into a from V_DISCOUNTS 
            where upper(coupon_code)=upper(DiscountCouponName)
            and systimestamp between valid_from and valid_till;

            CustomerWarning:='DISCOUNT COUPON APPLIED, SHOWING DISCOUNT PRICE + TAXES';
            statusFlag:='EST_102_DISCFOUND';
            dbms_output.put_line('APPLYING DISCOUNT COUPON: ' || DiscountCouponName);
            dbms_output.put_line('DISCOUNT PERCENTAGE: ' || to_char(a) || '% OFF');
            DiscountedTotalPrice:=FUNC_CALC_PRICE_WITH_DISCOUNT(ActualTotalPrice, a);
            DiscountedTotalPriceWithTax:=FUNC_CALC_PRICE_WITH_TAX(DiscountedTotalPrice);


        end if;

            SavedPrice:=ActualTotalPrice-DiscountedTotalPrice;
            dbms_output.put_line('MESSAGE: ' || CustomerWarning);      
            dbms_output.put_line('ACTUAL TOTAL PRICE: $' || ActualTotalPrice);
            dbms_output.put_line('DISCOUNTED PRICE: $' || DiscountedTotalPrice);
            dbms_output.put_line('AFTER TAX PRICE: $' || DiscountedTotalPriceWithTax);
            dbms_output.put_line('YOU SAVED: $' || SavedPrice);

    exception

        when exp_NULL_VALUES
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line(CustomerWarning); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CustomerID: ' || CustomerID);
                dbms_output.put_line('MatchID: ' || MatchID);

                if ListOfSelectedSeatIDs is not null
                then
                    for i in 1..ListOfSelectedSeatIDs.count loop
                        s := s || ' ' || ListOfSelectedSeatIDs(i);
                    end loop;
                else
                        s := NULL;
                end if;

                dbms_output.put_line('ListOfSelectedSeatIDs: ' || s);
                dbms_output.put_line('---------------------------');
                statusFlag:='EST_001_NULLVALUES';

        when exp_customerNotFound
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CUSTOMER ID DOES NOT EXIST : ' || CustomerID );
                dbms_output.put_line('---------------------------');
                dbms_output.put_line(CustomerWarning);
                dbms_output.put_line('---------------------------');
                statusFlag:='EST_002_CUSTNOTFOUND';

        when exp_matchNotFound
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('MATCH ID DOES NOT EXIST : ' || MatchID );
                dbms_output.put_line('---------------------------');
                dbms_output.put_line(CustomerWarning);
                dbms_output.put_line('---------------------------');
                statusFlag:='EST_003_MATCHNOTFOUND';


        when exp_seatsNotFound
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SOME SEAT IDs ARE NOT AVAILABLE FOR THIS MATCH');
                dbms_output.put_line('---------------------------');
                dbms_output.put_line(CustomerWarning);
                dbms_output.put_line('---------------------------');
                statusFlag:='EST_004_SEATSNOTAVAILABLE';

        when others
            then 
                dbms_output.put_line('Exception Occurred');
                e_code := SQLCODE;
                e_msg := SQLERRM;
                dbms_output.put_line('Error Code: ' || e_code);
                dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255));
                statusFlag:='EST_005_UNKNOWN';
                CustomerWarning:= 'UNKNOWN ERROR: ' || ' ' ||e_code || ' ' ||SUBSTR(e_msg, 1, 255);
    end PROC_GET_ESTIMATE;

    --PROC_BOOK_TICKET
    procedure
    PROC_BOOK_TICKET(
        CustomerID NUMBER,
        MatchID NUMBER,
        ListOfSelectedSeatIDs seatIDList,
        DiscountCouponName VARCHAR,
        PaymentMode VARCHAR
    ) is

        ap NUMBER;
        dp NUMBER;
        tp NUMBER;
        sp NUMBER;
        sf VARCHAR(255);
        cmsg VARCHAR(255);
        did NUMBER(20);
        pid NUMBER(20);
        currentSeatID number;
        e_code NUMBER;
        e_msg VARCHAR2(255);
        exp_seatNotAvailableForBooking exception;
    begin

        PROC_GET_ESTIMATE(CustomerID,MatchID, ListOfSelectedSeatIDs, DiscountCouponName, ap, dp, tp, sp,cmsg, sf);

        dbms_output.new_line;
        dbms_output.put_line('***************************');
        dbms_output.put_line('PROC_BOOK_TICKET');
        dbms_output.put_line('***************************');


        if sf='EST_001_NULLVALUES'
        or sf='EST_002_CUSTNOTFOUND'
        or sf='EST_003_MATCHNOTFOUND'
        or sf='EST_004_SEATSNOTAVAILABLE'
        or sf='EST_005_UNKNOWN'
        then
            dbms_output.put_line('ERROR(While getting estimate) : ' || cmsg);

        else

            if sf='EST_100_NODISCCOUPON'
            or sf='EST_101_DISCNOTFOUND'
            then
                did:=NULL;

            elsif sf='EST_102_DISCFOUND'
            then
                --find discount id corresponding to discountcouponname
                select discount_id into did from discount where upper(coupon_name)=upper(DiscountCouponName);

            end if;   

            dbms_output.new_line;
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('Booking a ticket');
            dbms_output.put_line('---------------------------');

            --add entry to payment table
            dbms_output.put_line('Payment In Process');
            pid:=SEQ_PAY_PAYMENT_ID.nextval;
            INSERT INTO payment (payment_id,discount_id, tot_amount, p_date_time, payment_mode)
            VALUES (pid,did,tp,systimestamp,PaymentMode);

            --try to add tickets one by one to tickets table
            declare
                a number;
                seatNotAvailableForBooking number;
                currentTID number;
            begin

                for i in 1..ListOfSelectedSeatIDs.count 
                loop
                    currentSeatID:=ListOfSelectedSeatIDs(i);
                    select count(1) into a from V_SHOW_SEAT_STATUS_CUSTOMER
                    where match_id=MatchID and seat_id=currentSeatID and booking_status='N';

                    if a=1
                    then
                        dbms_output.put_line('For match ' || MatchID || ' creating ticket for seat: ' || currentSeatID);
                        currentTID:=SEQ_TIC_TICKET_ID.nextval;

                        INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
                        VALUES (currentTID,CustomerID,currentSeatID,NULL,pid,MatchID);

                    else
                        seatNotAvailableForBooking:=1;
                        exit;
                    end if;
                end loop;

                if seatNotAvailableForBooking=1
                then
                    raise exp_seatNotAvailableForBooking;
                end if;

            end;

            dbms_output.put_line('Payment Complete');
            dbms_output.put_line('Tickets Booked for seats');    
            dbms_output.put_line('MESSAGE: ' || cmsg);      
            dbms_output.put_line('ACTUAL TOTAL PRICE: $' || ap);
            dbms_output.put_line('DISCOUNTED PRICE: $' || dp);
            dbms_output.put_line('AFTER TAX PRICE: $' || tp);
            dbms_output.put_line('YOU SAVED: $' || sp);
            dbms_output.put_line('PAYMENT ID: ' || pid);
            dbms_output.put_line('---------------------------');
        end if;



        --Persist the payment information/ticket details
        commit;

    exception

        when exp_seatNotAvailableForBooking
            then
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('Seat ID: ' || currentSeatID || ' not available for booking');
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('Cancelling the ticket booking transaction');
                dbms_output.put_line('Check the available seats again and book new ones');
                dbms_output.put_line('---------------------------');
                rollback;

        when others
            then 
                dbms_output.put_line('Exception Occurred');
                e_code := SQLCODE;
                e_msg := SQLERRM;
                dbms_output.put_line('Error Code: ' || e_code);
                dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255));
                rollback;
    end PROC_BOOK_TICKET;
    
    --PROC_CANCEL_TICKET
    procedure
    PROC_CANCEL_TICKET(
        CustomerID NUMBER,
        PaymentID NUMBER,
        RefundReason VARCHAR2,
        CurrentTimeStamp TIMESTAMP
    ) is
        a number;
        b number;
        daysPassed number;
        e_code NUMBER;
        e_msg VARCHAR(255);
        exp_NULL_VALUES exception;
        exp_PaymentNotFound exception;
        exp_RefundPeriodGone exception;
        exp_CANNOT_REFUND_FOR_PAST_MATCH exception;
        exp_AlreadyRefunded exception;
        rid NUMBER;
        mid NUMBER;
        
    begin
    
        dbms_output.new_line;
        dbms_output.put_line('***************************');
        dbms_output.put_line('PROC_CANCEL_TICKET');
        dbms_output.put_line('***************************');
        
    if CustomerID is NULL
    or PaymentID is NULL
    or CurrentTimeStamp is NULL
    then
        raise  exp_NULL_VALUES;
    end if;
    
    select count(1) into a from V_TICKET_HISTORY
    where payment_id=PaymentID and cust_id=CustomerID and rfd_id is null;
    
    if a<=0
    then
        
        begin
        
            select rfd_id, count(1) into a, b from V_TICKET_HISTORY
            where payment_id=PaymentID and cust_id=CustomerID and rfd_id is not null
            group by rfd_id;
            
            if b>0 then
                raise exp_AlreadyRefunded;
            end if;
            
                exception
                when NO_DATA_FOUND
                then
                    raise exp_PaymentNotFound;
        
        end;
        
        raise exp_PaymentNotFound;
    
    else
    
        select 
        extract (day from CurrentTimeStamp - 
            (select distinct m_start_time from V_TICKET_HISTORY
            where payment_id=PaymentID and cust_id=CustomerID) 
        ) into daysPassed
        from dual;
        
        if daysPassed>10
        then
            raise exp_RefundPeriodGone;
        end if;
        
        select distinct match_id into mid from V_TICKET_HISTORY
        where payment_id=PaymentID and cust_id=CustomerID;
        
        select count(1) into a from V_UPCOMING_MATCHES where match_id=mid;
        
        if a<=0
        then
            raise exp_CANNOT_REFUND_FOR_PAST_MATCH;
        end if;
        
        rid:=SEQ_REF_RFD_ID.nextval;
        
        insert into refund values(rid, RefundReason, systimestamp);
        
        update ticket set rfd_id=rid where payment_id=PaymentID and cust_id=CustomerID;
        commit;
        dbms_output.put_line('Refund generated, Booked tickets are open for new booking again');
        
    end if;
    
    
    
    exception
    
        when exp_NULL_VALUES
        then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CustomerID: ' || CustomerID);
                dbms_output.put_line('PaymentID: ' || PaymentID);
                dbms_output.put_line('CurrentTimeStamp: ' || to_char(CurrentTimeStamp, 'DD-MON-YYYY HH:MI:SS AM'));
                dbms_output.put_line('---------------------------');
                
        when exp_PaymentNotFound
        then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('Payment associated with customer not found'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CustomerID: ' || CustomerID);
                dbms_output.put_line('PaymentID: ' || PaymentID);
                dbms_output.put_line('---------------------------');
                
        when exp_AlreadyRefunded
        then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('Tickets already refunded'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CustomerID: ' || CustomerID);
                dbms_output.put_line('PaymentID: ' || PaymentID);
                dbms_output.put_line('RefundID: ' || a);
                dbms_output.put_line('---------------------------');
                
        when exp_RefundPeriodGone
        then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('Refund period has passed away (more than 10 days)'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('Days passed after ticket booking: ' || daysPassed);
                dbms_output.put_line('---------------------------');
                
        when exp_CANNOT_REFUND_FOR_PAST_MATCH
        then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('Refund not possible for past match'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('Match : ' || mid || ' is already over');
                dbms_output.put_line('---------------------------');
        when others
                then 
                    dbms_output.put_line('Exception Occurred');
                    e_code := SQLCODE;
                    e_msg := SQLERRM;
                    dbms_output.put_line('Error Code: ' || e_code);
                    dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255));
                    rollback;
    end PROC_CANCEL_TICKET;
    
    --PROC_ADD_CUSTOMER
    procedure PROC_ADD_CUSTOMER( 
        CUST_FNAME    VARCHAR2,
        CUST_LNAME    VARCHAR2,
        CUST_EMAIL    VARCHAR2,  
        CUST_CONTACT  VARCHAR2,
        CUST_DOB      DATE,        
        CUST_STREET   VARCHAR2, 
        CUST_CITY     VARCHAR2,  
        CUST_STATE    VARCHAR2,  
        CUST_PINCODE  NUMBER
    )is
        cid NUMBER;
        e_code NUMBER;
        e_msg VARCHAR2(255);
        exp_NULL_VALUES exception;
    begin
    
        
        if  CUST_FNAME is NULL or
            CUST_LNAME is NULL or
            CUST_EMAIL is NULL 
        then
            raise exp_NULL_VALUES;
        end if;
        
        cid:= SEQ_CUS_CUSTOMER_ID.nextval;
        insert into customer values(
            cid,
            CUST_FNAME,
            CUST_LNAME,
            CUST_EMAIL,
            CUST_CONTACT,
            CUST_DOB,
            CUST_STREET,
            CUST_CITY,
            CUST_STATE,
            CUST_PINCODE
        );
        commit;
        
        dbms_output.put_line('Created customer : ' || cid);
    
    exception
    
        when exp_NULL_VALUES
        then
            dbms_output.new_line;
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES');
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('CUST_FNAME: ' || CUST_FNAME);
            dbms_output.put_line('CUST_LNAME: ' || CUST_LNAME);
            dbms_output.put_line('CUST_EMAIL: ' || CUST_EMAIL);
            dbms_output.put_line('---------------------------');
            
        when others
                then 
                    dbms_output.put_line('Exception Occurred');
                    e_code := SQLCODE;
                    e_msg := SQLERRM;
                    dbms_output.put_line('Error Code: ' || e_code);
                    dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255));
                    rollback;
    end;
    
    

END PACK_TICKET_MANAGEMENT;
/


--GameDay Management Module : PACK_GAMEDAY_MANAGEMENT BODY
create or replace PACKAGE BODY PACK_GAMEDAY_MANAGEMENT AS

    --proc : PROC_VERIFY_TICKET(in_ticket_id, in_date_time)
    PROCEDURE PROC_VERIFY_TICKET(
        in_ticket_id NUMBER,
        in_date_time TIMESTAMP
    )
    IS
        c1 number;
        c2 number;
        c3 number;
        c4 number;
      exp_NULL_VALUE exception;
      exp_TICKETDOESNOTEXIST exception;
      exp_VALIDTICKET_TOO_EARLY exception;
      exp_NOTTODAYTICKET exception;
      exp_TICKETALREADYUSED exception;
      
    BEGIN

        if in_ticket_id is NULL
        or in_date_time is NULL
        then raise exp_NULL_VALUE;
        end if;


        select count(1) into c1 from V_USER_TICKETS
        where ticket_id = in_ticket_id;
        
        if c1<=0 then
            raise exp_TICKETDOESNOTEXIST;
        else
            select count(1) into c2 from V_USER_TICKETS
            where ticket_id = in_ticket_id and extract (hour from m_start_time - in_date_time ) between -1 and 3;
            
            if c2<=0 then
            
                select count(1) into c3 from V_USER_TICKETS
                where ticket_id = in_ticket_id and to_char(m_start_time, 'dd-mm-yyyy') = to_char(in_date_time, 'dd-mm-yyyy');
                
                if c3<=0 then
                    raise exp_NOTTODAYTICKET;
                end if;
                raise exp_VALIDTICKET_TOO_EARLY;
            else
            
                select count(1) into c4 from verification where ticket_id = in_ticket_id;
                
                if c4!=0 then
                    raise exp_TICKETALREADYUSED;
                end if;
                
                INSERT INTO verification (ticket_id, v_date_time)
                VALUES (in_ticket_id, in_date_time);
                commit;
                dbms_output.put_line('Valid Ticket : You can enter the stadium');
            end if;

        end if;
        

        exception
            when exp_NULL_VALUE
        then
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('TicketID: ' || in_ticket_id);
            dbms_output.put_line('V_Date_Time: ' || in_date_time);
            dbms_output.put_line('---------------------------');
            
            when exp_TICKETDOESNOTEXIST
            then 
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('NO ENTRY : Ticket does not exist at all -> ' || in_ticket_id); 
            dbms_output.put_line('---------------------------');
            
            when exp_VALIDTICKET_TOO_EARLY
            then
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('NO ENTRY : Todays ticket but too early to admit (Come 2 hours before, max 1 hour late) -> ' || in_ticket_id); 
            dbms_output.put_line('---------------------------');
            
            when exp_NOTTODAYTICKET
            then
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('NO ENTRY : Valid ticket, but not for todays match -> ' || in_ticket_id); 
            dbms_output.put_line('---------------------------');
            
            when exp_TICKETALREADYUSED
            then
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('NO ENTRY : Ticket has been used already for today -> ' || in_ticket_id); 
            dbms_output.put_line('---------------------------');
            
            
            
    END PROC_VERIFY_TICKET;

END PACK_GAMEDAY_MANAGEMENT;
/


--Package level access control
grant execute on APP_ADMIN.PACK_STADIUM_MANAGEMENT to STADIUM_MANAGER;
grant execute on APP_ADMIN.PACK_MATCH_MANAGEMENT to STADIUM_MANAGER;
grant execute on APP_ADMIN.PACK_PRICING_MANAGEMENT to FINANCE_MANAGER;
grant execute on APP_ADMIN.PACK_TICKET_MANAGEMENT to CUSTOMER;
grant execute on APP_ADMIN.PACK_GAMEDAY_MANAGEMENT to STADIUM_SECURITY;