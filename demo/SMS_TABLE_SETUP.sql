/*

TABLES SETUP

*/

--Author: Aditya, Anish, Sweta, Sejal
--Comments: Script to create SMS Related tables
--          Note: Run this script logged in as 'APP_ADMIN' user for Oracle Autonomous Database

SET SERVEROUTPUT ON;
PURGE RECYCLEBIN;

--Table : Check Drop Recreate
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
        dbms_output.put_line('Table: VERIFICATION Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE VERIFICATION';
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
        dbms_output.put_line('Table: TICKET Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE TICKET';
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
        dbms_output.put_line('Table: REFUND Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE REFUND';
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
        dbms_output.put_line('Table: PAYMENT Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE PAYMENT';
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
        dbms_output.put_line('Table: DISCOUNT Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE DISCOUNT';
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
        dbms_output.put_line('Table: SEAT Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE SEAT';
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
        dbms_output.put_line('Table: PRICE_CATALOG Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE PRICE_CATALOG';
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
        dbms_output.put_line('Table: SECTION_CATEGORY Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE SECTION_CATEGORY';
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
        dbms_output.put_line('Table: CUSTOMER Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE CUSTOMER';
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
        dbms_output.put_line('Table: SECTION Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE SECTION';
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
        dbms_output.put_line('Table: CATEGORY Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE CATEGORY';
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
        dbms_output.put_line('Table: MATCH Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE MATCH';
    END IF;
END;
/

BEGIN
    dbms_output.put_line('---------------------------');
    dbms_output.put_line('TRYING TO CREATE TABLES');
    dbms_output.put_line('---------------------------');
END;
/

-- Create table section
CREATE TABLE section (
    section_id   NUMBER(20),
    section_name VARCHAR(30),
    gate_name    VARCHAR(30),
    gate_street  VARCHAR(100),
    gate_city    VARCHAR(50),
    gate_state   VARCHAR(50),
    gate_pincode NUMBER(10)
);

-- Create Primary Key constraint for section_id in section table
ALTER TABLE section ADD CONSTRAINT pk_sec_section_id PRIMARY KEY ( section_id );

-- Create Not Null constraint for section_name in section table
ALTER TABLE section MODIFY (
    section_name VARCHAR(30)
        CONSTRAINT nn_sec_section_name NOT NULL
);

-- Create Not Null constraint for gate_name in section table
ALTER TABLE section MODIFY (
    gate_name VARCHAR(30)
        CONSTRAINT nn_sec_gate_name NOT NULL
);

-- Create Not Null constraint for gate_street in section table
ALTER TABLE section MODIFY (
    gate_street VARCHAR(100)
        CONSTRAINT nn_sec_gate_street NOT NULL
);

-- Create Not Null constraint for gate_city in section table
ALTER TABLE section MODIFY (
    gate_city VARCHAR(50)
        CONSTRAINT nn_sec_gate_city NOT NULL
);

-- Create Not Null constraint for gate_state in section table
ALTER TABLE section MODIFY (
    gate_state VARCHAR(50)
        CONSTRAINT nn_sec_gate_state NOT NULL
);

-- Create Not Null constraint for gate_pincode in section table
ALTER TABLE section MODIFY (
    gate_pincode VARCHAR(10)
        CONSTRAINT nn_sec_gate_pincode NOT NULL
);

-- Create table category
CREATE TABLE category (
    category_id   NUMBER(20),
    category_name VARCHAR(30)
);

-- Create Primary Key constraint for category_id in category table
ALTER TABLE category ADD CONSTRAINT pk_cat_category_id PRIMARY KEY ( category_id );

-- Create Not Null constraint for category_name in category table
ALTER TABLE category MODIFY (
    category_name VARCHAR(30)
        CONSTRAINT nn_cat_category_name NOT NULL
);

-- Create Unique constraint for category_name in category table
ALTER TABLE category MODIFY (
    category_name VARCHAR(30)
        CONSTRAINT un_cat_category_name UNIQUE
);

-- Create table section_category
CREATE TABLE section_category (
    sc_id       NUMBER(20),
    section_id  NUMBER(20),
    category_id NUMBER(20)
);

-- Create Primary Key constraint for sc_id in section_category table
ALTER TABLE section_category ADD CONSTRAINT pk_sc_sc_id PRIMARY KEY ( sc_id );

-- Create Foreign Key constraint for section_id in section_category table
ALTER TABLE section_category
    ADD CONSTRAINT fk_sc_section_id FOREIGN KEY ( section_id )
        REFERENCES section ( section_id );

-- Create Foreign Key constraint for category_id in section_category table
ALTER TABLE section_category
    ADD CONSTRAINT fk_sc_category_id FOREIGN KEY ( category_id )
        REFERENCES category ( category_id );


-- Create table seat
CREATE TABLE seat (
    seat_id  NUMBER(20),
    sc_id    NUMBER(20),
    seat_row VARCHAR(3), 
    seat_no  NUMBER(3)
);

-- Create Primary Key constraint for seat_id in seat table
ALTER TABLE seat ADD CONSTRAINT pk_sea_seat_id PRIMARY KEY ( seat_id );

-- Create Foreign Key constraint for sc_id in seat table
ALTER TABLE seat
    ADD CONSTRAINT fk_sea_sc_id FOREIGN KEY ( sc_id )
        REFERENCES section_category ( sc_id );

-- Create Not Null constraint for sc_id in seat table
ALTER TABLE seat MODIFY (
    sc_id NUMBER(20)
        CONSTRAINT nn_sea_sc_id NOT NULL
);

-- Create Not Null constraint for seat_row in seat table
ALTER TABLE seat MODIFY (
    seat_row VARCHAR(3)
        CONSTRAINT nn_sea_seat_row NOT NULL
);

-- Create Not Null constraint for seat_no in seat table
ALTER TABLE seat MODIFY (
    seat_no NUMBER(3)
        CONSTRAINT nn_sea_seat_no NOT NULL
);

-- Create table match
CREATE TABLE match (
    match_id     NUMBER(20),
    league_name  VARCHAR(30),
    team1        VARCHAR(30),
    team2        VARCHAR(30),
    m_start_time TIMESTAMP,
    m_end_time   TIMESTAMP,
    match_active VARCHAR(1) 
);

-- Create Primary Key constraint for match_id in match table
ALTER TABLE match ADD CONSTRAINT pk_mat_match_id PRIMARY KEY ( match_id );


-- Create Check constraint for match_active in match table
ALTER TABLE match MODIFY (
    match_active VARCHAR(1)
        CONSTRAINT chk_mat_match_active CHECK (match_active IN ('Y', 'N'))
);

-- Create table price_catalog
CREATE TABLE price_catalog (
    pc_id    NUMBER(20),
    match_id NUMBER(20),
    sc_id    NUMBER(20),
    amount   NUMBER(5, 2)
);

-- Create Primary Key constraint for pc_id in price_catalog table
ALTER TABLE price_catalog ADD CONSTRAINT pk_pc_pc_id PRIMARY KEY ( pc_id );

-- Create Foreign Key constraint for match_id in price_catalog table
ALTER TABLE price_catalog
    ADD CONSTRAINT fk_pc_match_id FOREIGN KEY ( match_id )
        REFERENCES match ( match_id );

-- Create Foreign Key constraint for sc_id in price_catalog table
ALTER TABLE price_catalog
    ADD CONSTRAINT fk_pc_sc_id FOREIGN KEY ( sc_id )
        REFERENCES section_category ( sc_id );
        

-- Create Check constraint for amount in price_catalog table
ALTER TABLE price_catalog MODIFY (
    amount NUMBER(5,2)
        CONSTRAINT chk_pc_amount CHECK (amount >=0 )
);

-- Create table refund
CREATE TABLE refund (
    rfd_id      NUMBER(20),
    rfd_reason  VARCHAR(255),
    r_date_time TIMESTAMP
);

-- Create Primary Key constraint for rfd_id in refund table
ALTER TABLE refund ADD CONSTRAINT pk_rfd_id PRIMARY KEY ( rfd_id );

-- Create Not Null constraint for r_date_time in refund table
ALTER TABLE refund MODIFY (
    r_date_time TIMESTAMP
        CONSTRAINT nn_ref_r_date_time NOT NULL
);

-- Create table customer
CREATE TABLE customer (
    cust_id      NUMBER(20),
    cust_fname   VARCHAR(30),
    cust_lname   VARCHAR(30),
    cust_email   VARCHAR2(50),
    cust_contact VARCHAR(10),
    cust_dob     DATE,
    cust_street  VARCHAR(100),
    cust_city    VARCHAR(50),
    cust_state   VARCHAR(50),
    cust_pincode NUMBER(10)
);

-- Create Primary Key constraint for cust_id in customer table
ALTER TABLE customer ADD CONSTRAINT pk_cus_cust_id PRIMARY KEY ( cust_id );

-- Create Not Null constraint for cust_fname in customer table
ALTER TABLE customer MODIFY (
    cust_fname VARCHAR(30)
        CONSTRAINT nn_cus_cust_fname NOT NULL
);

-- Create Not Null constraint for cust_lname in customer table
ALTER TABLE customer MODIFY (
    cust_lname VARCHAR(30)
        CONSTRAINT nn_cus_cust_lname NOT NULL
);

-- Create Not Null constraint for cust_email in customer table
ALTER TABLE customer MODIFY (
    cust_email VARCHAR2(50)
        CONSTRAINT nn_cus_cust_email NOT NULL
);

-- Create Unique constraint for cust_email in customer table
ALTER TABLE customer MODIFY (
    cust_email VARCHAR2(50)
        CONSTRAINT un_cus_cust_email UNIQUE
);

-- Create table discount
CREATE TABLE discount (
    discount_id   NUMBER(20),
    coupon_name   VARCHAR(30),
    discount_perc NUMBER(3),
    d_start_date  TIMESTAMP,
    d_end_date    TIMESTAMP
);

-- Create Primary Key constraint for discount_id in discount table
ALTER TABLE discount ADD CONSTRAINT pk_dis_discount_id PRIMARY KEY ( discount_id );

-- Create Not Null constraint for coupon_name in discount table
ALTER TABLE discount MODIFY (
    coupon_name VARCHAR(30)
        CONSTRAINT nn_dis_coupon_name NOT NULL
);

-- Create Not Null constraint for discount_perc in discount table
ALTER TABLE discount MODIFY (
    discount_perc NUMBER(3)
        CONSTRAINT nn_dis_discount_perc NOT NULL
);

-- Create Check constraint for discount_perc in discount table
ALTER TABLE discount MODIFY (
    discount_perc NUMBER(3)
        CONSTRAINT chk_dis_discount_perc CHECK (discount_perc between 1 and 100)
);

-- Create Not Null constraint for d_start_date in discount table
ALTER TABLE discount MODIFY (
    d_start_date TIMESTAMP
        CONSTRAINT nn_dis_d_start_date NOT NULL
);

-- Create Not Null constraint for d_end_date in discount table
ALTER TABLE discount MODIFY (
    d_end_date TIMESTAMP
        CONSTRAINT nn_dis_d_end_date NOT NULL
);

-- Create table payment
CREATE TABLE payment (
    payment_id   NUMBER(20),
    discount_id  NUMBER(20),
    tot_amount   NUMBER(10, 2),
    p_date_time  TIMESTAMP,
    payment_mode VARCHAR(30)
);

-- Create Primary Key constraint for payment_id in payment table
ALTER TABLE payment ADD CONSTRAINT pk_pay_payment_id PRIMARY KEY ( payment_id );

-- Create Foreign Key constraint for discount_id in payment table
ALTER TABLE payment
    ADD CONSTRAINT fk_discount_id FOREIGN KEY ( discount_id )
        REFERENCES discount ( discount_id );
        
-- Create Not Null constraint for tot_amount in payment table
ALTER TABLE payment MODIFY (
    tot_amount  NUMBER(10, 2)
        CONSTRAINT nn_pay_tot_amount NOT NULL
);

-- Create Check constraint for tot_amount in payment table
ALTER TABLE payment MODIFY (
    tot_amount  NUMBER(10, 2)
        CONSTRAINT chk_pay_tot_amount CHECK (tot_amount >=0 )
);

-- Create Not Null constraint for p_date_time in payment table
ALTER TABLE payment MODIFY (
    p_date_time TIMESTAMP
        CONSTRAINT nn_pay_p_date_time NOT NULL
);

-- Create Not Null constraint for payment_mode in payment table
ALTER TABLE payment MODIFY (
    payment_mode VARCHAR(30)
        CONSTRAINT nn_pay_payment_mode NOT NULL
);


-- Create table ticket
CREATE TABLE ticket (
    ticket_id  NUMBER(20),
    cust_id    NUMBER(20),
    seat_id    NUMBER(20),
    rfd_id     NUMBER(20),
    payment_id NUMBER(20),
    match_id   NUMBER(20)
);

-- Create Primary Key constraint for ticket_id in ticket table
ALTER TABLE ticket ADD CONSTRAINT pk_tic_ticket_id PRIMARY KEY ( ticket_id );

-- Create Foreign Key constraint for cust_id in ticket table
ALTER TABLE ticket
    ADD CONSTRAINT fk_tic_cust_id FOREIGN KEY ( cust_id )
        REFERENCES customer ( cust_id );

-- Create Foreign Key constraint for seat_id in ticket table
ALTER TABLE ticket
    ADD CONSTRAINT fk_tic_seat_id FOREIGN KEY ( seat_id )
        REFERENCES seat ( seat_id );

-- Create Foreign Key constraint for rfd_id in ticket table
ALTER TABLE ticket
    ADD CONSTRAINT fk_tic_rfd_id FOREIGN KEY ( rfd_id )
        REFERENCES refund ( rfd_id );

-- Create Foreign Key constraint for payment_id in ticket table
ALTER TABLE ticket
    ADD CONSTRAINT fk_tic_payment_id FOREIGN KEY ( payment_id )
        REFERENCES payment ( payment_id );

-- Create Foreign Key constraint for match_id in ticket table
ALTER TABLE ticket
    ADD CONSTRAINT fk_tic_match_id FOREIGN KEY ( match_id )
        REFERENCES match ( match_id );


-- Create table verification
CREATE TABLE verification (
    ticket_id   NUMBER(20),
    v_date_time TIMESTAMP
);

-- Create Foreign Key constraint for ticket_id in verification table
ALTER TABLE verification
    ADD CONSTRAINT fk_ticket_id FOREIGN KEY ( ticket_id )
        REFERENCES ticket ( ticket_id );

-- Create Not Null constraint for v_date_time in verification table
ALTER TABLE verification MODIFY (
    v_date_time TIMESTAMP
        CONSTRAINT nn_v_date_time NOT NULL
);

-- Create Unique constraint for ticket_id in verification table
ALTER TABLE verification MODIFY (
    ticket_id NUMBER(20)
        CONSTRAINT un_ver_ticket_id UNIQUE
);


BEGIN
    dbms_output.put_line('---------------------------');
    dbms_output.put_line('ALL THE SMS RELATED TABLES HAVE BEEN CREATED SUCCESSFULLY');
    dbms_output.put_line('---------------------------');
END;
/