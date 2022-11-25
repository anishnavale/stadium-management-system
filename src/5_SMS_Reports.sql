--Author: Aditya, Anish, Sweta, Sejal
--Comments: Script to generate reports from SMS tables
--          Note: Run this script logged in as 'APP_ADMIN' user for Oracle Autonomous Database

PURGE RECYCLEBIN;

SET SERVEROUTPUT ON;

-- 1. V_Show_Seating_Structure - STADIUM_MANAGER wants to get an idea about the stadium
create or replace view V_SHOW_SEATING_STRUCTURE
as
with sc as (

    select c.sc_id, a.section_name, b.category_name
    from section_category c
    inner join section a on c.section_id = a.section_id
    inner join category b on c.category_id = b.category_id
    order by c.sc_id

) select a.seat_id  as SEAT_ID, b.section_name, b.category_name, a.seat_row, a.seat_no
from seat a inner join sc b on a.sc_id = b.sc_id
order by a.seat_id;


-- 2. V_Show_Seats_Status - STADIUM_MANAGER wants to see the seat booking status over matches

--Payment Information View
create or replace view V_PAYMENT_INFORMATION as
SELECT
    p.payment_id as PAYMENT_ID,
    p.tot_amount as TOT_AMOUNT_PAID,
    p.p_date_time as PAYMENT_TIME,
    p.payment_mode as PAYMENT_MODE,
    d.coupon_name as DISCOUNT_COUPON_USED,
    nvl(d.discount_perc, 0) as DISCOUNT_PERC_APPLIED
FROM
    payment p
    LEFT OUTER JOIN discount d ON p.discount_id = d.discount_id;
    
--select * from V_PAYMENT_INFORMATION;

create or replace view V_TICKET_HISTORY
as
select 
    t.ticket_id,
    m.match_id,
    m.team1,
    m.team2,
    m.m_start_time,
    m.m_end_time,
    s.seat_id,
    s.section_name,
    s.category_name,
    s.seat_row,
    s.seat_no,
    c.cust_fname,
    c.cust_lname,
    c.cust_email,
    p.payment_id,
    p.payment_time,
    p.payment_mode,
    p.discount_coupon_used,
    p.discount_perc_applied,
    t.rfd_id,
    'Y' as BookingStatus
from 
    ticket t
        inner join customer c on t.cust_id=c.cust_id
        inner join V_SHOW_SEATING_STRUCTURE s on t.seat_id=s.seat_id
        inner join V_PAYMENT_INFORMATION p on t.payment_id=p.payment_id
        inner join match m on t.match_id=m.match_id
order by m.match_id, t.ticket_id;

select * from V_TICKET_HISTORY;

create or replace view V_SHOW_SEAT_STATUS
as
select * from (
    with match_seats as (
        select m.*, s.* 
        from match m, V_SHOW_SEATING_STRUCTURE s
    ) select 
        m.league_name,m.team1, m.team2, to_char(m.m_start_time, 'DD-MON-YYYY') as match_date,
        m.section_name, m.category_name, m.seat_row, m.seat_no,
        t.ticket_id,
        case
        when t.ticket_id is NOT NULL then 'Y'
        else 'N'
        end BOOKING_STATUS
        from match_seats m 
            left outer join V_TICKET_HISTORY t on m.seat_id=t.seat_id and m.match_id=t.match_id
        where rfd_id is null
    order by m.match_id, m.seat_id
);


-- 3. V_Show_Upcoming_Matches - For CUSTOMERS to see upcoming matches
create or replace view V_SHOW_UPCOMING_MATCHES as
select LEAGUE_NAME, TEAM1, TEAM2, M_START_TIME from match 
where M_START_TIME > SYSTIMESTAMP;

-- 4. V_User_Tickets - For CUSTOMERS to review past ticket bookings details
create or replace view V_USER_TICKETS as
select c.cust_fname ||' '|| c.cust_lname as cust_name, m.league_name, m.team1, m.team2, m.m_start_time, se.gate_name, se.section_name, ca.category_name, s.seat_row, s.seat_no, t.rfd_id
from ticket t
inner join customer c on c.cust_id=t.cust_id
inner join match m on m.match_id=t.match_id
inner join seat s on t.seat_id=s.seat_id
inner join section_category sc on sc.sc_id=s.sc_id
inner join section se on se.section_id=sc.section_id
inner join category ca on ca.category_id=sc.category_id
order by ticket_id;

-- 5. V_Available_Seats - For CUSTOMERS to review available seat
create or replace view V_AVAILABLE_SEATS as
select league_name, team1, team2, match_date, section_name, category_name, seat_row, seat_no from V_SHOW_SEAT_STATUS
where booking_status = 'N';

 
--6. V_Tickets_With_Discounts - To understand how a discount scheme affected ticket bookings
create or replace view V_TICKETS_WITH_DISCOUNTS as
select c.cust_fname ||' '|| c.cust_lname as cust_name, m.league_name, m.team1, m.team2, m.m_start_time, se.section_name, ca.category_name, s.seat_row, s.seat_no, p.tot_amount, d.coupon_name, d.discount_perc from ticket t
join payment p on t.payment_id = p.payment_id
join discount d on p.discount_id = d.discount_id
inner join seat s on t.seat_id=s.seat_id
inner join section_category sc on sc.sc_id=s.sc_id
inner join section se on se.section_id=sc.section_id
inner join category ca on ca.category_id=sc.category_id
inner join customer c on c.cust_id=t.cust_id
inner join match m on m.match_id=t.match_id;
 
--7. V_Show_Refunded_Tickets - To understand user wise refund detail
create or replace view V_SHOW_REFUNDED_TICKETS as
select c.cust_fname ||' '|| c.cust_lname as cust_name, m.league_name, m.team1, m.team2, m.m_start_time, se.gate_name, se.section_name, ca.category_name, s.seat_row, s.seat_no from ticket t
join refund r on r.rfd_id = t.rfd_id
inner join customer c on c.cust_id=t.cust_id
inner join match m on m.match_id=t.match_id
inner join seat s on t.seat_id=s.seat_id
inner join section_category sc on sc.sc_id=s.sc_id
inner join section se on se.section_id=sc.section_id
inner join category ca on ca.category_id=sc.category_id;

-- 8. V_Match_Wise_Attendance - To understand how many people attended match
create or replace view V_MATCH_WISE_ATTENDANCE as
select m.league_name, m.team1, m.team2, c.cust_fname ||' '|| c.cust_lname as cust_name, se.gate_name, se.section_name, ca.category_name, s.seat_row, s.seat_no from match m
inner join ticket t on t.match_id=m.match_id
inner join verification v on v.ticket_id=t.ticket_id
inner join customer c on t.cust_id=c.cust_id
inner join seat s on t.seat_id=s.seat_id
inner join section_category sc on sc.sc_id=s.sc_id
inner join section se on se.section_id=sc.section_id
inner join category ca on ca.category_id=sc.category_id;
 
--9. V_Yearly_Monthly_Sales - To understand year and month wise sales
create or replace view V_YEARLY_MONTHLY_SALES
as
select * from (
select to_char(p.p_date_time, 'MON-YYYY'),sum(p.tot_amount) from payment p group by to_char(p.p_date_time, 'MON-YYYY')
);
 
---10. V_League_Team_Sales - To understand league and team wise sale
create or replace view V_LEAGUE_TEAM_SALES
as
select * from (
with a as
(
    select distinct match_id, payment_id 
    from ticket
) 
select m.league_name, m.team1, m.team2, sum(p.tot_amount) from a
inner join match m on a.match_id=m.match_id
inner join payment p on a.payment_id=p.payment_id
group by m.league_name, m.team1, m.team2
);

--Granting access to views to specific users
grant select on V_SHOW_SEATING_STRUCTURE to STADIUM_MANAGER;

grant select on V_SHOW_SEAT_STATUS to STADIUM_MANAGER;

grant select on V_SHOW_UPCOMING_MATCHES to STADIUM_MANAGER, CUSTOMER;

grant select on V_USER_TICKETS to STADIUM_MANAGER, CUSTOMER;

grant select on V_AVAILABLE_SEATS to STADIUM_MANAGER, CUSTOMER;

grant select on V_TICKETS_WITH_DISCOUNTS to FINANCE_MANAGER;

grant select on V_SHOW_REFUNDED_TICKETS to FINANCE_MANAGER;

grant select on V_MATCH_WISE_ATTENDANCE to STADIUM_MANAGER, STADIUM_SECURITY;

grant select on V_YEARLY_MONTHLY_SALES to FINANCE_MANAGER;

grant select on V_LEAGUE_TEAM_SALES to FINANCE_MANAGER;

-- Reports
select * from V_SHOW_SEATING_STRUCTURE;

select * from V_SHOW_SEAT_STATUS;

select * from V_SHOW_UPCOMING_MATCHES;

select * from V_USER_TICKETS;

select * from V_AVAILABLE_SEATS;

select * from V_TICKETS_WITH_DISCOUNTS;

select * from V_SHOW_REFUNDED_TICKETS;

select * from V_MATCH_WISE_ATTENDANCE;

select * from V_YEARLY_MONTHLY_SALES;

select * from V_LEAGUE_TEAM_SALES;