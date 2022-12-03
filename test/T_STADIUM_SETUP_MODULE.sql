set serveroutput on;

PURGE RECYCLEBIN;

begin
        
        dbms_output.new_line;
        dbms_output.put_line('***************************');
        dbms_output.put_line('TEST CASE : ADD NEW SECTION');
        dbms_output.put_line('***************************');
        PROC_ADD_NEW_SECTION(NULL, NULL, NULL, NULL, NULL, NULL);
        PROC_ADD_NEW_SECTION(NULL, 'G1', 'Park Drive', 'Boston', 'MA', '02215');
        PROC_ADD_NEW_SECTION('North', 'G1', 'Park Drive', 'Boston', 'MA', '02215');
        PROC_ADD_NEW_SECTION('North', 'G1', 'Park Drive', 'Boston', 'MA', '02215');
        PROC_ADD_NEW_SECTION('East', 'G1', 'Park Drive', 'Boston', 'MA', '02215');
        PROC_ADD_NEW_SECTION('East', 'G2', 'Park Drive', 'Boston', 'MA', '02215');
        PROC_ADD_NEW_SECTION('West', 'G3', 'Park Drive', 'Boston', 'MA', '02215');
        PROC_ADD_NEW_SECTION('South', 'G4', 'Park Drive', 'Boston', 'MA', '02215');
        dbms_output.put_line('***************************');
        
        
        dbms_output.new_line;
        dbms_output.put_line('***************************');
        dbms_output.put_line('TEST CASE : UPDATE SECTION');
        dbms_output.put_line('***************************');
        PROC_UPDATE_SECTION(NULL, NULL, NULL, NULL, NULL, NULL);
        PROC_UPDATE_SECTION(NULL, 'G1', 'Park Drive', 'Boston', 'MA', '02215');
        PROC_UPDATE_SECTION(2, 'G5', 'Park Drive', 'Boston', 'MA', NULL);
        PROC_UPDATE_SECTION(1, 'G5', 'Park Drive', 'Boston', 'MA', '02215');
        PROC_UPDATE_SECTION(2, 'G2', 'Boylston', 'Boston', 'MA', '02215');
        PROC_UPDATE_SECTION(2, 'G5', 'Park Drive', 'Boston', 'MA', '02215');
        PROC_UPDATE_SECTION(10, 'G5', 'Park Drive', 'Boston', 'MA', '02215');
        dbms_output.put_line('***************************');
        
        dbms_output.new_line;
        dbms_output.put_line('***************************');
        dbms_output.put_line('TEST CASE : ADD NEW CATEGORY');
        dbms_output.put_line('***************************');
        PROC_ADD_NEW_CATEGORY(NULL);
        PROC_ADD_NEW_CATEGORY('General');
        PROC_ADD_NEW_CATEGORY('General');  
        PROC_ADD_NEW_CATEGORY('Gold');
        PROC_ADD_NEW_CATEGORY('Silver');  
        PROC_ADD_NEW_CATEGORY('VIP');        
        dbms_output.put_line('***************************');        
        
        dbms_output.new_line;
        dbms_output.put_line('***************************');
        dbms_output.put_line('TEST CASE : ADD NEW SECTION CATEGORY');
        dbms_output.put_line('***************************');
        PROC_ADD_NEW_SECTION_CATEGORY(NULL,1);
        PROC_ADD_NEW_SECTION_CATEGORY(1,NULL);
        PROC_ADD_NEW_SECTION_CATEGORY(NULL,NULL);
        PROC_ADD_NEW_SECTION_CATEGORY(5,1);
        PROC_ADD_NEW_SECTION_CATEGORY(1,5);
        PROC_ADD_NEW_SECTION_CATEGORY(1,1);
        PROC_ADD_NEW_SECTION_CATEGORY(1,2);
        PROC_ADD_NEW_SECTION_CATEGORY(1,3);
        PROC_ADD_NEW_SECTION_CATEGORY(1,4);
        PROC_ADD_NEW_SECTION_CATEGORY(2,1);
        PROC_ADD_NEW_SECTION_CATEGORY(2,2);
        PROC_ADD_NEW_SECTION_CATEGORY(2,3);
        PROC_ADD_NEW_SECTION_CATEGORY(2,4);
        PROC_ADD_NEW_SECTION_CATEGORY(3,1);
        PROC_ADD_NEW_SECTION_CATEGORY(3,2);
        PROC_ADD_NEW_SECTION_CATEGORY(3,3);
        PROC_ADD_NEW_SECTION_CATEGORY(3,4);
        PROC_ADD_NEW_SECTION_CATEGORY(4,1);
        PROC_ADD_NEW_SECTION_CATEGORY(4,2);
        PROC_ADD_NEW_SECTION_CATEGORY(4,3);
        PROC_ADD_NEW_SECTION_CATEGORY(4,4);
        dbms_output.put_line('***************************');
end;
/