--#15 DDL - Ticket, User, Seat

--Ticket
--ticket_id	user_id	match_id	seat_id	payment_id	rfd_id
create table ticket(
ticket_id number(20) NOT NULL,
user_id number(20) NOT NULL,
seat_id number(20) NOT NULL,
rfd_id number(20) ,
payment_id number(20) NOT NULL,
match_id number(20) NOT NULL
);

--User)
create table customer(
user_id number(20) not null,
user_fname varchar(30),
user_lname varchar(30),
user_email varchar2(50),
user_contact varchar(10),
user_DOB date,
user_street varchar(100),
user_city varchar(50),
user_state varchar(50),
user_pincode number(10)
);
--seat

create table seat(
seat_id number(20) not null,
seat_row number(3),
seat_no number(3)
);

desc ticket;
desc customer;
desc seat;

drop table ticket;
drop table customer;
drop table seat;