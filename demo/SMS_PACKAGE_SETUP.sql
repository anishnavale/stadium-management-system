/*

PACKAGE SETUP

*/


set serveroutput on;
PURGE RECYCLEBIN;

--Stadium Setup Module : PACK_STADIUM_MANAGEMENT
create or replace PACKAGE PACK_STADIUM_MANAGEMENT AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 

    procedure 
    PROC_ADD_NEW_SECTION(
        SectionName VARCHAR2,
        GateName VARCHAR2,
        GateStreet VARCHAR2, 
        GateCity VARCHAR2, 
        GateState VARCHAR2,
        GatePincode VARCHAR2
    );

    procedure 
    PROC_UPDATE_SECTION(
        SectionID NUMBER,
        GateName VARCHAR2,
        GateStreet VARCHAR2, 
        GateCity VARCHAR2, 
        GateState VARCHAR2,
        GatePincode VARCHAR2
    );

    procedure
    PROC_ADD_NEW_CATEGORY(
        CategoryName VARCHAR
    );

    procedure
    PROC_ADD_NEW_SECTION_CATEGORY(
        SectionID NUMBER,
        CategoryID NUMBER
    );

    procedure
    PROC_ADD_NEW_SEATS(
        SectionCategoryID NUMBER,
        SeatRow VARCHAR,
        NumberOfSeatsInRow NUMBER
    );



END PACK_STADIUM_MANAGEMENT;
/

--Match Management Module : PACK_MATCH_MANAGEMENT
create or replace PACKAGE PACK_MATCH_MANAGEMENT AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 

  PROCEDURE PROC_ADD_NEW_MATCH(
        in_league_name VARCHAR,
        in_team1 VARCHAR,
        in_team2 VARCHAR,
        in_start_time TIMESTAMP,
        in_end_time TIMESTAMP,
        in_match_active VARCHAR
    );

    PROCEDURE PROC_MODIFY_MATCH(
        in_match_id NUMBER,
        in_league_name VARCHAR,
        in_team1 VARCHAR,
        in_team2 VARCHAR,
        in_start_time TIMESTAMP,
        in_end_time TIMESTAMP,
        in_match_active VARCHAR
    );

END PACK_MATCH_MANAGEMENT;
/

--Pricing Management Module : PACK_PRICING_MANAGEMENT

create or replace PACKAGE PACK_PRICING_MANAGEMENT AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 

  procedure proc_add_in_price_catlog(match_id_val int, sc_id_val int, amount_val int);

  procedure proc_add_discount (coupon_name_val varchar2, discount_perc_val int, start_date timestamp, end_date timestamp);


END PACK_PRICING_MANAGEMENT;
/

--Ticket Management Module : PACK_TICKET_MANAGEMENT
create or replace PACKAGE PACK_TICKET_MANAGEMENT AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 

    function
    FUNC_CALC_PRICE_WITH_DISCOUNT(
        ActualTotalPrice NUMBER,
        DiscountPercentage NUMBER
    )return number;

    function
    FUNC_CALC_PRICE_WITH_TAX(
        FinalDiscountPrice NUMBER
    )
    return number;

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
    );

    procedure
    PROC_BOOK_TICKET(
        CustomerID NUMBER,
        MatchID NUMBER,
        ListOfSelectedSeatIDs seatIDList,
        DiscountCouponName VARCHAR,
        PaymentMode VARCHAR
    );
    
    procedure
    PROC_ADD_CUSTOMER(  
        CUST_FNAME    VARCHAR2,
        CUST_LNAME    VARCHAR2,
        CUST_EMAIL    VARCHAR2,  
        CUST_CONTACT  VARCHAR2,
        CUST_DOB      DATE,        
        CUST_STREET   VARCHAR2, 
        CUST_CITY     VARCHAR2,  
        CUST_STATE    VARCHAR2,  
        CUST_PINCODE  NUMBER
    );


  procedure
    PROC_CANCEL_TICKET(
        CustomerID NUMBER,
        PaymentID NUMBER,
        RefundReason VARCHAR2,
        CurrentTimeStamp TIMESTAMP
    );

END PACK_TICKET_MANAGEMENT;
/

--GameDay Management Module : PACK_GAMEDAY_MANAGEMENT

create or replace PACKAGE PACK_GAMEDAY_MANAGEMENT AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 

  PROCEDURE PROC_VERIFY_TICKET(
        in_ticket_id NUMBER,
        in_date_time TIMESTAMP
    );

END PACK_GAMEDAY_MANAGEMENT;
/