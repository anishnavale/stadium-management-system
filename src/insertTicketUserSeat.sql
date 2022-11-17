--#15 Insert - Ticket, User, Seat
desc ticket;
INSERT INTO ticket (ticket_id, user_id, seat_id, rfd_id, payment_id, match_id)
VALUES (1,1,1,NULL,1,1);

INSERT INTO ticket (ticket_id, user_id, seat_id, rfd_id, payment_id, match_id)
VALUES (2,1,2,NULL,1,1);

INSERT INTO ticket (ticket_id, user_id, seat_id, rfd_id, payment_id, match_id)
VALUES (3,2,3,1,2,1);

INSERT INTO ticket (ticket_id, user_id, seat_id, rfd_id, payment_id, match_id)
VALUES (4,1,3,NULL,3,1);

select * from ticket;
----------------
-- user
desc customer;



INSERT INTO customer (user_id,user_fname,user_lname,user_email,user_contact,user_dob,user_street,user_city,user_state,user_pincode)
Values(1,'Aditya','Kawale','ak@mail.com','1231237890',TO_DATE('1999-02-18','yyyy-mm-dd'),'#123 PD','Boston','MA',02215);

INSERT INTO customer (user_id,user_fname,user_lname,user_email,user_contact,user_dob,user_street,user_city,user_state,user_pincode)
Values(2,'Anish','Navale','an@gmail.com','1231239999',TO_DATE('1999-09-20','yyyy-mm-dd'),'#456 KM','Boston','MA',02216);

select * from customer;

----------------------

--Seat

desc seat;


INSERT INTO seat (seat_id,seat_row,seat_no,sc_id)
Values(1,1,1,1);
INSERT INTO seat (seat_id,seat_row,seat_no,sc_id)
Values(2,1,2,1);
INSERT INTO seat (seat_id,seat_row,seat_no,sc_id)
Values(3,2,1,2);
INSERT INTO seat (seat_id,seat_row,seat_no,sc_id)
Values(4,2,2,2);
INSERT INTO seat (seat_id,seat_row,seat_no,sc_id)
Values(5,1,1,3);
INSERT INTO seat (seat_id,seat_row,seat_no,sc_id)
Values(6,1,2,3);
INSERT INTO seat (seat_id,seat_row,seat_no,sc_id)
Values(7,2,1,4);
INSERT INTO seat (seat_id,seat_row,seat_no,sc_id)
Values(8,2,2,4);

select * from seat;
