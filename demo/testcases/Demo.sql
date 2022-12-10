--Table level access control
grant select on APP_ADMIN_TEST.SECTION to STADIUM_MANAGER_TEST, FINANCE_MANAGER_TEST;
grant select on APP_ADMIN_TEST.CATEGORY to STADIUM_MANAGER_TEST, FINANCE_MANAGER_TEST;
grant select on APP_ADMIN_TEST.SECTION_CATEGORY to STADIUM_MANAGER_TEST, FINANCE_MANAGER_TEST;
grant select on APP_ADMIN_TEST.SEAT to STADIUM_MANAGER_TEST, FINANCE_MANAGER_TEST;
grant select on APP_ADMIN_TEST.MATCH to STADIUM_MANAGER_TEST, FINANCE_MANAGER_TEST;
grant select on APP_ADMIN_TEST.PRICE_CATALOG to FINANCE_MANAGER_TEST;
grant select on APP_ADMIN_TEST.DISCOUNT to FINANCE_MANAGER_TEST;
grant select on APP_ADMIN_TEST.CUSTOMER to STADIUM_MANAGER_TEST, FINANCE_MANAGER_TEST;
grant select on APP_ADMIN_TEST.PAYMENT to FINANCE_MANAGER_TEST;
grant select on APP_ADMIN_TEST.TICKET to STADIUM_MANAGER_TEST, FINANCE_MANAGER_TEST, STADIUM_SECURITY_TEST;
grant select on APP_ADMIN_TEST.REFUND to FINANCE_MANAGER_TEST;
grant select on APP_ADMIN_TEST.VERIFICATION to STADIUM_SECURITY_TEST;


-- View level access control

grant select on  APP_ADMIN_TEST.V_SECTION_WISE_CATEGORY to STADIUM_MANAGER_TEST, FINANCE_MANAGER_TEST;
grant select on  APP_ADMIN_TEST.V_STADIUM_SEATING_STRUCTURE to STADIUM_MANAGER_TEST, FINANCE_MANAGER_TEST;
grant select on  APP_ADMIN_TEST.V_MATCH_WISE_ATTENDANCE to STADIUM_MANAGER_TEST, STADIUM_SECURITY_TEST;
grant select on  APP_ADMIN_TEST.V_TICKET_HISTORY to STADIUM_MANAGER_TEST;

grant select on  APP_ADMIN_TEST.V_PRICE_CATALOG to FINANCE_MANAGER_TEST;
grant select on  APP_ADMIN_TEST.V_DISCOUNTS to FINANCE_MANAGER_TEST;
grant select on  APP_ADMIN_TEST.V_TICKETS_WITH_DISCOUNTS to FINANCE_MANAGER_TEST;
grant select on  APP_ADMIN_TEST.V_REFUNDED_TICKETS to FINANCE_MANAGER_TEST;
grant select on  APP_ADMIN_TEST.V_YEARLY_MONTHLY_SALES to FINANCE_MANAGER_TEST;
grant select on  APP_ADMIN_TEST.V_LEAGUE_TEAM_SALES to FINANCE_MANAGER_TEST;
grant select on  APP_ADMIN_TEST.V_PAYMENT_INFORMATION to FINANCE_MANAGER_TEST;

grant select on  APP_ADMIN_TEST.V_UPCOMING_MATCHES to STADIUM_MANAGER_TEST, FINANCE_MANAGER_TEST, CUSTOMER_TEST, STADIUM_SECURITY_TEST;
grant select on  APP_ADMIN_TEST.V_SHOW_SEAT_BOOKING_STATUS to STADIUM_MANAGER_TEST;
grant select on  APP_ADMIN_TEST.V_SHOW_SEAT_STATUS_CUSTOMER to CUSTOMER_TEST;


--Package level access control
grant execute on APP_ADMIN_TEST.PACK_STADIUM_MANAGEMENT to STADIUM_MANAGER_TEST;
grant execute on APP_ADMIN_TEST.PACK_MATCH_MANAGEMENT to STADIUM_MANAGER_TEST;
grant execute on APP_ADMIN_TEST.PACK_PRICING_MANAGEMENT to FINANCE_MANAGER_TEST;
grant execute on APP_ADMIN_TEST.PACK_TICKET_MANAGEMENT to CUSTOMER_TEST;
grant execute on APP_ADMIN_TEST.PACK_GAMEDAY_MANAGEMENT to STADIUM_MANAGER_TEST;



drop user APP_ADMIN cascade;
drop user STADIUM_MANAGER cascade;
drop user FINANCE_MANAGER cascade;
drop user STADIUM_SECURITY cascade;
drop user CUSTOMER cascade;

--reset table data
delete from verification;
delete from ticket;
delete from refund;
delete from payment;
delete from discount;
delete from seat;
delete from price_catalog;
delete from section_category;
delete from customer;
delete from section;
delete from category;
delete from match;
commit;

select * from APP_ADMIN.section;
select * from APP_ADMIN.category;
select * from APP_ADMIN.section_category;
select * from APP_ADMIN.seat;
select * from APP_ADMIN.match;
select * from APP_ADMIN.price_catalog;
select * from APP_ADMIN.discount;
select * from APP_ADMIN.customer;
select * from APP_ADMIN.ticket;
select * from APP_ADMIN.payment;
select * from APP_ADMIN.refund;
select * from APP_ADMIN.verification;

select * from APP_ADMIN.SECTION order by section_id;
select * from APP_ADMIN.CATEGORY order by category_id;
select * from APP_ADMIN.V_SECTION_WISE_CATEGORY;
select * from APP_ADMIN.V_STADIUM_SEATING_STRUCTURE;
select * from APP_ADMIN.V_MATCH_WISE_ATTENDANCE;
select * from APP_ADMIN.V_TICKET_HISTORY;
select * from APP_ADMIN.V_SHOW_SEAT_BOOKING_STATUS;

--Pricing related views
select * from APP_ADMIN.CUSTOMER;
select * from APP_ADMIN.V_PRICE_CATALOG;
select * from APP_ADMIN.V_DISCOUNTS;
select * from APP_ADMIN.V_TICKETS_WITH_DISCOUNTS;
select * from APP_ADMIN.V_REFUNDED_TICKETS;
select * from APP_ADMIN.V_YEARLY_MONTHLY_SALES;
select * from APP_ADMIN.V_LEAGUE_TEAM_SALES;
select * from APP_ADMIN.V_PAYMENT_INFORMATION;

--Customer related views
select * from APP_ADMIN.V_UPCOMING_MATCHES;
select * from APP_ADMIN.V_SHOW_SEAT_STATUS_CUSTOMER;


/*

DEMO STEPS

Connect to ADMIN

Execute
DROP USER APP_ADMIN CASCADE;
DROP USER STADIUM_MANAGER CASCADE;
DROP USER FINANCE_MANAGER CASCADE;
DROP USER STADIUM_SECURITY CASCADE;
DROP USER CUSTOMER CASCADE;

Run the APP_ADMIN setup script

Connect to APP_ADMIN

Run the OTHER_USER setup script

Run the Table setup script

Run the View setup script

Run the Sequence setup script

Run the Type setup script

Run the Package setup script

Run the Package body script

[All the setup done, start showcasing demo]



*/







/*

DEMO SCENARIO

*/

set serveroutput on;
--Login as STADIUM_MANAGER


select * from APP_ADMIN.section;

--Create a new section
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_SECTION('North', 'G1', '463 Park Drive', 'Boston', 'MA', '02215');

--Try to create the same section again
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_SECTION('North', 'G1', '463 Park Drive', 'Boston', 'MA', '02215');

--Try to add null values for section
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_SECTION(NULL, 'G1', '463 Park Drive', 'Boston', 'MA', '02215');

--Update only gate related information (Usecase Covid scenario)
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_UPDATE_SECTION(1, 'G1', '563 Park Drive', 'Boston', 'MA', '02215');


select * from APP_ADMIN.category;


--Add new category General
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_CATEGORY('General');

--Add new Category VIP
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_CATEGORY('VIP');

--Add old Category VIP again
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_CATEGORY('VIP');

--Add null values for category
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_CATEGORY(NULL);

select * from APP_ADMIN.V_SECTION_WISE_CATEGORY;

--Add section category North, General
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_SECTION_CATEGORY(1,1);

--Add section category North, VIP
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_SECTION_CATEGORY(1,2);

--Adding null values for section category
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_SECTION_CATEGORY(NULL, NULL);

--Adding old section category North, VIP again
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_SECTION_CATEGORY(1, 2);

select * from APP_ADMIN.V_STADIUM_SEATING_STRUCTURE;

--Add 5 seats to North General A row
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_SEATS(1,'A', 5);

--Add 5 seats to North General B row
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_SEATS(1,'B', 5);

--Add 5 seats to North VIP C row
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_SEATS(2,'C', 5);

--Add 5 seats to North VIP D row
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_SEATS(2,'D', 5);

--Adding null values while making seats
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_SEATS(NULL, NULL, NULL);

--Adding the old seat row again
exec APP_ADMIN.PACK_STADIUM_MANAGEMENT.PROC_ADD_NEW_SEATS(2, 'D', 10);

/* STADIUM SETUP COMPLETE */

select * from APP_ADMIN.match;

--Add 1 match for future
exec APP_ADMIN.PACK_MATCH_MANAGEMENT.PROC_ADD_NEW_MATCH('IPL','MUMBAI', 'CHENNAI', TO_DATE('11-DEC-2022 10:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), TO_DATE('11-DEC-2022 02:00:00 PM', 'DD-MON-YYYY HH:MI:SS AM'), 'Y');

--Adding the same old match again
exec APP_ADMIN.PACK_MATCH_MANAGEMENT.PROC_ADD_NEW_MATCH('IPL','MUMBAI', 'CHENNAI', TO_DATE('11-DEC-2022 10:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), TO_DATE('11-DEC-2022 02:00:00 PM', 'DD-MON-YYYY HH:MI:SS AM'), 'Y');

--Adding the match with same team names
exec APP_ADMIN.PACK_MATCH_MANAGEMENT.PROC_ADD_NEW_MATCH('IPL','MUMBAI', 'MUMBAI', TO_DATE('11-DEC-2022 10:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), TO_DATE('11-DEC-2022 02:00:00 PM', 'DD-MON-YYYY HH:MI:SS AM'), 'Y');

--Adding the match with null values
exec APP_ADMIN.PACK_MATCH_MANAGEMENT.PROC_ADD_NEW_MATCH(NULL,'MUMBAI', 'CHENNAI', TO_DATE('11-DEC-2022 10:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), TO_DATE('11-DEC-2022 02:00:00 PM', 'DD-MON-YYYY HH:MI:SS AM'), 'Y');

--Adding a match whose duration is less than 2 hours
exec APP_ADMIN.PACK_MATCH_MANAGEMENT.PROC_ADD_NEW_MATCH('IPL','MUMBAI', 'CHENNAI', TO_DATE('12-DEC-2022 10:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), TO_DATE('12-DEC-2022 11:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), 'Y');

--Updating the match that doesnot exist
exec APP_ADMIN.PACK_MATCH_MANAGEMENT.PROC_MODIFY_MATCH(100,'IPL','MUMBAI', 'CHENNAI', TO_DATE('13-DEC-2022 10:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), TO_DATE('13-DEC-2022 02:00:00 PM', 'DD-MON-YYYY HH:MI:SS AM'), 'N');

--Updating the match with null values (Check the id in match table first)
exec APP_ADMIN.PACK_MATCH_MANAGEMENT.PROC_MODIFY_MATCH(1, NULL,'MUMBAI', 'CHENNAI', TO_DATE('11-DEC-2022 10:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), TO_DATE('11-DEC-2022 02:00:00 PM', 'DD-MON-YYYY HH:MI:SS AM'), 'Y');

--Updating the match to change status flag=Inactive (Check the id in match table first)
exec APP_ADMIN.PACK_MATCH_MANAGEMENT.PROC_MODIFY_MATCH(1, 'IPL','MUMBAI', 'CHENNAI', TO_DATE('11-DEC-2022 10:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), TO_DATE('11-DEC-2022 02:00:00 PM', 'DD-MON-YYYY HH:MI:SS AM'), 'N');

--Updating match with same team names(Check the id in match table first)
exec APP_ADMIN.PACK_MATCH_MANAGEMENT.PROC_MODIFY_MATCH(1, 'IPL','MUMBAI', 'MUMBAI', TO_DATE('12-DEC-2022 10:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), TO_DATE('12-DEC-2022 11:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), 'Y');

--Updating match with less than 2 hour duration(Check the id in match table first)
exec APP_ADMIN.PACK_MATCH_MANAGEMENT.PROC_MODIFY_MATCH(1, 'IPL','MUMBAI', 'CHENNAI', TO_DATE('12-DEC-2022 10:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), TO_DATE('12-DEC-2022 11:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), 'Y');

--Reactivating the match(Check the id in match table first)
exec APP_ADMIN.PACK_MATCH_MANAGEMENT.PROC_MODIFY_MATCH(1, 'IPL','MUMBAI', 'CHENNAI', TO_DATE('11-DEC-2022 10:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), TO_DATE('11-DEC-2022 02:00:00 PM', 'DD-MON-YYYY HH:MI:SS AM'), 'Y');

--Adding inactive match
exec APP_ADMIN.PACK_MATCH_MANAGEMENT.PROC_ADD_NEW_MATCH('IPL','BANGLORE', 'RAJASTHAN', TO_DATE('12-DEC-2022 10:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), TO_DATE('12-DEC-2022 02:00:00 PM', 'DD-MON-YYYY HH:MI:SS AM'), 'N');

/* MATCH SETUP DONE */


--Login as FINANCE_MANAGER
set serveroutput on;
select * from APP_ADMIN.V_PRICE_CATALOG;
select * from APP_ADMIN.V_SECTION_WISE_CATEGORY;



set serveroutput on;
--Add North Gold Price for Match 1 as $10 (Check the id in match table first)
exec APP_ADMIN.PACK_PRICING_MANAGEMENT.proc_add_in_price_catlog(1, 1, 10);

--Add North VIP Price for Match 1 as $20 (Check the id in match table first)
exec APP_ADMIN.PACK_PRICING_MANAGEMENT.proc_add_in_price_catlog(1, 2, 20);

--Add North VIP Price for Match 1 as $20 again (Check the id in match table first)
exec APP_ADMIN.PACK_PRICING_MANAGEMENT.proc_add_in_price_catlog(1, 2, 20);

--Add NULL values
exec APP_ADMIN.PACK_PRICING_MANAGEMENT.proc_add_in_price_catlog(NULL, 2, 20);

--Add Invalid Amount (Check the id in match table first)
exec APP_ADMIN.PACK_PRICING_MANAGEMENT.proc_add_in_price_catlog(1, 2, -190);

--Add Price Catalog for match that doesnot exist
exec APP_ADMIN.PACK_PRICING_MANAGEMENT.proc_add_in_price_catlog(1000, 2, 10);

--Add Price Catalog for section category that doesnot exist
exec APP_ADMIN.PACK_PRICING_MANAGEMENT.proc_add_in_price_catlog(1, 1000, 10);

/* PRICE CATALOG SETUP DONE */

select * from APP_ADMIN.V_DISCOUNTS;

--Add Discount coupon which is active
exec APP_ADMIN.PACK_PRICING_MANAGEMENT.proc_add_discount('Christmas', 10, TO_DATE('09-DEC-2022 12:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), TO_DATE('31-DEC-2022 11:59:59 PM', 'DD-MON-YYYY HH:MI:SS AM'));

--Add a discount with null values
exec APP_ADMIN.PACK_PRICING_MANAGEMENT.proc_add_discount(NULL, 10, TO_DATE('09-DEC-2022 12:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), TO_DATE('31-DEC-2022 11:59:59 PM', 'DD-MON-YYYY HH:MI:SS AM'));

--Add a discount with invalid percentage
exec APP_ADMIN.PACK_PRICING_MANAGEMENT.proc_add_discount('Thanksgiving', -10, TO_DATE('09-DEC-2022 12:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'), TO_DATE('31-DEC-2022 11:59:59 PM', 'DD-MON-YYYY HH:MI:SS AM'));


/* DISCOUNT SETUP DONE */


--Login as CUSTOMER
set serveroutput on;

select * from APP_ADMIN.V_UPCOMING_MATCHES;
select * from APP_ADMIN.V_SHOW_SEAT_STATUS_CUSTOMER; 
select * from APP_ADMIN.V_DISCOUNTS;


--Add customers (Assuming they come from external resource)
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_ADD_CUSTOMER('Aditya', 'Kawale', 'ak@gmail.com', NULL, NULL, NULL,  NULL, NULL, NULL);
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_ADD_CUSTOMER('Anish', 'Navale', 'an@gmail.com', NULL, NULL, NULL,  NULL, NULL, NULL);
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_ADD_CUSTOMER('Sejal', 'Deopura', 'sd@gmail.com', NULL, NULL, NULL,  NULL, NULL, NULL);
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_ADD_CUSTOMER('Sweta', 'Mishra', 'sw@gmail.com', NULL, NULL, NULL,  NULL, NULL, NULL);

select * from APP_ADMIN.customer;

/* Customer setup complete */

--GETTING ESTIMATION

declare
    ap NUMBER;
    dp NUMBER;
    tp NUMBER;
    sp NUMBER;
    sf VARCHAR(255);
    umsg VARCHAR(255);
begin

    --NULL scenarios
    APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_GET_ESTIMATE(NULL,2, APP_ADMIN.seatIDList(9,10,11,12), 'Always', ap, dp, tp, sp, umsg, sf);
    APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_GET_ESTIMATE(1,NULL, APP_ADMIN.seatIDList(9,10,11,12), 'Always', ap, dp, tp, sp, umsg, sf);
    APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_GET_ESTIMATE(1,2, NULL, 'Always', ap, dp, tp,  sp, umsg, sf);
    
    --Customer not exist scenario
    APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_GET_ESTIMATE(200,1, APP_ADMIN.seatIDList(9,10,11,12), 'Always', ap, dp, tp,  sp, umsg, sf);
    
    --Match not exist scenario
    APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_GET_ESTIMATE(1,200, APP_ADMIN.seatIDList(9,10,11,12), 'Always', ap, dp, tp,  sp, umsg, sf);
    
    --Seat not exist scenario
    APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_GET_ESTIMATE(1,1, APP_ADMIN.seatIDList(100,200), 'Always', ap, dp, tp,  sp, umsg, sf);
    
    --Discount not exist scenario
    APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_GET_ESTIMATE(1,1, APP_ADMIN.seatIDList(1), NULL, ap, dp, tp,  sp, umsg, sf);
    
    --Invalid Discount Coupon name scenario
    APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_GET_ESTIMATE(1,1, APP_ADMIN.seatIDList(2), 'Al', ap, dp, tp,  sp, umsg, sf);
    
    --Valid Discount Coupon name scenario
    APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_GET_ESTIMATE(1,1, APP_ADMIN.seatIDList(3), 'Always', ap, dp, tp,  sp, umsg, sf);
    
    --Expired Discount Coupon name scenario
    APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_GET_ESTIMATE(1,1, APP_ADMIN.seatIDList(4), 'Expired', ap, dp, tp,  sp, umsg, sf);
    
    --Valid Discount Coupon name  on multiple ticket bookings scenario
    APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_GET_ESTIMATE(1,1, APP_ADMIN.seatIDList(5,6,7,8), 'Always', ap, dp, tp,  sp, umsg, sf);
end;
/


-- BOOKING TICKET
--Booking a ticket with null values
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_BOOK_TICKET(NULL, 1, APP_ADMIN.seatIDList(1,2,3,4,5), 'Christmas', 'Online');

--Customer not exists
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_BOOK_TICKET(100, 1, APP_ADMIN.seatIDList(1,2,3,4,5), 'Christmas', 'Online');

--Match not exists
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_BOOK_TICKET(1, 100, APP_ADMIN.seatIDList(1,2,3,4,5), 'Christmas', 'Online');

--Seats not existing
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_BOOK_TICKET(1, 1, APP_ADMIN.seatIDList(1000, 2000), 'Christmas', 'Online');

--Discount not provided
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_BOOK_TICKET(1, 1, APP_ADMIN.seatIDList(1,2), NULL, 'Online');

--Booking the already booked seats
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_BOOK_TICKET(1, 1, APP_ADMIN.seatIDList(1,2), NULL, 'Online');

--Discount coupon invalid
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_BOOK_TICKET(2, 1, APP_ADMIN.seatIDList(3,4), 'MyCoupon', 'Online');

--Discount coupon valid
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_BOOK_TICKET(3, 1, APP_ADMIN.seatIDList(5,6), 'Christmas', 'Online');

select * from APP_ADMIN.V_TICKETS_WITH_DISCOUNTS;

/* Ticket booking demo done */

set serveroutput on;

select * from APP_ADMIN.V_LEAGUE_TEAM_SALES;

select * from APP_ADMIN.V_YEARLY_MONTHLY_SALES;

select * from APP_ADMIN.V_REFUNDED_TICKETS;

--Refund tickets
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_CANCEL_TICKET(1, 1, 'Unable to attend', systimestamp);

--Try to refund the same payment again
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_CANCEL_TICKET(2, 2, 'Unable to attend', systimestamp);

--Refund with null values
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_CANCEL_TICKET(NULL, 1, 'Unable to attend', systimestamp);

--Try to refund payment that doesnot exist
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_CANCEL_TICKET(1, 100, 'Unable to attend', systimestamp);

exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_CANCEL_TICKET(3, 3, 'Unable to attend', to_timestamp('2022-10-26 10:00:00 AM', 'YYYY-MM-DD HH:MI:SS AM'));

select * from APP_ADMIN.V_SHOW_SEAT_STATUS_CUSTOMER;
select * from APP_ADMIN.V_PAYMENT_INFORMATION;
select * from APP_ADMIN.V_TICKET_HISTORY;

exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_BOOK_TICKET(3, 1, APP_ADMIN.seatIDList(5,6), 'Christmas', 'Online');
exec APP_ADMIN.PACK_TICKET_MANAGEMENT.PROC_BOOK_TICKET(3, 1, APP_ADMIN.seatIDList(1,2,10), 'Christmas', 'Online');




select * from ticket;


select * from APP_ADMIN.V_USER_TICKETS where cust_id=1;

grant execute on APP_ADMIN.PACK_GAMEDAY_MANAGEMENT to STADIUM_SECURITY;

set serveroutput on;


exec APP_ADMIN.PACK_GAMEDAY_MANAGEMENT.PROC_VERIFY_TICKET(NULL, systimestamp);

exec APP_ADMIN.PACK_GAMEDAY_MANAGEMENT.PROC_VERIFY_TICKET(3, systimestamp);

exec APP_ADMIN.PACK_GAMEDAY_MANAGEMENT.PROC_VERIFY_TICKET(3, to_timestamp('11-DEC-2022 9:00:00 AM', 'DD-MON-YYYY HH:MI:SS AM'));

exec APP_ADMIN.PACK_GAMEDAY_MANAGEMENT.PROC_VERIFY_TICKET(3, to_timestamp('11-DEC-2022 10:30:00 AM', 'DD-MON-YYYY HH:MI:SS AM'));