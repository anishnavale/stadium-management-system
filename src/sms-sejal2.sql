
create table discount(
discount_id number(20) NOT NULL,
coupon_name varchar(30),
discount_perc number(3),
d_start_time timestamp,
d_end_time timestamp);



INSERT INTO Discount (discount_id, coupon_name, discount_perc, d_start_time, d_end_time)
VALUES (1, 'Diwali', 10, TO_DATE('2021-08-01 10:00:01','yyyy-mm-dd hh24:mi:ss'), TO_DATE('2021-11-30 10:00:01','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Discount (discount_id, coupon_name, discount_perc, d_start_time, d_end_time)
VALUES (2, 'Holi', 12, TO_DATE('2021-03-01 10:00:01','yyyy-mm-dd hh24:mi:ss'), TO_DATE('2021-03-15 10:00:01','yyyy-mm-dd hh24:mi:ss'));


create table verification(
ticket_id number(20) NOT NULL,
v_date_time timestamp NOT NULL
);


INSERT INTO Verification (ticket_id, v_date_time)
VALUES (1, TO_DATE('2022-01-01 09:30:00','yyyy-mm-dd hh24:mi:ss'));

select * from verification;


create table refund(
rfd_id number(20) NOT NULL,
rfd_reason varchar(255),
r_date_time timestamp
);

INSERT INTO Refund (rfd_id, rfd_reason, r_date_time)
VALUES (1, 'Unable to attend',  TO_DATE('2022-08-16 12:30:00','yyyy-mm-dd hh24:mi:ss'));

select * from refund;

create table section_category (
sc_id number(20),
section_id number(20),
category_id number(20)
);

INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (1, 1, 1);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (2, 1, 2);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (3, 2, 1);
INSERT INTO Section_Category (sc_id, section_id, category_id)
VALUES (4, 2, 2);

select * from Section_Category;

create table category (
category_id number(20),
category_name varchar(30)
);


INSERT INTO Category (category_id, category_name)
VALUES (1, 'General');
INSERT INTO Category (category_id, category_name)
VALUES (2, 'VIP');

select * from Category;

create table section (
section_id number(20),
section_name varchar(30),
gate_name varchar(30),
gate_street varchar(100),
gate_city varchar(50),
gate_state varchar(50),
gate_pincode number(10)
);

INSERT INTO Section (section_id, section_name, gate_name, gate_street, gate_city, gate_state, gate_pincode)
VALUES (1, 'North', '1', 'Park Drive', 'Boston', 'MA', '2216');
INSERT INTO Section (section_id, section_name, gate_name, gate_street, gate_city, gate_state, gate_pincode)
VALUES (2, 'South', '2', 'Fenway', 'Boston', 'MA', '2216' );

select * from Section;



