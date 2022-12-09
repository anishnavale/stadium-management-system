/*

TEST CASES FOR PROC_GET_ESTIMATE

*/
set serveroutput on;
purge recyclebin;

declare
    ap NUMBER;
    dp NUMBER;
    tp NUMBER;
    sp NUMBER;
    sf VARCHAR(255);
    umsg VARCHAR(255);
begin

    --NULL scenarios
    PROC_GET_ESTIMATE(NULL,2, seatIDList(9,10,11,12), 'Always', ap, dp, tp, sp, umsg, sf);
    PROC_GET_ESTIMATE(1,NULL, seatIDList(9,10,11,12), 'Always', ap, dp, tp, sp, umsg, sf);
    PROC_GET_ESTIMATE(1,2, NULL, 'Always', ap, dp, tp,  sp, umsg, sf);
    
    --Customer not exist scenario
    PROC_GET_ESTIMATE(2,2, seatIDList(9,10,11,12), 'Always', ap, dp, tp,  sp, umsg, sf);
    
    --Match not exist scenario
    PROC_GET_ESTIMATE(1,5, seatIDList(9,10,11,12), 'Always', ap, dp, tp,  sp, umsg, sf);
    
    --Seat not exist scenario
    PROC_GET_ESTIMATE(1,2, seatIDList(1,2), 'Always', ap, dp, tp,  sp, umsg, sf);
    
    --Discount not exist scenario
    PROC_GET_ESTIMATE(1,2, seatIDList(9), NULL, ap, dp, tp,  sp, umsg, sf);
    
    --Invalid Discount Coupon name scenario
    PROC_GET_ESTIMATE(1,2, seatIDList(10), 'Al', ap, dp, tp,  sp, umsg, sf);
    
    --Valid Discount Coupon name scenario
    PROC_GET_ESTIMATE(1,2, seatIDList(11), 'Always', ap, dp, tp,  sp, umsg, sf);
    
    --Expired Discount Coupon name scenario
    PROC_GET_ESTIMATE(1,2, seatIDList(12), 'Expired', ap, dp, tp,  sp, umsg, sf);
    
    --Valid Discount Coupon name  on multiple ticket bookings scenario
    PROC_GET_ESTIMATE(1,2, seatIDList(9,10,11,12), 'Always', ap, dp, tp,  sp, umsg, sf);
end;
/




/*

TEST CASES FOR PROC_BOOK_TICKET

*/
begin
    --NULL scenarios
    PROC_BOOK_TICKET(NULL,2, seatIDList(9,10,11,12), 'Always', 'Online');
    PROC_BOOK_TICKET(1,NULL, seatIDList(9,10,11,12), 'Always', 'Online');
    PROC_BOOK_TICKET(1,2, NULL, 'Always', 'Online');
    
    --Customer not exist scenario
    PROC_BOOK_TICKET(2,2, seatIDList(9,10,11,12), 'Always','Online');
    
    --Match not exist scenario
    PROC_BOOK_TICKET(1,5, seatIDList(9,10,11,12), 'Always', 'Online');
    
    --Seat not exist scenario
    PROC_BOOK_TICKET(1,2, seatIDList(1,2), 'Always', 'Online');
    
    --Discount not exist scenario
    PROC_BOOK_TICKET(1,2, seatIDList(9), NULL, 'Online');
    
    --Invalid Discount Coupon name scenario
    PROC_BOOK_TICKET(1,2, seatIDList(10), 'Al', 'Online');
    
    --Valid Discount Coupon name scenario
    PROC_BOOK_TICKET(1,2, seatIDList(11), 'Always','Online');
    
    --Expired Discount Coupon name scenario
    PROC_BOOK_TICKET(1,2, seatIDList(12), 'Expired', 'Online');
    
    --Valid Discount Coupon name  on multiple ticket bookings scenario
    PROC_BOOK_TICKET(1,2, seatIDList(9,10,11,12), 'Always', 'Online');
end;
/
