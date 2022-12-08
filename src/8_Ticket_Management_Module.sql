--TICKET_MANAGEMENT_MODULE

/*

TO DO:
GRANT select on APP_ADMIN.section to STADIUM_MANAGER;
GRANT execute on APP_ADMIN.PROC_ADD_NEW_SECTION to STADIUM_MANAGER;
GRANT select on category to APP_ADMIN.STADIUM_MANAGER;
GRANT execute on APP_ADMIN.PROC_ADD_NEW_CATEGORY to STADIUM_MANAGER;
GRANT execute on APP_ADMIN.PROC_ADD_NEW_SECTION_CATEGORY to STADIUM_MANAGER;
GRANT execute on APP_ADMIN.PROC_ADD_NEW_SEATS to STADIUM_MANAGER;

GRANT select on APP_ADMIN.match to STADIUM_MANAGER, FINANCE_MANAGER;


*/





/*

TEST DATA SETUP




*/


/*

LOGIC

Customer sees a list of upcoming matches using V_UPCOMING_MATCHES
Customer decides the Match that they want to book ticket for.
Customer uses the chosen match_id to see list of available/booked seats for that match from V_SHOW_SEAT_STATUS_CUSTOMER_
Customer makes a list of all the seat_ids that they want
Customer calls the FUNC_GET_ESTIMATE(CustomerID, MatchID, [List of SeatIDs], DiscountID)

    Can we write a check procedure?
    Check if inputs are not null
    Check if customer exists in CUSTOMER
    Check if match exists and is active from V_UPCOMING_MATCHES
    For each seat in List of SeatIDs check if Seat is present and not booked yet from V_SHOW_SEAT_STATUS_CUSTOMER
    Check if discountID exists in V_DISCOUNTS
    
    If all checks are okay then calculate the total price for all seats from V_SHOW_SEAT_STATUS_CUSTOMER
    Apply discount
    
If Customer is happy with the estimate they call FUNC_BOOK_TICKET(CustomerID, MatchID, [List of SeatIDs], DiscountID)
    

*/
create or replace type seatIDList as table of number(20);
/

create or replace function
FUNC_CALC_PRICE_WITH_DISCOUNT(
    ActualTotalPrice NUMBER,
    DiscountPercentage NUMBER
)
return number
is
    FinalDiscountPrice NUMBER;
begin
    FinalDiscountPrice := ActualTotalPrice - ActualTotalPrice * (DiscountPercentage/100);
    return FinalDiscountPrice;    
end;
/


create or replace function
FUNC_CALC_PRICE_WITH_TAX(
    FinalDiscountPrice NUMBER
)
return number
is
    FinalPrice NUMBER;
    TaxPercentage NUMBER;
begin
    TaxPercentage := 10;
    FinalPrice := FinalDiscountPrice + FinalDiscountPrice * (TaxPercentage/100);
    return FinalPrice;    
end;
/


create or replace procedure
PROC_GET_ESTIMATE(
    CustomerID NUMBER,
    MatchID NUMBER,
    ListOfSelectedSeatIDs seatIDList,
    DiscountCouponName VARCHAR,
    ActualTotalPrice OUT NUMBER,
    DiscountedTotalPrice OUT NUMBER,
    DiscountedTotalPriceWithTax OUT NUMBER,
    CustomerWarning OUT VARCHAR
)
is
    a NUMBER;
    s VARCHAR(1000);
    flag NUMBER;
    e_code NUMBER;
    e_msg VARCHAR2(255);
    exp_NULL_VALUES exception;
    exp_customerNotFound exception;
    exp_matchNotFound exception;
    exp_seatsNotFound exception;    
begin

    if
    CustomerID is null or
    MatchID is null or
    ListOfSelectedSeatIDs is null
    then
        raise exp_NULL_VALUES;
    end if;
    
    dbms_output.new_line;
    dbms_output.put_line('Checking if customer exists');
    select count(1) into a from customer where cust_id=CustomerID;
    if a!=1
        then raise exp_customerNotFound;
    end if;

    dbms_output.put_line('Checking if match exists');
    select count(1) into a from V_UPCOMING_MATCHES where match_id=MatchID;
    if a!=1
        then raise exp_matchNotFound;
    end if;

    dbms_output.put_line('Checking if seats exist');
    select count(1) into a from V_SHOW_SEAT_STATUS_CUSTOMER where seat_id member of ListOfSelectedSeatIDs and Booking_Status='N';
    if a!=ListOfSelectedSeatIDs.count
        then raise exp_seatsNotFound;
    end if;


    dbms_output.put_line('Checking if discount coupon exist');
    if DiscountCouponName is null
    then
        flag:=0;
    else
        select count(1) into a from V_DISCOUNTS 
        where upper(coupon_code)=upper(DiscountCouponName)
        and systimestamp between valid_from and valid_till;
    
        if a=0
        then
            flag:=1;
        end if;
        
    end if;


    dbms_output.put_line('GETTING ESTIMATE');
    
    select SUM(ticket_cost) into ActualTotalPrice
    from V_SHOW_SEAT_STATUS_CUSTOMER 
    where match_id=MatchID and seat_id member of ListOfSelectedSeatIDs;

    
    if flag=0
    then
        DiscountedTotalPrice:=ActualTotalPrice;
        DiscountedTotalPriceWithTax:=FUNC_CALC_PRICE_WITH_TAX(DiscountedTotalPrice);
        CustomerWarning:='DISCOUNT COUPON NOT APPLIED, SHOWING ACTUAL PRICE + TAXES';    
    elsif flag=1
    then
        DiscountedTotalPrice:=ActualTotalPrice;
        DiscountedTotalPriceWithTax:=FUNC_CALC_PRICE_WITH_TAX(DiscountedTotalPrice);
        CustomerWarning:='DISCOUNT COUPON NOT FOUND, SHOWING ACTUAL PRICE + TAXES'; 
    else
    
        --Call the function to calculate the discounted price
        select discount into a from V_DISCOUNTS 
        where upper(coupon_code)=upper(DiscountCouponName)
        and systimestamp between valid_from and valid_till;
        
        CustomerWarning:='DISCOUNT COUPON APPLIED, SHOWING DISCOUNT PRICE + TAXES';
        dbms_output.put_line('APPLYING DISCOUNT COUPON: ' || DiscountCouponName);
        dbms_output.put_line('DISCOUNT PERCENTAGE: ' || to_char(a) || '% OFF');
        DiscountedTotalPrice:=FUNC_CALC_PRICE_WITH_DISCOUNT(ActualTotalPrice, a);
        DiscountedTotalPriceWithTax:=FUNC_CALC_PRICE_WITH_TAX(DiscountedTotalPrice);
        
        
    end if;
    
        dbms_output.put_line('MESSAGE: ' || CustomerWarning);      
        dbms_output.put_line('ACTUAL TOTAL PRICE: ' || ActualTotalPrice);
        dbms_output.put_line('DISCOUNTED PRICE: ' || DiscountedTotalPrice);
        dbms_output.put_line('AFTER TAX PRICE: ' || DiscountedTotalPriceWithTax);

exception

    when exp_NULL_VALUES
        then
            dbms_output.new_line;
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('CustomerID: ' || CustomerID);
            dbms_output.put_line('MatchID: ' || MatchID);
            
            if ListOfSelectedSeatIDs is not null
            then
                for i in 1..ListOfSelectedSeatIDs.count loop
                    s := s || ' ' || ListOfSelectedSeatIDs(i);
                end loop;
            else
                    s := NULL;
            end if;
    
            dbms_output.put_line('ListOfSelectedSeatIDs: ' || s);
            dbms_output.put_line('---------------------------');
    when exp_customerNotFound
        then
            dbms_output.new_line;
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('CUSTOMER ID DOES NOT EXIST : ' || CustomerID );
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('BOOK THE TICKET FOR EXISTING CUSTOMER');
            dbms_output.put_line('---------------------------');

    when exp_matchNotFound
        then
            dbms_output.new_line;
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('MATCH ID DOES NOT EXIST : ' || MatchID );
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('BOOK THE TICKET FOR UPCOMING MATCH');
            dbms_output.put_line('---------------------------');
            

    when exp_seatsNotFound
        then
            dbms_output.new_line;
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('SOME SEAT ID DO NOT EXIST');
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('BOOK THE TICKET FOR SEATS WITH CORRECT SEAT IDS');
            dbms_output.put_line('---------------------------');


    when others
        then 
            dbms_output.put_line('Exception Occurred');
            e_code := SQLCODE;
            e_msg := SQLERRM;
            dbms_output.put_line('Error Code: ' || e_code);
            dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 

end;
/


declare
    ap NUMBER;
    dp NUMBER;
    tp NUMBER;
    umsg VARCHAR(255);
begin

    --NULL scenarios
    PROC_GET_ESTIMATE(NULL,2, seatIDList(9,10,11,12), 'Always', ap, dp, tp, umsg);
    PROC_GET_ESTIMATE(1,NULL, seatIDList(9,10,11,12), 'Always', ap, dp, tp, umsg);
    PROC_GET_ESTIMATE(1,2, NULL, 'Always', ap, dp, tp, umsg);
    
    --Customer not exist scenario
    PROC_GET_ESTIMATE(2,2, seatIDList(9,10,11,12), 'Always', ap, dp, tp, umsg);
    
    --Match not exist scenario
    PROC_GET_ESTIMATE(1,5, seatIDList(9,10,11,12), 'Always', ap, dp, tp, umsg);
    
    --Seat not exist scenario
    PROC_GET_ESTIMATE(1,2, seatIDList(1,2), 'Always', ap, dp, tp, umsg);
    
    --Discount not exist scenario
    PROC_GET_ESTIMATE(1,2, seatIDList(9), NULL, ap, dp, tp, umsg);
    
    --Invalid Discount Coupon name scenario
    PROC_GET_ESTIMATE(1,2, seatIDList(10), 'Al', ap, dp, tp, umsg);
    
    --Valid Discount Coupon name scenario
    PROC_GET_ESTIMATE(1,2, seatIDList(11), 'Always', ap, dp, tp, umsg);
    
    --Expired Discount Coupon name scenario
    PROC_GET_ESTIMATE(1,2, seatIDList(12), 'Expired', ap, dp, tp, umsg);
    
    --Valid Discount Coupon name  on multiple ticket bookings scenario
    PROC_GET_ESTIMATE(1,2, seatIDList(9,10,11,12), 'Always', ap, dp, tp, umsg);
end;
/
  
    
    