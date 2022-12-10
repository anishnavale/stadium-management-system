/*

TYPE SETUP    
    
*/

--TYPE: seatIDList
create or replace type seatIDList as table of number(20);
/

--TYPE: ticketIDList
create or replace type ticketIDList as table of number(20);
/

grant execute on seatIDList to CUSTOMER, STADIUM_MANAGER, FINANCE_MANAGER, STADIUM_SECURITY;
grant execute on ticketIDList to CUSTOMER, STADIUM_MANAGER, FINANCE_MANAGER, STADIUM_SECURITY;