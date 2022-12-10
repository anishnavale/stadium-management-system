/*

VIEW SETUP

*/


set serveroutput on;
purge recyclebin;

--Show section wise categories as configured by the STADIUM_MANAGER
create or replace view
V_SECTION_WISE_CATEGORY
as
select c.sc_id, a.section_name, b.category_name
from section_category c
inner join section a on c.section_id = a.section_id
inner join category b on c.category_id = b.category_id
order by c.sc_id;

--Show complete stadium seating arrangement as configured by the STADIUM_MANAGER
create or replace view
V_STADIUM_SEATING_STRUCTURE
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

--Show price catalog for matches as configured by the FINANCE_MANAGER 
create or replace view
V_PRICE_CATALOG
as
with sc as (

    select c.sc_id, a.section_name, b.category_name
    from section_category c
    inner join section a on c.section_id = a.section_id
    inner join category b on c.category_id = b.category_id
    order by c.sc_id

) 
select 
     a.pc_id as price_catalog_id, 
     b.match_id as match_id, 
     b.team1 as team1,
     b.team2 as team2,
     c.section_name as section_name,
     c.category_name as category_name,
     a.amount as ticket_cost
from price_catalog a
inner join match b on a.match_id=b.match_id
inner join sc c on a.sc_id=c.sc_id
order by a.pc_id;

--Show discounts as configured by the FINANCE_MANAGER 
create or replace view
V_DISCOUNTS
as
select
    d.coupon_name as COUPON_CODE,
    d.discount_perc as DISCOUNT,
    to_timestamp(to_char(d.d_start_date, 'DD-MON-YYYY HH:MI:SS AM'), 'DD-MON-YYYY HH:MI:SS AM') AS VALID_FROM,
    to_timestamp(to_char(d.d_end_date, 'DD-MON-YYYY HH:MI:SS AM'), 'DD-MON-YYYY HH:MI:SS AM') AS VALID_TILL
from
    discount d;
    
--Show payment information captured while booking tickets (includes information about discounts, and considers payments that were later refunded too)
create or replace view 
V_PAYMENT_INFORMATION
as
SELECT
    p.payment_id as PAYMENT_ID,
    p.tot_amount as TOT_AMOUNT_PAID,
    to_timestamp(to_char(p.p_date_time, 'DD-MON-YYYY HH:MI:SS AM'), 'DD-MON-YYYY HH:MI:SS AM') as PAYMENT_TIME,
    p.payment_mode as PAYMENT_MODE,
    d.coupon_name as DISCOUNT_COUPON_USED,
    nvl(d.discount_perc, 0) as DISCOUNT_PERC_APPLIED
FROM
    payment p
    LEFT OUTER JOIN discount d ON p.discount_id = d.discount_id;

--Show complete ticket information
create or replace view 
V_TICKET_HISTORY
as
select 
    t.ticket_id as ticket_id,
    m.match_id as match_id,
    m.team1,
    m.team2,
    to_timestamp(to_char(m.m_start_time, 'DD-MON-YYYY HH:MI:SS AM'), 'DD-MON-YYYY HH:MI:SS AM') as m_start_time,
    to_timestamp(to_char(m.m_end_time, 'DD-MON-YYYY HH:MI:SS AM'), 'DD-MON-YYYY HH:MI:SS AM') as m_end_time,
    s.seat_id,
    s.section_name,
    s.category_name,
    s.seat_row,
    s.seat_no,
    c.cust_id,
    c.cust_fname,
    c.cust_lname,
    c.cust_email,
    p.payment_id,
    p.payment_time,
    p.payment_mode,
    p.discount_coupon_used,
    p.discount_perc_applied,
    t.rfd_id,
    case
        when t.rfd_id is NULL then 'Y'
        else 'N'
        end BOOKING_STATUS
from 
    ticket t
        inner join customer c on t.cust_id=c.cust_id
        inner join V_STADIUM_SEATING_STRUCTURE s on t.seat_id=s.seat_id
        inner join V_PAYMENT_INFORMATION p on t.payment_id=p.payment_id
        inner join match m on t.match_id=m.match_id
order by m.match_id, t.ticket_id;

--Show information about seats booking status for all the active matches  
create or replace view 
V_SHOW_SEAT_BOOKING_STATUS
as
select * from (
    with match_seats as (
        select m.*, s.* 
        from match m, V_STADIUM_SEATING_STRUCTURE s
    ) select 
        m.match_id, m.league_name,m.team1, m.team2, to_timestamp(to_char(m.m_start_time, 'DD-MON-YYYY HH:MI:SS AM'), 'DD-MON-YYYY HH:MI:SS AM') as match_date,
        m.seat_id, m.section_name, m.category_name, m.seat_row, m.seat_no,
        t.ticket_id,
        case
            when t.ticket_id is NULL then 'N'
            else 'Y'
            end BOOKING_STATUS
        from match_seats m 
            left outer join V_TICKET_HISTORY t on m.seat_id=t.seat_id and m.match_id=t.match_id and t.BOOKING_STATUS='Y'
        where m.match_active='Y'
    order by m.match_id, m.seat_id
);

--Show all the active upoming matches as configured by the STADIUM_MANAGER regardless of whether Price Catalog is added or not
create or replace view 
V_UPCOMING_MATCHES
as
select Match_ID,LEAGUE_NAME, TEAM1, TEAM2, to_char(M_START_TIME, 'DD-MM-YYYY HH:MI:SS AM') as M_START_TIME from match 
where M_START_TIME > SYSTIMESTAMP and match_active='Y'
order by to_date(M_START_TIME, 'DD-MM-YYYY HH:MI:SS AM');

--Show all the tickets that have booking_status='Y' and have discounts on them (Skips the refunded tickets)
create or replace view
V_TICKETS_WITH_DISCOUNTS 
as
select * from V_TICKET_HISTORY where DISCOUNT_COUPON_USED is not null and booking_status='Y';

--Show all the tickets that were refunded
create or replace view 
V_REFUNDED_TICKETS
as
select * from V_TICKET_HISTORY where RFD_ID is not null;

--Show match-wise seat status so as to whether it was purchased and attended (Only for active matches)
create or replace view 
V_MATCH_WISE_ATTENDANCE
as
select
    s.match_id,
    s.section_name,
    s.category_name,
    s.seat_row,
    s.seat_no,
    case
    when t.ticket_id is NOT NULL then 'Y'
    else 'N' 
    end Purchased,
    case
    when v.ticket_id is NOT NULL then 'Y'
    else 'N' 
    end Attended
from
    V_SHOW_SEAT_BOOKING_STATUS s
    left outer join verification v on s.ticket_id=v.ticket_id
    left outer join V_TICKET_HISTORY t on s.ticket_id=t.ticket_id;

--Show yearly-monthly sales of stadium (disregards the refund ticket amount)
create or replace view 
V_YEARLY_MONTHLY_SALES
as
select 
    to_char(p1.p_date_time, 'MON-YYYY') as MonthYear,
    sum(p1.tot_amount) as TOT_AMOUNT_PAID
from payment p1
where p1.payment_id in (
    select p.payment_id from payment p
    minus
    select r.payment_id from v_refunded_tickets r
) group by to_char(p1.p_date_time, 'MON-YYYY');


--Show league-team sales of stadium (disregards the refund ticket amount, considers team1 vs team2 as distinct in one league)
create or replace view
V_LEAGUE_TEAM_SALES
as
with unique_payments as (
    select 
        distinct 
        m.league_name, 
        m.team1,
        m.team2,
        case
            when team1<team2
            then team1 || ' vs ' || team2
            when team1>team2
            then team2 || ' vs ' || team1
        end participant_teams,
        t.payment_id
    from ticket t 
            inner join match m on t.match_id=m.match_id
    where t.rfd_id is null
)   select
        up.league_name,
        up.participant_teams,
        sum(p.tot_amount) as TotalSales
    from 
        unique_payments up
            inner join payment p on up.payment_id=p.payment_id
    group by up.league_name, up.participant_teams;
    
create or replace view
V_SHOW_SEAT_STATUS_CUSTOMER
as
select
    a.match_id,
    a.league_name,
    a.team1,
    a.team2,
    a.match_date,
    a.seat_id,
    a.section_name,
    a.category_name,
    a.seat_row,
    a.seat_no,
    a.booking_status,
    b.ticket_cost
from 
    V_SHOW_SEAT_BOOKING_STATUS a
        inner join V_PRICE_CATALOG b
            on a.match_id=b.match_id 
                and a.section_name=b.section_name
                and a.category_name=b.category_name
order by a.match_id, a.seat_id;

--Show user active tickets
create or replace view
V_USER_TICKETS
as
select * from V_TICKET_HISTORY where booking_status='Y';

--granting  view access to specific user
grant select on  APP_ADMIN.V_SECTION_WISE_CATEGORY to STADIUM_MANAGER, FINANCE_MANAGER;
grant select on  APP_ADMIN.V_STADIUM_SEATING_STRUCTURE to STADIUM_MANAGER, FINANCE_MANAGER;
grant select on  APP_ADMIN.V_MATCH_WISE_ATTENDANCE to STADIUM_MANAGER, STADIUM_SECURITY;
grant select on  APP_ADMIN.V_TICKET_HISTORY to STADIUM_MANAGER;

grant select on  APP_ADMIN.V_PRICE_CATALOG to FINANCE_MANAGER;
grant select on  APP_ADMIN.V_DISCOUNTS to FINANCE_MANAGER, CUSTOMER;
grant select on  APP_ADMIN.V_TICKETS_WITH_DISCOUNTS to FINANCE_MANAGER;
grant select on  APP_ADMIN.V_REFUNDED_TICKETS to FINANCE_MANAGER;
grant select on  APP_ADMIN.V_YEARLY_MONTHLY_SALES to FINANCE_MANAGER;
grant select on  APP_ADMIN.V_LEAGUE_TEAM_SALES to FINANCE_MANAGER;
grant select on  APP_ADMIN.V_PAYMENT_INFORMATION to FINANCE_MANAGER;

grant select on  APP_ADMIN.V_UPCOMING_MATCHES to STADIUM_MANAGER, FINANCE_MANAGER, CUSTOMER, STADIUM_SECURITY;
grant select on  APP_ADMIN.V_SHOW_SEAT_BOOKING_STATUS to STADIUM_MANAGER;
grant select on  APP_ADMIN.V_SHOW_SEAT_STATUS_CUSTOMER to CUSTOMER;
grant select on  APP_ADMIN.V_USER_TICKETS to CUSTOMER;