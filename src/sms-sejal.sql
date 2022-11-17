create table refund(
rfd_id number(20) NOT NULL,
rfd_reason varchar(255),
r_date_time date
);

create table verification(
ticket_id number(20) NOT NULL,
v_date_time date NOT NULL
);

create table discount(
discount_id number(20) NOT NULL,
coupon_name varchar(30),
discount_perc number(3),
d_start_date date,
d_end_date date);


