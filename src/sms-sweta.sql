--DDL commands-Price, Match, Payment #18


--price
create table price_catalog(
pc_id number(20) NOT NULL,
match_id number(20),
sc_id number(20),
amount number(5,2)
);

--Match
create table match(
match_id number(20) NOT NULL,
league_name varchar(30),
team1 varchar(30),
team2 varchar(30),
m_start_time date,
m_end_time date
);					


--payment
create table payment(
payment_id number(20) NOT NULL,
discount_id number(20),
tot_amount number(10,2),
p_date_time date,
payment_mode varchar(30)
)
