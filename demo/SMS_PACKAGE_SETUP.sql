/*

PACKAGE SETUP

*/


set serveroutput on;
PURGE RECYCLEBIN;

--Stadium Setup Module : PACK_STADIUM_MANAGEMENT
CREATE OR REPLACE 
PACKAGE PACK_STADIUM_MANAGEMENT AS 

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

--Ticket Management Module : PACK_TICKET_MANAGEMENT
CREATE OR REPLACE 
PACKAGE PACK_TICKET_MANAGEMENT AS 

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
    

END PACK_TICKET_MANAGEMENT;
/
