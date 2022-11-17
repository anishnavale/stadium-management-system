/*select * from session_privs;
select * from session_roles;
drop table verification;
drop table ticket;
drop table refund;
drop table customer;
drop table payment;
drop table discount;
drop table seat;
drop table price_catalog;
drop table match;
drop table section_category;
drop table section;
drop table category;
*/



PURGE RECYCLEBIN;

SET SERVEROUTPUT ON;

DECLARE
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from user_tables where table_name='VERIFICATION';
    IF IS_TRUE > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE verification';
    END IF;
END;
/

DECLARE
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from user_tables where table_name='TICKET';
    IF IS_TRUE > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE ticket';
    END IF;
END;
/

DECLARE
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from user_tables where table_name='REFUND';
    IF IS_TRUE > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE refund';
    END IF;
END;
/

DECLARE
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from user_tables where table_name='PAYMENT';
    IF IS_TRUE > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE payment';
    END IF;
END;
/

DECLARE
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from user_tables where table_name='DISCOUNT';
    IF IS_TRUE > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE discount';
    END IF;
END;
/

DECLARE
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from user_tables where table_name='SEAT';
    IF IS_TRUE > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE seat';
    END IF;
END;
/

DECLARE
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from user_tables where table_name='PRICE_CATALOG';
    IF IS_TRUE > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE price_catalog';
    END IF;
END;
/

DECLARE
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from user_tables where table_name='SECTION_CATEGORY';
    IF IS_TRUE > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE section_category';
    END IF;
END;
/

DECLARE
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from user_tables where table_name='CUSTOMER';
    IF IS_TRUE > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE customer';
    END IF;
END;
/

DECLARE
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from user_tables where table_name='SECTION';
    IF IS_TRUE > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE section';
    END IF;
END;
/

DECLARE
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from user_tables where table_name='CATEGORY';
    IF IS_TRUE > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE category';
    END IF;
END;
/

DECLARE
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from user_tables where table_name='MATCH';
    IF IS_TRUE > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE match';
    END IF;
END;
/

-- Create table section
create table section (
section_id number(20),
section_name varchar(30),
gate_name varchar(30),
gate_street varchar(100),
gate_city varchar(50),
gate_state varchar(50),
gate_pincode number(10)
);

-- Create Primary Key constraint for section_id in section table
ALTER TABLE section
ADD CONSTRAINT PK_section_id Primary key (section_id);

-- Create Not Null constraint for section_name in section table
ALTER TABLE section
MODIFY (section_name varchar(30) CONSTRAINT NN_section_name NOT NULL);

-- Create table category
create table category (
category_id number(20),
category_name varchar(30)
);

-- Create Primary Key constraint for category_id in category table
ALTER TABLE category
ADD CONSTRAINT PK_category_id Primary key (category_id);

-- Create Not Null constraint for category_name in category table
ALTER TABLE category
MODIFY (category_name varchar(30) CONSTRAINT NN_category_name NOT NULL);

-- Create table section_category
create table section_category (
sc_id number(20),
section_id number(20),
category_id number(20)
);

-- Create Primary Key constraint for sc_id in section_category table
ALTER TABLE section_category
ADD CONSTRAINT PK_sc_id Primary key (sc_id);

-- Create Foreign Key constraint for section_id in section_category table
ALTER TABLE section_category
ADD CONSTRAINT FK_section_id foreign key (section_id) references section (section_id);

-- Create Foreign Key constraint for category_id in section_category table
ALTER TABLE section_category
ADD CONSTRAINT FK_category_id foreign key (category_id) references category (category_id);

-- Create table seat
create table seat(
seat_id number(20),
sc_id number(20),
seat_row number(3),
seat_no number(3)
);

-- Create Primary Key constraint for seat_id in seat table
ALTER TABLE seat
ADD CONSTRAINT PK_seat_id Primary key (seat_id);

-- Create Foreign Key constraint for sc_id in seat table
ALTER TABLE seat
ADD CONSTRAINT FK_SC_id foreign key (sc_id) references section_category (sc_id);

-- Create Not Null constraint for sc_id in seat table
ALTER TABLE seat
MODIFY (sc_id number(20) CONSTRAINT NN_sc_id NOT NULL);

-- Create table match
create table match(
match_id number(20),
league_name varchar(30),
team1 varchar(30),
team2 varchar(30),
m_start_time timestamp,
m_end_time timestamp 
);

-- Create Primary Key constraint for match_id in match table
ALTER TABLE match
ADD CONSTRAINT PK_match_id Primary key (match_id);

-- Create table price_catalog
create table price_catalog(
pc_id number(20),
match_id number(20),
sc_id number(20),
amount number(5,2)
);

-- Create Primary Key constraint for pc_id in price_catalog table
ALTER TABLE price_catalog
ADD CONSTRAINT PK_pc_id Primary key (pc_id);

-- Create Foreign Key constraint for match_id in price_catalog table
ALTER TABLE price_catalog
ADD CONSTRAINT FK_match_id foreign key (match_id) references match (match_id);

-- Create Foreign Key constraint for sc_id in price_catalog table
ALTER TABLE price_catalog
ADD CONSTRAINT FK_sc_id1 foreign key (sc_id) references section_category (sc_id);

-- Create table refund
create table refund(
rfd_id number(20),
rfd_reason varchar(255),
r_date_time timestamp
);

-- Create Primary Key constraint for rfd_id in refund table
ALTER TABLE refund
ADD CONSTRAINT PK_rfd_id Primary key (rfd_id);

-- Create table customer
create table customer(
cust_id number(20),
cust_fname varchar(30),
cust_lname varchar(30),
cust_email varchar2(50),
cust_contact varchar(10),
cust_DOB date,
cust_street varchar(100),
cust_city varchar(50),
cust_state varchar(50),
cust_pincode number(10)
);

-- Create Primary Key constraint for rfd_id in refund table
ALTER TABLE customer
ADD CONSTRAINT PK_cust_id Primary key (cust_id);

-- Create table discount
create table discount(
discount_id number(20),
coupon_name varchar(30),
discount_perc number(3),
d_start_date timestamp,
d_end_date timestamp
);

-- Create Primary Key constraint for rfd_id in refund table
ALTER TABLE discount
ADD CONSTRAINT PK_discount_id Primary key (discount_id);

-- Create table payment
create table payment(
payment_id number(20),
discount_id number(20),
tot_amount number(10,2),
p_date_time timestamp,
payment_mode varchar(30)
);

-- Create Primary Key constraint for payment_id in payment table
ALTER TABLE payment
ADD CONSTRAINT PK_payment_id Primary key (payment_id);

-- Create Foreign Key constraint for discount_id in payment table
ALTER TABLE payment
ADD CONSTRAINT FK_discount_id foreign key (discount_id) references discount (discount_id);

-- Create table ticket
create table ticket(
ticket_id number(20),
cust_id number(20),
seat_id number(20),
rfd_id number(20),
payment_id number(20),
match_id number(20)
);

-- Create Primary Key constraint for ticket_id in ticket table
ALTER TABLE ticket
ADD CONSTRAINT PK_ticket_id Primary key (ticket_id);

-- Create Foreign Key constraint for cust_id in ticket table
ALTER TABLE ticket
ADD CONSTRAINT FK_cust_id foreign key (cust_id) references customer (cust_id);

-- Create Foreign Key constraint for seat_id in ticket table
ALTER TABLE ticket
ADD CONSTRAINT FK_seat_id foreign key (seat_id) references seat (seat_id);

-- Create Foreign Key constraint for rfd_id in ticket table
ALTER TABLE ticket
ADD CONSTRAINT FK_rfd_id foreign key (rfd_id) references refund (rfd_id);

-- Create Foreign Key constraint for payment_id in ticket table
ALTER TABLE ticket
ADD CONSTRAINT FK_payment_id foreign key (payment_id) references payment (payment_id);

-- Create Foreign Key constraint for match_id in ticket table
ALTER TABLE ticket
ADD CONSTRAINT FK_match_id1 foreign key (match_id) references match (match_id);

-- Create table verification
create table verification(
ticket_id number(20),
v_date_time timestamp
);

-- Create Foreign Key constraint for ticket_id in verification table
ALTER TABLE verification
ADD CONSTRAINT FK_ticket_id foreign key (ticket_id) references ticket (ticket_id);

-- Create Not Null constraint for _date_time in verification table
ALTER TABLE verification
MODIFY (v_date_time timestamp CONSTRAINT NN_v_date_time NOT NULL);



