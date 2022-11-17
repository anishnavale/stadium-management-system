/*select * from session_privs;
select * from session_roles;
drop table section_category;
drop table section;
drop table category;*/

PURGE RECYCLEBIN;

SET SERVEROUTPUT ON;

DECLARE
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from user_tables where table_name='SECTION_CATEGORY';
    IF IS_TRUE > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE section_category';
    END IF;
END;
/

DECLARE
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from user_tables where table_name='SECTION';
    IF IS_TRUE > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE section';
    END IF;
END;
/

DECLARE
    is_true number;
begin
    select count(*) 
    INTO IS_TRUE
    from user_tables where table_name='CATEGORY';
    IF IS_TRUE > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE category';
    END IF;
END;
/

-- Create table section
create table section (
section_id number(20),
section_name varchar(30),
gate_name varchar(30),
gate_street varchar(100),
gate_city varchar(50),
gate_state varchar(50),
gate_pincode number(10)
);

-- Create table category
create table category (
category_id number(20),
category_name varchar(30)
);

-- Create table section_category
create table section_category (
sc_id number(20),
section_id number(20),
category_id number(20)
);

-- Create Primary Key constraint for section_id in section table
ALTER TABLE section
ADD CONSTRAINT PK_section_id Primary key (section_id);

-- Create Not Null constraint for section_name in section table
ALTER TABLE section
MODIFY (section_name varchar(30) CONSTRAINT NN_section_name NOT NULL);

-- Create Primary Key constraint for category_id in category table
ALTER TABLE category
ADD CONSTRAINT PK_category_id Primary key (category_id);

-- Create Not Null constraint for category_name in category table
ALTER TABLE category
MODIFY (category_name varchar(30) CONSTRAINT NN_category_name NOT NULL);

-- Create Primary Key constraint for sc_id in section_category table
ALTER TABLE section_category
ADD CONSTRAINT PK_sc_id Primary key (sc_id);

-- Create Foreign Key constraint for section_id in section_category table
ALTER TABLE section_categorys
ADD CONSTRAINT FK_section_id foreign key (section_id) references section (section_id);

-- Create Foreign Key constraint for category_id in section_category table
ALTER TABLE section_category
ADD CONSTRAINT FK_category_id foreign key (category_id) references category (category_id);


