--Author: Aditya, Anish, Sweta, Sejal
--Comments: Script to enter data into SMS tables
--          Note: Run this script logged in as 'APP_ADMIN' user for Oracle Autonomous Database

PURGE RECYCLEBIN;

SET SERVEROUTPUT ON;

DECLARE
    is_true NUMBER;
BEGIN
    dbms_output.put_line('---------------------------');
    dbms_output.put_line('CHECKING IF SMS TABLES ALREADY EXISTS');
    dbms_output.put_line('---------------------------');
    
    --Verification
    SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'VERIFICATION';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: VERIFICATION Already exists, deleting rows');
        DELETE FROM VERIFICATION;
    END IF;

    --Ticket
    SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'TICKET';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: TICKET Already exists, deleting rows');
        DELETE FROM TICKET;
    END IF;
    
    --Refund
    SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'REFUND';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: REFUND Already exists, deleting rows');
        DELETE FROM REFUND;
    END IF;

    --Payment
    SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'PAYMENT';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: PAYMENT Already exists, deleting rows');
        DELETE FROM PAYMENT;
    END IF;

    --Discount
    SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'DISCOUNT';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: DISCOUNT Already exists, deleting rows');
        DELETE FROM DISCOUNT;
    END IF;

    --Seat
    SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'SEAT';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: SEAT Already exists, deleting rows');
        DELETE FROM SEAT;
    END IF;

    --Price_Catalog
    SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'PRICE_CATALOG';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: PRICE_CATALOG Already exists, deleting rows');
        DELETE FROM PRICE_CATALOG;
    END IF;

    --Section_Category
    SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'SECTION_CATEGORY';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: SECTION_CATEGORY Already exists, deleting rows');
        DELETE FROM SECTION_CATEGORY;
    END IF;

    --Customer
    SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'CUSTOMER';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: CUSTOMER Already exists, deleting rows');
        DELETE FROM CUSTOMER;
    END IF;

    --Section
    SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'SECTION';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: SECTION Already exists, deleting rows');
        DELETE FROM SECTION;
    END IF;

    --Category
    SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'CATEGORY';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: CATEGORY Already exists, deleting rows');
        DELETE FROM CATEGORY;
    END IF;

    --Match
    SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'MATCH';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: MATCH Already exists, deleting rows');
        DELETE FROM MATCH;
    END IF;
END;
/

-- Section table
INSERT INTO Section (section_id, section_name, gate_name, gate_street, gate_city, gate_state, gate_pincode)
VALUES (1, 'North', 'G1', 'Park Drive', 'Boston', 'MA', 2216);
INSERT INTO Section (section_id, section_name, gate_name, gate_street, gate_city, gate_state, gate_pincode)
VALUES (2, 'South', 'G2', 'Fenway', 'Boston', 'MA', 2216);
INSERT INTO Section (section_id, section_name, gate_name, gate_street, gate_city, gate_state, gate_pincode)
VALUES (3, 'East', 'G3', 'Kenmore', 'Boston', 'MA', 2216);
INSERT INTO Section (section_id, section_name, gate_name, gate_street, gate_city, gate_state, gate_pincode)
VALUES (4, 'West', 'G4', 'Jersey St', 'Boston', 'MA', 2216);

-- Category table
INSERT INTO Category (category_id, category_name)
VALUES (1, 'General');
INSERT INTO Category (category_id, category_name)
VALUES (2, 'Silver');
INSERT INTO Category (category_id, category_name)
VALUES (3, 'Gold');
INSERT INTO Category (category_id, category_name)
VALUES (4, 'VIP');

-- Section_Catehory table
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (1, 1, 1);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (2, 1, 2);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (3, 1, 3);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (4, 1, 4);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (5, 2, 1);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (6, 2, 2);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (7, 2, 3);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (8, 2, 4);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (9, 3, 1);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (10, 3, 2);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (11, 3, 3);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (12, 3, 4);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (13, 4, 1);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (14, 4, 2);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (15, 4, 3);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (16, 4, 4);

-- Seat table
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(1,1,'A',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(2,1,'A',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(3,1,'A',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(4,1,'A',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(5,1,'A',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(6,1,'B',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(7,1,'B',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(8,1,'B',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(9,1,'B',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(10,1,'B',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(11,2,'A',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(12,2,'A',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(13,2,'A',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(14,2,'A',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(15,2,'A',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(16,2,'B',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(17,2,'B',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(18,2,'B',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(19,2,'B',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(20,2,'B',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(21,3,'A',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(22,3,'A',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(23,3,'A',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(24,3,'A',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(25,3,'A',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(26,3,'B',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(27,3,'B',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(28,3,'B',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(29,3,'B',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(30,3,'B',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(31,4,'A',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(32,4,'A',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(33,4,'A',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(34,4,'A',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(35,4,'A',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(36,4,'B',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(37,4,'B',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(38,4,'B',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(39,4,'B',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(40,4,'B',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(41,5,'A',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(42,5,'A',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(43,5,'A',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(44,5,'A',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(45,5,'A',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(46,5,'B',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(47,5,'B',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(48,5,'B',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(49,5,'B',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(50,5,'B',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(51,6,'A',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(52,6,'A',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(53,6,'A',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(54,6,'A',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(55,6,'A',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(56,6,'B',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(57,6,'B',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(58,6,'B',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(59,6,'B',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(60,6,'B',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(61,7,'A',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(62,7,'A',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(63,7,'A',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(64,7,'A',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(65,7,'A',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(66,7,'B',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(67,7,'B',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(68,7,'B',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(69,7,'B',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(70,7,'B',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(71,8,'A',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(72,8,'A',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(73,8,'A',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(74,8,'A',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(75,8,'A',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(76,8,'B',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(77,8,'B',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(78,8,'B',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(79,8,'B',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(80,8,'B',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(81,9,'A',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(82,9,'A',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(83,9,'A',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(84,9,'A',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(85,9,'A',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(86,9,'B',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(87,9,'B',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(88,9,'B',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(89,9,'B',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(90,9,'B',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(91,10,'A',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(92,10,'A',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(93,10,'A',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(94,10,'A',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(95,10,'A',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(96,10,'B',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(97,10,'B',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(98,10,'B',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(99,10,'B',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(100,10,'B',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(101,11,'A',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(102,11,'A',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(103,11,'A',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(104,11,'A',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(105,11,'A',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(106,11,'B',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(107,11,'B',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(108,11,'B',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(109,11,'B',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(110,11,'B',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(111,12,'A',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(112,12,'A',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(113,12,'A',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(114,12,'A',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(115,12,'A',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(116,12,'B',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(117,12,'B',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(118,12,'B',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(119,12,'B',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(120,12,'B',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(121,13,'A',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(122,13,'A',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(123,13,'A',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(124,13,'A',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(125,13,'A',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(126,13,'B',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(127,13,'B',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(128,13,'B',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(129,13,'B',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(130,13,'B',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(131,14,'A',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(132,14,'A',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(133,14,'A',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(134,14,'A',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(135,14,'A',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(136,14,'B',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(137,14,'B',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(138,14,'B',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(139,14,'B',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(140,14,'B',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(141,15,'A',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(142,15,'A',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(143,15,'A',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(144,15,'A',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(145,15,'A',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(146,15,'B',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(147,15,'B',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(148,15,'B',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(149,15,'B',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(150,15,'B',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(151,16,'A',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(152,16,'A',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(153,16,'A',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(154,16,'A',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(155,16,'A',5);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(156,16,'B',1);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(157,16,'B',2);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(158,16,'B',3);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(159,16,'B',4);
INSERT INTO seat (seat_id,sc_id,seat_row,seat_no)
Values(160,16,'B',5);


-- Match table
INSERT INTO match (match_id, league_name, team1, team2, m_start_time, m_end_time, match_active)
VALUES (1,'T20','India','Pakistan', TO_DATE('2022-11-01 10:00:00','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2022-11-01 14:00:00','yyyy-mm-dd hh24:mi:ss'),'Y');
INSERT INTO match (match_id, league_name, team1, team2, m_start_time, m_end_time, match_active)
VALUES (2,'T20','Australia','New Zealand', TO_DATE('2022-12-20 10:00:00','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2022-12-20 14:00:00','yyyy-mm-dd hh24:mi:ss'),'Y');
INSERT INTO match (match_id, league_name, team1, team2, m_start_time, m_end_time, match_active)
VALUES (3,'IPL','Mumbai','Chennai', TO_DATE('2023-01-03 10:00:00','yyyy-mm-dd hh24:mi:ss'),TO_DATE('2023-01-03 14:00:00','yyyy-mm-dd hh24:mi:ss'),'Y');

-- Price_Catalog table
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (1,1,1,5);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (2,1,2,10);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (3,1,3,15);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (4,1,4,30);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (5,1,5,5);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (6,1,6,10);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (7,1,7,15);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (8,1,8,30);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (9,1,9,5);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (10,1,10,10);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (11,1,11,15);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (12,1,12,30);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (13,1,13,5);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (14,1,14,10);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (15,1,15,15);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (16,1,16,30);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (17,2,1,5);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (18,2,2,10);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (19,2,3,15);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (20,2,4,30);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (21,2,5,5);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (22,2,6,10);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (23,2,7,15);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (24,2,8,30);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (25,2,9,5);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (26,2,10,10);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (27,2,11,15);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (28,2,12,30);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (29,2,13,5);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (30,2,14,10);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (31,2,15,15);
INSERT INTO price_catalog (pc_id, match_id, sc_id, amount)
VALUES (32,2,16,30);

-- Customer table
INSERT INTO customer (cust_id,cust_fname,cust_lname,cust_email,cust_contact,cust_dob,cust_street,cust_city,cust_state,cust_pincode)
Values(1,'Aditya','Kawale','ak@mail.com','1231237890',TO_DATE('1999-02-18','yyyy-mm-dd'),'#123 PD','Boston','MA',02215);
INSERT INTO customer (cust_id,cust_fname,cust_lname,cust_email,cust_contact,cust_dob,cust_street,cust_city,cust_state,cust_pincode)
Values(2,'Anish','Navale','an@gmail.com','1231239999',TO_DATE('2000-01-08','yyyy-mm-dd'),'#456 KM','Boston','MA',02216);
INSERT INTO customer (cust_id,cust_fname,cust_lname,cust_email,cust_contact,cust_dob,cust_street,cust_city,cust_state,cust_pincode)
Values(3,'Sweta','Mishra','sm@mail.com','1231236490',TO_DATE('1999-07-28','yyyy-mm-dd'),'#123 irf','Boston','MA',02215);
INSERT INTO customer (cust_id,cust_fname,cust_lname,cust_email,cust_contact,cust_dob,cust_street,cust_city,cust_state,cust_pincode)
Values(4,'Sejal','Deopura','sd@gmail.com','8971239999',TO_DATE('2000-11-18','yyyy-mm-dd'),'#456 mnkj','Boston','MA',02216);

-- Discount table
INSERT INTO Discount (discount_id, coupon_name, discount_perc, d_start_date, d_end_date)
VALUES (1, 'Thanksgiving', 10, TO_DATE('2022-11-21 00:00:00','yyyy-mm-dd hh24:mi:ss'), TO_DATE('2022-11-24 23:59:59','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Discount (discount_id, coupon_name, discount_perc, d_start_date, d_end_date)
VALUES (2, 'BlackFriday', 25, TO_DATE('2022-11-25 00:00:00','yyyy-mm-dd hh24:mi:ss'), TO_DATE('2022-11-27 23:59:59','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Discount (discount_id, coupon_name, discount_perc, d_start_date, d_end_date)
VALUES (3, 'Christmas', 15, TO_DATE('2022-12-25 00:00:00','yyyy-mm-dd hh24:mi:ss'), TO_DATE('2022-12-26 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Discount (discount_id, coupon_name, discount_perc, d_start_date, d_end_date)
VALUES (4, 'NewYear', 10, TO_DATE('2023-01-01 00:00:00','yyyy-mm-dd hh24:mi:ss'), TO_DATE('2023-01-02 00:00:00','yyyy-mm-dd hh24:mi:ss'));

-- Payment table
INSERT INTO payment (payment_id, discount_id, tot_amount, p_date_time, payment_mode)
VALUES (1,NULL,100,TO_DATE('2022-10-05 11:30:00','yyyy-mm-dd hh24:mi:ss'),'Online');
INSERT INTO payment (payment_id, discount_id, tot_amount, p_date_time, payment_mode)
VALUES (2,NULL,150,TO_DATE('2022-10-12 11:30:00','yyyy-mm-dd hh24:mi:ss'),'Online');
INSERT INTO payment (payment_id, discount_id, tot_amount, p_date_time, payment_mode)
VALUES (3,NULL,30,TO_DATE('2022-10-15 11:30:00','yyyy-mm-dd hh24:mi:ss'),'Online');
INSERT INTO payment (payment_id, discount_id, tot_amount, p_date_time, payment_mode)
VALUES (4,NULL,100,TO_DATE('2022-11-24 11:30:00','yyyy-mm-dd hh24:mi:ss'),'Online');
INSERT INTO payment (payment_id, discount_id, tot_amount, p_date_time, payment_mode)
VALUES (5,1,9,TO_DATE('2022-11-20 11:30:00','yyyy-mm-dd hh24:mi:ss'),'Online');
INSERT INTO payment (payment_id, discount_id, tot_amount, p_date_time, payment_mode)
VALUES (6,1,9,TO_DATE('2022-11-24 11:30:00','yyyy-mm-dd hh24:mi:ss'),'Online');

-- Refund Table
INSERT INTO Refund (rfd_id, rfd_reason, r_date_time)
 VALUES (1, 'Unable to attend',  TO_DATE('2022-11-24 12:30:00','yyyy-mm-dd hh24:mi:ss'));

-- Ticket table
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (1,1,1,NULL,1,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (2,1,2,NULL,1,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (3,1,3,NULL,1,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (4,1,4,NULL,1,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (5,1,5,NULL,1,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (6,1,6,NULL,1,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (7,1,7,NULL,1,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (8,1,8,NULL,1,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (9,1,9,NULL,1,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (10,1,10,NULL,1,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (11,2,31,NULL,2,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (12,2,32,NULL,2,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (13,2,33,NULL,2,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (14,2,34,NULL,2,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (15,2,35,NULL,2,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (16,3,149,NULL,3,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (17,3,150,NULL,3,1);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (18,1,1,NULL,4,2);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (19,1,2,NULL,4,2);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (20,1,3,NULL,4,2);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (21,1,4,NULL,4,2);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (22,1,5,NULL,4,2);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (23,1,6,NULL,4,2);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (24,1,7,NULL,4,2);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (25,1,8,NULL,4,2);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (26,1,9,NULL,4,2);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (27,1,10,NULL,4,2);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (28,3,140,1,5,2);
INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
VALUES (29,2,140,NULL,6,2);

-- Verification Table
INSERT INTO Verification (ticket_id, v_date_time)
VALUES (1, TO_DATE('2022-11-01 09:30:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Verification (ticket_id, v_date_time)
VALUES (2, TO_DATE('2022-11-01 09:31:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Verification (ticket_id, v_date_time)
VALUES (3, TO_DATE('2022-11-01 09:32:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Verification (ticket_id, v_date_time)
VALUES (4, TO_DATE('2022-11-01 09:33:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Verification (ticket_id, v_date_time)
VALUES (5, TO_DATE('2022-11-01 09:34:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Verification (ticket_id, v_date_time)
VALUES (6, TO_DATE('2022-11-01 09:35:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Verification (ticket_id, v_date_time)
VALUES (7, TO_DATE('2022-11-01 09:36:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Verification (ticket_id, v_date_time)
VALUES (8, TO_DATE('2022-11-01 09:37:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Verification (ticket_id, v_date_time)
VALUES (9, TO_DATE('2022-11-01 09:38:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Verification (ticket_id, v_date_time)
VALUES (10, TO_DATE('2022-11-01 09:39:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Verification (ticket_id, v_date_time)
VALUES (11, TO_DATE('2022-11-01 09:40:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Verification (ticket_id, v_date_time)
VALUES (12, TO_DATE('2022-11-01 09:41:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Verification (ticket_id, v_date_time)
VALUES (13, TO_DATE('2022-11-01 09:42:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Verification (ticket_id, v_date_time)
VALUES (14, TO_DATE('2022-11-01 09:43:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Verification (ticket_id, v_date_time)
VALUES (15, TO_DATE('2022-11-01 09:44:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Verification (ticket_id, v_date_time)
VALUES (16, TO_DATE('2022-11-01 09:45:00','yyyy-mm-dd hh24:mi:ss'));

commit;