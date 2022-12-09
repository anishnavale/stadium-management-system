/*

PACKAGE BODY SETUP

*/


set serveroutput on;
PURGE RECYCLEBIN;

--Stadium Setup Module : PACK_STADIUM_MANAGEMENT BODY
CREATE OR REPLACE
PACKAGE BODY PACK_STADIUM_MANAGEMENT AS

--PROCEDURES

        --proc : PROC_ADD_NEW_SECTION(SectionName, GateName, GateStreet, GateCity, GateState, GatePincode)
        procedure 
        PROC_ADD_NEW_SECTION(
            SectionName VARCHAR2,
            GateName VARCHAR2,
            GateStreet VARCHAR2, 
            GateCity VARCHAR2, 
            GateState VARCHAR2,
            GatePincode VARCHAR2
        ) is 
            sectionCount NUMBER;
            gateCount NUMBER;
            e_code NUMBER;
            e_msg VARCHAR2(255);
            exp_NULL_VALUE exception;
            exp_SECTION_EXISTS exception;
            exp_GATE_EXISTS exception;
        begin
        
            if SectionName IS NULL 
            or GateName IS NULL 
            or GateStreet IS NULL 
            or GateCity IS NULL 
            or GateState IS NULL
            or GatePincode IS NULL
            then 
                raise exp_NULL_VALUE;
            end if;
        
            select count(1) into sectionCount from section where section_name=SectionName;
            select count(1) into gateCount from section where gate_name=GateName;
            
            if sectionCount>0
            then
                raise exp_SECTION_EXISTS;
            else    
                if gateCount>0
                then
                    raise exp_GATE_EXISTS; 
                
                else
                    insert into section values(SEQ_SEC_SECTION_ID.nextval,SectionName, GateName, GateStreet, GateCity, GateState, GatePincode);
                    commit;
                dbms_output.put_line('New Section Added: ' || SectionName); 
                end if;
            
            end if;
        
        
            
        exception
        
            when exp_NULL_VALUE
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SectionName: ' || SectionName);
                dbms_output.put_line('GateName: ' || GateName);
                dbms_output.put_line('GateStreet: ' || GateStreet);
                dbms_output.put_line('GateCity: ' || GateCity);
                dbms_output.put_line('GateState: ' || GateState);
                dbms_output.put_line('GatePincode: ' || GatePincode);
                dbms_output.put_line('---------------------------');
        
            when exp_SECTION_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SECTION ALREADY EXISTS, ASSIGN A NAME THAT IS NOT USED ALREADY'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SectionName: ' || SectionName);
                dbms_output.put_line('---------------------------');
                
            when exp_GATE_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('GATE ALREADY EXISTS, ASSIGN A NAME THAT IS NOT USED ALREADY'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('GateName: ' || GateName);
                dbms_output.put_line('---------------------------');
        
            when others
            then 
                dbms_output.put_line('Exception Occurred');
                e_code := SQLCODE;
                e_msg := SQLERRM;
                dbms_output.put_line('Error Code: ' || e_code);
                dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
            
        end PROC_ADD_NEW_SECTION;
        
        --proc : PROC_UPDATE_SECTION(SectionID, GateName, GateStreet, GateCity, GateState, GatePincode)
        procedure 
        PROC_UPDATE_SECTION(
            SectionID NUMBER,
            GateName VARCHAR2,
            GateStreet VARCHAR2, 
            GateCity VARCHAR2, 
            GateState VARCHAR2,
            GatePincode VARCHAR2
        ) is 
            sectionCount NUMBER;
            gateCount NUMBER;
            e_code NUMBER;
            e_msg VARCHAR2(255);
            exp_NULL_VALUE exception;
            exp_SECTION_NOT_EXISTS exception;
            exp_GATE_EXISTS exception;
        begin
        
            if SectionID IS NULL 
            or GateName IS NULL 
            or GateStreet IS NULL 
            or GateCity IS NULL 
            or GateState IS NULL
            or GatePincode IS NULL
            then 
                raise exp_NULL_VALUE;
            end if;
        
            select count(1) into sectionCount from section where section_id=SectionID;
            select count(1) into gateCount from section where gate_name=GateName and section_id!=SectionID;
        
            
            if sectionCount>0
            then
                if gateCount>0
                then
                    raise exp_GATE_EXISTS;
                else
                    update section set
                    gate_name=GateName,
                    gate_street=GateStreet,
                    gate_state=GateState,
                    gate_pincode=GatePincode
                    where section_id=SectionID;
                    commit;
                    dbms_output.put_line('SectionID Updated: ' || SectionID); 
                end if;        
            else
                raise exp_SECTION_NOT_EXISTS;
            end if;
        
            
        exception
        
            when exp_NULL_VALUE
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SectionID: ' || SectionID);
                dbms_output.put_line('GateName: ' || GateName);
                dbms_output.put_line('GateStreet: ' || GateStreet);
                dbms_output.put_line('GateCity: ' || GateCity);
                dbms_output.put_line('GateState: ' || GateState);
                dbms_output.put_line('GatePincode: ' || GatePincode);
                dbms_output.put_line('---------------------------');
        
            when exp_SECTION_NOT_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SECTION DOES NOT EXISTS, GIVE THE CORRECT SECTION ID THAT EXISTS'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SectionID: ' || SectionID);
                dbms_output.put_line('---------------------------');
            
            when exp_GATE_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('GATE ALREADY EXISTS FOR ANOTHER SECTION, ASSIGN A NAME THAT IS NOT USED ALREADY'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('GateName: ' || GateName);
                dbms_output.put_line('---------------------------');
        
            when others
            then 
                dbms_output.put_line('Exception Occurred');
                e_code := SQLCODE;
                e_msg := SQLERRM;
                dbms_output.put_line('Error Code: ' || e_code);
                dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
            
        end PROC_UPDATE_SECTION;
        
        --proc : PROC_ADD_NEW_CATEGORY(CategoryName)
        procedure
        PROC_ADD_NEW_CATEGORY(
            CategoryName VARCHAR
        ) is
            categoryCount NUMBER;
            e_code NUMBER;
            e_msg VARCHAR(255);
            exp_CATEGORY_EXISTS exception;
            exp_NULL_VALUE exception;
        begin
        
            if CategoryName IS NULL
            then
                raise exp_NULL_VALUE;
            end if;
            
            select count(1) into categoryCount from category where category_name=CategoryName;
            if categoryCount>0
            then
                raise exp_CATEGORY_EXISTS;
            else
                insert into category values(SEQ_CAT_CATEGORY_ID.nextval, CategoryName);
                commit;
                dbms_output.put_line('New Category Added: ' || categoryName); 
            end if;
        
        exception
        
            when exp_NULL_VALUE
                then
                    dbms_output.new_line;
                    dbms_output.put_line('---------------------------');
                    dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
                    dbms_output.put_line('---------------------------');
                    dbms_output.put_line('CategoryName: ' || CategoryName);
                    dbms_output.put_line('---------------------------');
                
            when exp_CATEGORY_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CATEGORY ALREADY EXISTS, ASSIGN A NAME THAT IS NOT USED ALREADY'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CategoryName: ' || CategoryName);
                dbms_output.put_line('---------------------------');
            when others
            then 
                dbms_output.put_line('Exception Occurred');
                e_code := SQLCODE;
                e_msg := SQLERRM;
                dbms_output.put_line('Error Code: ' || e_code);
                dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
        end PROC_ADD_NEW_CATEGORY;
        
        --proc : PROC_ADD_NEW_SECTION_CATEGORY(SectionID, CategoryID)
        procedure
        PROC_ADD_NEW_SECTION_CATEGORY(
            SectionID NUMBER,
            CategoryID NUMBER
        ) is
            sectionCount NUMBER;
            categoryCount NUMBER;
            sectionCategoryCount NUMBER;
            e_code NUMBER;
            e_msg VARCHAR(255);
            exp_SECTION_CATEGORY_EXISTS exception;
            exp_SECTION_NOT_EXISTS exception;
            exp_CATEGORY_NOT_EXISTS exception;
            exp_NULL_VALUE exception;
        begin
        
            if SectionID IS NULL
            or CategoryID IS NULL
            then
                raise exp_NULL_VALUE;
            end if;
            
            select count(1) into sectionCount from section
            where section_id=SectionID;
            
            select count(1) into categoryCount from category
            where category_id=CategoryID;
            
            select count(1) into sectionCategoryCount from section_category 
            where section_id=SectionID and category_id=CategoryID;
            
            if sectionCount<=0
                then
                    raise exp_SECTION_NOT_EXISTS;
            end if;
            
            if categoryCount<=0
                then
                    raise exp_CATEGORY_NOT_EXISTS;
            end if;
            
            
            if sectionCategoryCount>0
            then
                raise exp_SECTION_CATEGORY_EXISTS;
            else
                insert into section_category values(SEQ_SC_SC_ID.nextval, SectionID, CategoryID);
                commit;
                dbms_output.put_line('New Section Category Added: ' || '('||SectionID||')' || '('||CategoryID||')'); 
            end if;
        
        exception
        
            when exp_NULL_VALUE
                then
                    dbms_output.new_line;
                    dbms_output.put_line('---------------------------');
                    dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
                    dbms_output.put_line('---------------------------');
                    dbms_output.put_line('SectionID: ' || SectionID);
                    dbms_output.put_line('CategoryID: ' || CategoryID);
                    dbms_output.put_line('---------------------------');
                
            when exp_SECTION_NOT_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SECTION DOES NOT EXIST, USE ONE THAT EXISTS ALREADY, OR CREATE A NEW ONE'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SectionID: ' || SectionID);
                dbms_output.put_line('---------------------------');
        
            when exp_CATEGORY_NOT_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CATEGORY DOES NOT EXIST, USE ONE THAT EXISTS ALREADY, OR CREATE A NEW ONE'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CategoryID: ' || CategoryID);
                dbms_output.put_line('---------------------------');
                
            when exp_SECTION_CATEGORY_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SECTION CATEGORY ALREADY EXISTS, YOU CAN CREATE A SECTION CATEGORY ONLY ONCE'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SectionID: ' || SectionID);
                dbms_output.put_line('CategoryID: ' || CategoryID);
                dbms_output.put_line('---------------------------');
                
            when others
            then 
                dbms_output.put_line('Exception Occurred');
                e_code := SQLCODE;
                e_msg := SQLERRM;
                dbms_output.put_line('Error Code: ' || e_code);
                dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
        end PROC_ADD_NEW_SECTION_CATEGORY;
        
        --proc : PROC_ADD_NEW_SEATS(SectionCategoryID, SeatRow, NumberOfSeatsInRow)
        procedure
        PROC_ADD_NEW_SEATS(
            SectionCategoryID NUMBER,
            SeatRow VARCHAR,
            NumberOfSeatsInRow NUMBER
        ) is
            sectionCategoryCount NUMBER;
            seatRowCount NUMBER;
            e_code NUMBER;
            e_msg VARCHAR(255);
            exp_SECTION_CATEGORY_NOT_EXISTS exception;
            exp_SEAT_ROW_ALREADY_EXISTS exception;
            exp_NULL_VALUE exception;
            exp_INVALID_SEAT_COUNT exception;
        begin
        
            if SectionCategoryID IS NULL
            or SeatRow IS NULL
            or NumberOfSeatsInRow IS NULL
            then
                raise exp_NULL_VALUE;
            end if;
            
            select count(1) into sectionCategoryCount from section_category where sc_id=SectionCategoryID;
            if sectionCategoryCount<=0
            then
                raise exp_SECTION_CATEGORY_NOT_EXISTS;
            end if;
            
            select count(1) into seatRowCount from seat where seat_row=SeatRow and sc_id=SectionCategoryID;
            if seatRowCount>0
            then
                raise exp_SEAT_ROW_ALREADY_EXISTS;
            end if;
            
            if NumberOfSeatsInRow<=0
            then
                raise exp_INVALID_SEAT_COUNT;
            end if;
            
            for seatNo in 1..NumberOfSeatsInRow
            loop
                insert into seat values(SEQ_SEA_SEAT_ID.nextval, SectionCategoryID, SeatRow, seatNo);
            end loop;
            
            commit;
            dbms_output.put_line(NumberOfSeatsInRow || ' Seats added to '|| '('||'SectionCategoryID: '||SectionCategoryID||' ,'||' SeatRow: '||SeatRow||')');
        
        exception
        
            when exp_NULL_VALUE
                then
                    dbms_output.new_line;
                    dbms_output.put_line('---------------------------');
                    dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
                    dbms_output.put_line('---------------------------');
                    dbms_output.put_line('SectionCategoryID: ' || SectionCategoryID);
                    dbms_output.put_line('SeatRow: ' || SeatRow);
                    dbms_output.put_line('NumberOfSeatsInRow: ' || NumberOfSeatsInRow);
                    dbms_output.put_line('---------------------------');
                
            when exp_SECTION_CATEGORY_NOT_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SECTION CATEGORY DOES NOT EXISTS, CREATE SEATS FOR SECTION CATEGORY THAT EXISTS, OR FIRST CREATE A NEW ONE'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SectionCategoryID: ' || SectionCategoryID);
                dbms_output.put_line('---------------------------');
                 
            when exp_SEAT_ROW_ALREADY_EXISTS
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SEAT ROW ALREADY EXISTS FOR SECTION CATEGORY, CREATE SEATS FOR SEAT ROW THAT DOES NOT EXIST'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SectionCategoryID: ' || SectionCategoryID);
                dbms_output.put_line('SeatRowID: ' || SeatRow);
                dbms_output.put_line('---------------------------');
                
            when exp_INVALID_SEAT_COUNT
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('INVALID SEAT COUNT FOR SEAT ROW, GIVE THE SEAT COUNT >=1'); 
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('NumberOfSeatsInRow: ' || NumberOfSeatsInRow);
                dbms_output.put_line('---------------------------');
                
            when others
            then 
                dbms_output.put_line('Exception Occurred');
                e_code := SQLCODE;
                e_msg := SQLERRM;
                dbms_output.put_line('Error Code: ' || e_code);
                dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
        end PROC_ADD_NEW_SEATS;

END PACK_STADIUM_MANAGEMENT;
/

--Ticket Management Module : PACK_TICKET_MANAGEMENT BODY
CREATE OR REPLACE
PACKAGE BODY PACK_TICKET_MANAGEMENT AS
    
    --FUNC_CALC_PRICE_WITH_DISCOUNT
    function
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
    end FUNC_CALC_PRICE_WITH_DISCOUNT;

    --FUNC_CALC_PRICE_WITH_TAX
    function
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
    end FUNC_CALC_PRICE_WITH_TAX;

    --PROC_GET_ESTIMATE
    procedure
    PROC_GET_ESTIMATE(
        CustomerID NUMBER,
        MatchID NUMBER,
        ListOfSelectedSeatIDs seatIDList,
        DiscountCouponName VARCHAR,
        ActualTotalPrice OUT NUMBER,
        DiscountedTotalPrice OUT NUMBER,
        DiscountedTotalPriceWithTax OUT NUMBER,
        SavedPrice OUT NUMBER,
        CustomerWarning OUT VARCHAR,
        statusFlag OUT VARCHAR
    )
    is
        a NUMBER;
        s VARCHAR(1000);
        discountFlag NUMBER;
        e_code NUMBER;
        e_msg VARCHAR2(255);
        exp_NULL_VALUES exception;
        exp_customerNotFound exception;
        exp_matchNotFound exception;
        exp_seatsNotFound exception;    
    begin
    
        dbms_output.new_line;
        dbms_output.put_line('***************************');
        dbms_output.put_line('PROC_GET_ESTIMATE');
        dbms_output.put_line('***************************');
        if
        CustomerID is null or
        MatchID is null or
        ListOfSelectedSeatIDs is null
        then
            CustomerWarning:='CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES';
            raise exp_NULL_VALUES;
        end if;
        
        dbms_output.new_line;
        dbms_output.put_line('Checking if customer exists');
        select count(1) into a from customer where cust_id=CustomerID;
        if a!=1
            then 
            CustomerWarning:='BOOK THE TICKET FOR EXISTING CUSTOMER';
            raise exp_customerNotFound;
        end if;
    
        dbms_output.put_line('Checking if match exists');
        select count(1) into a from V_UPCOMING_MATCHES where match_id=MatchID;
        if a!=1
            then 
            CustomerWarning:='BOOK THE TICKET FOR UPCOMING MATCH';
            raise exp_matchNotFound;
        end if;
    
        dbms_output.put_line('Checking if seats exist');
        select count(1) into a from V_SHOW_SEAT_STATUS_CUSTOMER where seat_id member of ListOfSelectedSeatIDs and Booking_Status='N';
        if a!=ListOfSelectedSeatIDs.count
            then 
            CustomerWarning:='BOOK THE TICKET FOR SEATS WITH CORRECT/AVAILABLE SEAT IDS';
            raise exp_seatsNotFound;
        end if;
    
    
        dbms_output.put_line('Checking if discount coupon exist');
        if DiscountCouponName is null
        then
            discountFlag:=0;
        else
            select count(1) into a from V_DISCOUNTS 
            where upper(coupon_code)=upper(DiscountCouponName)
            and systimestamp between valid_from and valid_till;
        
            if a=0
            then
                discountFlag:=1;
            end if;
            
        end if;
    
    
        dbms_output.put_line('GETTING ESTIMATE');
        
        select SUM(ticket_cost) into ActualTotalPrice
        from V_SHOW_SEAT_STATUS_CUSTOMER 
        where match_id=MatchID and seat_id member of ListOfSelectedSeatIDs;
    
        
        if discountFlag=0
        then
            DiscountedTotalPrice:=ActualTotalPrice;
            DiscountedTotalPriceWithTax:=FUNC_CALC_PRICE_WITH_TAX(DiscountedTotalPrice);
            CustomerWarning:='DISCOUNT COUPON NOT APPLIED, SHOWING ACTUAL PRICE + TAXES'; 
            statusFlag:='EST_100_NODISCCOUPON';
        elsif discountFlag=1
        then
            DiscountedTotalPrice:=ActualTotalPrice;
            DiscountedTotalPriceWithTax:=FUNC_CALC_PRICE_WITH_TAX(DiscountedTotalPrice);
            CustomerWarning:='DISCOUNT COUPON NOT FOUND, SHOWING ACTUAL PRICE + TAXES'; 
            statusFlag:='EST_101_DISCNOTFOUND';
        else
        
            --Call the function to calculate the discounted price
            select discount into a from V_DISCOUNTS 
            where upper(coupon_code)=upper(DiscountCouponName)
            and systimestamp between valid_from and valid_till;
            
            CustomerWarning:='DISCOUNT COUPON APPLIED, SHOWING DISCOUNT PRICE + TAXES';
            statusFlag:='EST_102_DISCFOUND';
            dbms_output.put_line('APPLYING DISCOUNT COUPON: ' || DiscountCouponName);
            dbms_output.put_line('DISCOUNT PERCENTAGE: ' || to_char(a) || '% OFF');
            DiscountedTotalPrice:=FUNC_CALC_PRICE_WITH_DISCOUNT(ActualTotalPrice, a);
            DiscountedTotalPriceWithTax:=FUNC_CALC_PRICE_WITH_TAX(DiscountedTotalPrice);
            
            
        end if;
            
            SavedPrice:=ActualTotalPrice-DiscountedTotalPrice;
            dbms_output.put_line('MESSAGE: ' || CustomerWarning);      
            dbms_output.put_line('ACTUAL TOTAL PRICE: $' || ActualTotalPrice);
            dbms_output.put_line('DISCOUNTED PRICE: $' || DiscountedTotalPrice);
            dbms_output.put_line('AFTER TAX PRICE: $' || DiscountedTotalPriceWithTax);
            dbms_output.put_line('YOU SAVED: $' || SavedPrice);
    
    exception
    
        when exp_NULL_VALUES
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line(CustomerWarning); 
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
                statusFlag:='EST_001_NULLVALUES';
                
        when exp_customerNotFound
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CUSTOMER ID DOES NOT EXIST : ' || CustomerID );
                dbms_output.put_line('---------------------------');
                dbms_output.put_line(CustomerWarning);
                dbms_output.put_line('---------------------------');
                statusFlag:='EST_002_CUSTNOTFOUND';
    
        when exp_matchNotFound
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('MATCH ID DOES NOT EXIST : ' || MatchID );
                dbms_output.put_line('---------------------------');
                dbms_output.put_line(CustomerWarning);
                dbms_output.put_line('---------------------------');
                statusFlag:='EST_003_MATCHNOTFOUND';
                
    
        when exp_seatsNotFound
            then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('SOME SEAT IDs ARE NOT AVAILABLE FOR THIS MATCH');
                dbms_output.put_line('---------------------------');
                dbms_output.put_line(CustomerWarning);
                dbms_output.put_line('---------------------------');
                statusFlag:='EST_004_SEATSNOTAVAILABLE';
    
        when others
            then 
                dbms_output.put_line('Exception Occurred');
                e_code := SQLCODE;
                e_msg := SQLERRM;
                dbms_output.put_line('Error Code: ' || e_code);
                dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255));
                statusFlag:='EST_005_UNKNOWN';
                CustomerWarning:= 'UNKNOWN ERROR: ' || ' ' ||e_code || ' ' ||SUBSTR(e_msg, 1, 255);
    end PROC_GET_ESTIMATE;

    --PROC_BOOK_TICKET
    procedure
    PROC_BOOK_TICKET(
        CustomerID NUMBER,
        MatchID NUMBER,
        ListOfSelectedSeatIDs seatIDList,
        DiscountCouponName VARCHAR,
        PaymentMode VARCHAR
    ) is
    
        ap NUMBER;
        dp NUMBER;
        tp NUMBER;
        sp NUMBER;
        sf VARCHAR(255);
        cmsg VARCHAR(255);
        did NUMBER(20);
        pid NUMBER(20);
        currentSeatID number;
        e_code NUMBER;
        e_msg VARCHAR2(255);
        exp_seatNotAvailableForBooking exception;
    begin
    
        PROC_GET_ESTIMATE(CustomerID,MatchID, ListOfSelectedSeatIDs, DiscountCouponName, ap, dp, tp, sp,cmsg, sf);
    
        dbms_output.new_line;
        dbms_output.put_line('***************************');
        dbms_output.put_line('PROC_BOOK_TICKET');
        dbms_output.put_line('***************************');
    
        
        if sf='EST_001_NULLVALUES'
        or sf='EST_002_CUSTNOTFOUND'
        or sf='EST_003_MATCHNOTFOUND'
        or sf='EST_004_SEATSNOTAVAILABLE'
        or sf='EST_005_UNKNOWN'
        then
            dbms_output.put_line('ERROR(While getting estimate) : ' || cmsg);
    
        else
    
            if sf='EST_100_NODISCCOUPON'
            or sf='EST_101_DISCNOTFOUND'
            then
                did:=NULL;
                
            elsif sf='EST_102_DISCFOUND'
            then
                --find discount id corresponding to discountcouponname
                select discount_id into did from discount where upper(coupon_name)=upper(DiscountCouponName);
     
            end if;   
            
            dbms_output.new_line;
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('Booking a ticket');
            dbms_output.put_line('---------------------------');
            
            --add entry to payment table
            dbms_output.put_line('Payment In Process');
            pid:=SEQ_PAY_PAYMENT_ID.nextval;
            INSERT INTO payment (payment_id,discount_id, tot_amount, p_date_time, payment_mode)
            VALUES (pid,did,tp,systimestamp,PaymentMode);
            
            --try to add tickets one by one to tickets table
            declare
                a number;
                seatNotAvailableForBooking number;
                currentTID number;
            begin
                
                for i in 1..ListOfSelectedSeatIDs.count 
                loop
                    currentSeatID:=ListOfSelectedSeatIDs(i);
                    select count(1) into a from V_SHOW_SEAT_STATUS_CUSTOMER
                    where match_id=MatchID and seat_id=currentSeatID and booking_status='N';
                    
                    if a=1
                    then
                        dbms_output.put_line('For match ' || MatchID || ' creating ticket for seat: ' || currentSeatID);
                        currentTID:=SEQ_TIC_TICKET_ID.nextval;
                        
                        INSERT INTO ticket (ticket_id, cust_id, seat_id, rfd_id, payment_id, match_id)
                        VALUES (currentTID,CustomerID,currentSeatID,NULL,pid,MatchID);
                        
                    else
                        seatNotAvailableForBooking:=1;
                        exit;
                    end if;
                end loop;
                
                if seatNotAvailableForBooking=1
                then
                    raise exp_seatNotAvailableForBooking;
                end if;
                
            end;
            
            dbms_output.put_line('Payment Complete');
            dbms_output.put_line('Tickets Booked for seats');    
            dbms_output.put_line('MESSAGE: ' || cmsg);      
            dbms_output.put_line('ACTUAL TOTAL PRICE: $' || ap);
            dbms_output.put_line('DISCOUNTED PRICE: $' || dp);
            dbms_output.put_line('AFTER TAX PRICE: $' || tp);
            dbms_output.put_line('YOU SAVED: $' || sp);
            dbms_output.put_line('PAYMENT ID: ' || pid);
            dbms_output.put_line('---------------------------');
        end if;
    
    
    
        --Persist the payment information/ticket details
        commit;
    
    exception
    
        when exp_seatNotAvailableForBooking
            then
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('Seat ID: ' || currentSeatID || ' not available for booking');
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('Cancelling the ticket booking transaction');
                dbms_output.put_line('Check the available seats again and book new ones');
                dbms_output.put_line('---------------------------');
                rollback;
                
        when others
            then 
                dbms_output.put_line('Exception Occurred');
                e_code := SQLCODE;
                e_msg := SQLERRM;
                dbms_output.put_line('Error Code: ' || e_code);
                dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255));
                rollback;
    end PROC_BOOK_TICKET;

END PACK_TICKET_MANAGEMENT;
/
