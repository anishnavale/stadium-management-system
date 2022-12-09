/*

SEQUENCE SETUP

*/

/*SEQUENCES*/
set serveroutput on;

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
    select count(1) into seqCount from all_sequences where sequence_name=seqName and sequence_owner='APP_ADMIN_TEST';
    
    if seqCount>0
    then
        dbms_output.put_line('Sequence : ' || seqName || ' already exists, dropping and recreating it!' );
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seqName;
    end if;
    

    dbms_output.put_line('Creating the '||'Sequence : ' || seqName);
    execute immediate 'CREATE SEQUENCE ' || seqName || ' INCREMENT BY 1 START WITH 1';
    
    seqName:='SEQ_CAT_CATEGORY_ID';
    select count(1) into seqCount from all_sequences where sequence_name=seqName and sequence_owner='APP_ADMIN_TEST';
    
    if seqCount>0
    then
        dbms_output.put_line('Sequence : ' || seqName || ' already exists, dropping and recreating it!' );
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seqName;
    end if;
    

    dbms_output.put_line('Creating the '||'Sequence : ' || seqName);
    execute immediate 'CREATE SEQUENCE ' || seqName || ' INCREMENT BY 1 START WITH 1';
    
    seqName:='SEQ_SC_SC_ID';
    select count(1) into seqCount from all_sequences where sequence_name=seqName and sequence_owner='APP_ADMIN_TEST';
    
    if seqCount>0
    then
        dbms_output.put_line('Sequence : ' || seqName || ' already exists, dropping and recreating it!' );
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seqName;
    end if;
    

    dbms_output.put_line('Creating the '||'Sequence : ' || seqName);
    execute immediate 'CREATE SEQUENCE ' || seqName || ' INCREMENT BY 1 START WITH 1';
    
    seqName:='SEQ_SEA_SEAT_ID';
    select count(1) into seqCount from all_sequences where sequence_name=seqName and sequence_owner='APP_ADMIN_TEST';
    
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

--PROC_TMMOD_SEQUENCE_SETUP
create or replace procedure
PROC_TMMOD_SEQUENCE_SETUP
as
    seqCount NUMBER;
    seqName VARCHAR(255);
    e_code NUMBER;
    e_msg VARCHAR(255);
begin

    seqName:='SEQ_PAY_PAYMENT_ID';
    select count(1) into seqCount from all_sequences where sequence_name=seqName and sequence_owner='APP_ADMIN_TEST';
    
    if seqCount>0
    then
        dbms_output.put_line('Sequence : ' || seqName || ' already exists, dropping and recreating it!' );
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seqName;
    end if;
    

    dbms_output.put_line('Creating the '||'Sequence : ' || seqName);
    execute immediate 'CREATE SEQUENCE ' || seqName || ' INCREMENT BY 1 START WITH 1';
    
    
    seqName:='SEQ_TIC_TICKET_ID';
    select count(1) into seqCount from all_sequences where sequence_name=seqName and sequence_owner='APP_ADMIN_TEST';
    
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
    PROC_TMMOD_SEQUENCE_SETUP;
end;
/