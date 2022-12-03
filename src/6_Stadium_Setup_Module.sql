--Stadium Setup Module

/*

Create procedure for adding new section
        Auto generate the section_id (Create a sequence)
        Input from procedure(SectionName, GateName, GateStreet, GateCity, GateState, GatePincode)
        Check if the entries are not null.
        Check if the section name doesnot exist already (Can we put a unique constraint on section name?)
        If exists, raise exception
        If not, insert the section into section table

Create procedure for editing old section
        Input from procedure (SectionID, GateName, GateStreet, GateCity, GateState, GatePincode)
        Check if the entries are not null
        Check if the section exists, if yes then only update the values
        If not, exception that section doesnot exist
        

Create Procedure for setting up categories
        Auto generate the category_id (Create a sequence)
        Input from procedure (CategoryName)
        Check if the category exists, if yes then raise exception
        If not, insert the new category into the table

Create Procedure for setting up section-categories
        Show section view
        Show category view
        Auto generate the sc_id (Create a sequence)
        Input from procedure (SectionID, CategoryID)
        Check if the SectionID, CategoryID pair exists in the table already
        If yes, raise exception
        If no, insert the entry into the section category table
        
Create Procedure for setting up seats
        Show the section category view
        Auto generate the Seat_ID (Create a sequence)
        Input from procedure(ScID, SeatRow, NoOfSeats)
        Check if ScID, SeatRow combination exists,
        if yes - raise an exception
        if no - create the seats and insert into table seat

*/

set serveroutput on;

PURGE RECYCLEBIN;

/*SEQUENCES*/

--PROC_SSMOD_SEQUENCE_SETUP
create or replace procedure
PROC_SSMOD_SEQUENCE_SETUP
as
    seqCount NUMBER;
    seqName VARCHAR(255);
    e_code NUMBER;
    e_msg VARCHAR(255);
begin

    seqName:='SEQ_SEC_SECTION_ID';
    select count(1) into seqCount from all_sequences where sequence_name=seqName;
    
    if seqCount>0
    then
        dbms_output.put_line('Sequence : ' || seqName || ' already exists, dropping and recreating it!' );
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seqName;
    end if;
    

    dbms_output.put_line('Creating the '||'Sequence : ' || seqName);
    execute immediate 'CREATE SEQUENCE ' || seqName || ' INCREMENT BY 1 START WITH 1';
    
    seqName:='SEQ_CAT_CATEGORY_ID';
    select count(1) into seqCount from all_sequences where sequence_name=seqName;
    
    if seqCount>0
    then
        dbms_output.put_line('Sequence : ' || seqName || ' already exists, dropping and recreating it!' );
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seqName;
    end if;
    

    dbms_output.put_line('Creating the '||'Sequence : ' || seqName);
    execute immediate 'CREATE SEQUENCE ' || seqName || ' INCREMENT BY 1 START WITH 1';
    
    seqName:='SEQ_SC_SC_ID';
    select count(1) into seqCount from all_sequences where sequence_name=seqName;
    
    if seqCount>0
    then
        dbms_output.put_line('Sequence : ' || seqName || ' already exists, dropping and recreating it!' );
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seqName;
    end if;
    

    dbms_output.put_line('Creating the '||'Sequence : ' || seqName);
    execute immediate 'CREATE SEQUENCE ' || seqName || ' INCREMENT BY 1 START WITH 1';
    

exception
when others
    then dbms_output.put_line('Exception Occurred');
    e_code := SQLCODE;
    e_msg := SQLERRM;
    dbms_output.put_line('Error Code: ' || e_code);
    dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
end;
/

begin
    PROC_SSMOD_SEQUENCE_SETUP;
end;
/

/*PROCEDURES*/

--proc : PROC_ADD_NEW_SECTION(SectionName, GateName, GateStreet, GateCity, GateState, GatePincode)
create or replace procedure 
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
    
end;
/


--proc : PROC_UPDATE_SECTION(SectionID, GateName, GateStreet, GateCity, GateState, GatePincode)
create or replace procedure 
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
    
end;
/


--proc : PROC_ADD_NEW_CATEGORY(CategoryName)
create or replace procedure
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
end;
/

--proc : PROC_ADD_NEW_SECTION_CATEGORY(SectionID, CategoryID)
create or replace procedure
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
end;
/