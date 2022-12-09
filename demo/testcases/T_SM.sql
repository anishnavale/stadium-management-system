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
        
        dbms_output.new_line;
        dbms_output.put_line('***************************');
        dbms_output.put_line('TEST CASE : ADD NEW SEATS');
        dbms_output.put_line('***************************');
        PROC_ADD_NEW_SEATS(NULL,NULL, NULL);
        PROC_ADD_NEW_SEATS(NULL,'A', 20);
        PROC_ADD_NEW_SEATS(1,NULL, 20);
        PROC_ADD_NEW_SEATS(1,'A', NULL);
        PROC_ADD_NEW_SEATS(100,'A', 0);
        PROC_ADD_NEW_SEATS(1,'A', 0);
        PROC_ADD_NEW_SEATS(1,'A', -1);
        
        PROC_ADD_NEW_SEATS(1,'A', 5);
        PROC_ADD_NEW_SEATS(1,'B', 5);
        PROC_ADD_NEW_SEATS(2,'A', 5);
        PROC_ADD_NEW_SEATS(2,'B', 5);
        PROC_ADD_NEW_SEATS(3,'A', 5);
        PROC_ADD_NEW_SEATS(3,'B', 5);
        PROC_ADD_NEW_SEATS(4,'A', 5);
        PROC_ADD_NEW_SEATS(4,'B', 5);
        
        PROC_ADD_NEW_SEATS(5,'A', 5);
        PROC_ADD_NEW_SEATS(5,'B', 5);
        PROC_ADD_NEW_SEATS(6,'A', 5);
        PROC_ADD_NEW_SEATS(6,'B', 5);
        PROC_ADD_NEW_SEATS(7,'A', 5);
        PROC_ADD_NEW_SEATS(7,'B', 5);
        PROC_ADD_NEW_SEATS(8,'A', 5);
        PROC_ADD_NEW_SEATS(8,'B', 5);
        
        PROC_ADD_NEW_SEATS(9,'A', 5);
        PROC_ADD_NEW_SEATS(9,'B', 5);
        PROC_ADD_NEW_SEATS(10,'A', 5);
        PROC_ADD_NEW_SEATS(10,'B', 5);
        PROC_ADD_NEW_SEATS(11,'A', 5);
        PROC_ADD_NEW_SEATS(11,'B', 5);
        PROC_ADD_NEW_SEATS(12,'A', 5);
        PROC_ADD_NEW_SEATS(12,'B', 5);
        
        PROC_ADD_NEW_SEATS(13,'A', 5);
        PROC_ADD_NEW_SEATS(13,'B', 5);
        PROC_ADD_NEW_SEATS(14,'A', 5);
        PROC_ADD_NEW_SEATS(14,'B', 5);
        PROC_ADD_NEW_SEATS(15,'A', 5);
        PROC_ADD_NEW_SEATS(15,'B', 5);
        PROC_ADD_NEW_SEATS(16,'A', 5);
        PROC_ADD_NEW_SEATS(16,'B', 5);
        
        dbms_output.put_line('***************************');

end;
/