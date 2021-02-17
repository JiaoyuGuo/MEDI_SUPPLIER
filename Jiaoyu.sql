---create tables
drop table fe_jg_medi_dba_category
drop table fe_jg_medi_category
drop table fe_jg_medi_phone
drop table fe_jg_medi_address
drop table fe_jg_medi_dba
drop table fe_jg_medi_company

CREATE TABLE fe_jg_medi_address (
    address_pk   NUMBER NOT NULL,
    address      VARCHAR2(255),
    address2     VARCHAR2(255),
    city         VARCHAR2(255),
    state_code   VARCHAR2(5),
    zip          VARCHAR2(25),
    dba_fk       NUMBER NOT NULL
);

ALTER TABLE fe_jg_medi_address ADD CONSTRAINT fe_jg_medi_address_pk PRIMARY KEY ( address_pk );

CREATE TABLE fe_jg_medi_category (
    category_pk   NUMBER NOT NULL,
    name          VARCHAR2(255)
);

ALTER TABLE fe_jg_medi_category ADD CONSTRAINT fe_jg_medi_category_pk PRIMARY KEY ( category_pk );

CREATE TABLE fe_jg_medi_company (
    company_pk   NUMBER NOT NULL,
    name         VARCHAR2(255)
);

ALTER TABLE fe_jg_medi_company ADD CONSTRAINT fe_jg_medi_company_pk PRIMARY KEY ( company_pk );

CREATE TABLE fe_jg_medi_dba (
    dba_pk       NUMBER NOT NULL,
    name         VARCHAR2(255),
    company_fk   NUMBER NOT NULL
);

ALTER TABLE fe_jg_medi_dba ADD CONSTRAINT fe_jg_medi_dba_pk PRIMARY KEY ( dba_pk );

CREATE TABLE fe_jg_medi_dba_category (
    dba_category_pk   NUMBER NOT NULL,
    dba_fk            NUMBER NOT NULL,
    category_fk       NUMBER NOT NULL
);

ALTER TABLE fe_jg_medi_dba_category ADD CONSTRAINT fe_jg_medi_dba_category_pk PRIMARY KEY ( dba_category_pk );

CREATE TABLE fe_jg_medi_phone (
    phone_pk       NUMBER NOT NULL,
    phone_number   VARCHAR2(25),
    address_fk     NUMBER NOT NULL
);

ALTER TABLE fe_jg_medi_phone ADD CONSTRAINT fe_jg_medi_phone_pk PRIMARY KEY ( phone_pk );

ALTER TABLE fe_jg_medi_address
    ADD CONSTRAINT fe_jg_medi_address_dba_fk FOREIGN KEY ( dba_fk )
        REFERENCES fe_jg_medi_dba ( dba_pk );

ALTER TABLE fe_jg_medi_dba_category
    ADD CONSTRAINT fe_jg_medi_dba_cat_category_fk FOREIGN KEY ( category_fk )
        REFERENCES fe_jg_medi_category ( category_pk );

ALTER TABLE fe_jg_medi_dba_category
    ADD CONSTRAINT fe_jg_medi_dba_cat_dba_fk FOREIGN KEY ( dba_fk )
        REFERENCES fe_jg_medi_dba ( dba_pk );

ALTER TABLE fe_jg_medi_dba
    ADD CONSTRAINT fe_jg_medi_dba_company_fk FOREIGN KEY ( company_fk )
        REFERENCES fe_jg_medi_company ( company_pk );

ALTER TABLE fe_jg_medi_phone
    ADD CONSTRAINT fe_jg_medi_phone_address_fk FOREIGN KEY ( address_fk )
        REFERENCES fe_jg_medi_address ( address_pk );






---create sequence
drop sequence seq_FE_JG_MEDI_ADDRESS;
drop sequence seq_FE_JG_MEDI_CATEGORY;
drop sequence seq_FE_JG_MEDI_COMPANY;
drop sequence seq_FE_JG_MEDI_DBA;
drop sequence seq_FE_JG_MEDI_DBA_CATEGORY;
drop sequence seq_FE_JG_MEDI_PHONE;
select 'create sequence seq_'||substr(table_name,1,26)||';'
from user_tables
where table_name like 'FE_JG_MEDI%'

create sequence seq_FE_JG_MEDI_ADDRESS;
create sequence seq_FE_JG_MEDI_CATEGORY;
create sequence seq_FE_JG_MEDI_COMPANY;
create sequence seq_FE_JG_MEDI_DBA;
create sequence seq_FE_JG_MEDI_DBA_CATEGORY;
create sequence seq_FE_JG_MEDI_PHONE;

---create trigger for primary key
select 'create or replace trigger bi_'||table_name||'
        before insert on '||table_name||'
        for each row
        declare
            v_pk number;
         begin
            if :new.'||replace(table_name,'FE_JG_MEDI_')||'_pk is null then
               select seq_'||table_name||'.nextval into v_pk
    from dual;
        
        :new.'||replace(table_name,'FE_JG_MEDI_')||'_pk := v_pk;
             end if;
         end;'||chr(10)||'/'||chr(10) trig
from user_tables
where table_name like 'FE_JG_MEDI_%'


 create or replace trigger bi_FE_JG_MEDI_ADDRESS
before insert on FE_JG_MEDI_ADDRESS
for each row
declare
v_pk number;
begin
    if :new.ADDRESS_pk is null then
        select seq_FE_JG_MEDI_ADDRESS.nextval
        into v_pk
        from dual;

        :new.ADDRESS_pk := v_pk;
    end if;
end;
/
 
 create or replace trigger bi_FE_JG_MEDI_CATEGORY
before insert on FE_JG_MEDI_CATEGORY
for each row
declare
v_pk number;
begin
    if :new.CATEGORY_pk is null then
        select seq_FE_JG_MEDI_CATEGORY.nextval
        into v_pk
        from dual;

        :new.CATEGORY_pk := v_pk;
    end if;
end;
/
 
 create or replace trigger bi_FE_JG_MEDI_COMPANY
before insert on FE_JG_MEDI_COMPANY
for each row
declare
v_pk number;
begin
    if :new.COMPANY_pk is null then
        select seq_FE_JG_MEDI_COMPANY.nextval
        into v_pk
        from dual;

        :new.COMPANY_pk := v_pk;
    end if;
end;
/
 
 create or replace trigger bi_FE_JG_MEDI_DBA
before insert on FE_JG_MEDI_DBA
for each row
declare
v_pk number;
begin
    if :new.DBA_pk is null then
        select seq_FE_JG_MEDI_DBA.nextval
        into v_pk
        from dual;

        :new.DBA_pk := v_pk;
    end if;
end;
/
 
 create or replace trigger bi_FE_JG_MEDI_DBA_CATEGORY
before insert on FE_JG_MEDI_DBA_CATEGORY
for each row
declare
v_pk number;
begin
    if :new.DBA_CATEGORY_pk is null then
        select seq_FE_JG_MEDI_DBA_CATEGORY.nextval
        into v_pk
        from dual;

        :new.DBA_CATEGORY_pk := v_pk;
    end if;
end;
/
 
 create or replace trigger bi_FE_JG_MEDI_PHONE
before insert on FE_JG_MEDI_PHONE
for each row
declare
v_pk number;
begin
    if :new.PHONE_pk is null then
        select seq_FE_JG_MEDI_PHONE.nextval
        into v_pk
        from dual;

        :new.PHONE_pk := v_pk;
    end if;
end;
/
 
--create a package to insert data
------- create package and load data with efficient way 

---create package 
CREATE OR REPLACE PACKAGE pkg_FE_JG_medi AS
    PROCEDURE p_process_all;

END pkg_FE_JG_medi;


---- create package body 
create or replace package body PKG_FE_JG_MEDI as 
   
-- 1. load company
procedure p_fe_load_company as

    CURSOR cur_company is
    SELECT
        seq_FE_JG_medi_company.NEXTVAL company_pk,company_name
    FROM
        (
            SELECT DISTINCT trim(upper(company_name)) company_name FROM masy_ib48.medi_supplier_stage
            minus 
            select name
            from FE_JG_MEDI_COMPANY
        );
    
    --define my type 
    type tt_company is table of FE_JG_MEDI_COMPANY%rowtype index by pls_integer;
    --- use this var
    company_list tt_company;
    
cursor cur_company is 
        select SEQ_FE_JG_MEDI_COMPANY.nextval company_pk, company_name
        from (
            select distinct trim(upper(company_name)) company_name
            from MASY_IB48.MEDI_SUPPLIER_STAGE
            minus
            select name from fe_jg_medi_company);
    --define my type        
    type tt_COMPANY is table of fe_jg_medi_company%rowtype index by PLS_INTEGER;
    --use this variable 
    company_list  tt_COMPANY;
    
--TIMER
    start_time number;
    end_time number;
Begin
    ---get the start time
    start_time :=dbms_utility.get_time;
    --open my cursor
    open cur_company;
        loop 
            --- loop through cursor limit at a time
            fetch cur_company bulk collect into company_list limit 1000;
            ---loop through what I just fetch
            for indx in 1..company_list.count loop
                insert into fe_jg_medi_company
                values company_list(indx);
            end loop;
            --exit loop
            exit when cur_company%notfound;
        END LOOP; 

    --- close cursor
    close cur_company;
    end_time := dbms_utility.get_time;
    dbms_output.put_line('Elapsed when load company:' ||(end_time - start_time) / 100);
    
END;



------------------------------------------------------------------------
-- 2. load category

procedure p_fe_load_category as
    
    cursor cur_CATEGORY is 
        select SEQ_FE_JG_MEDI_CATEGORY.nextval CATEGORY_PK, product_category 
        from (
            select distinct trim(upper(product_category)) product_category 
            from MASY_IB48.MEDI_SUPPLIER_STAGE
            minus
            select name from FE_JG_MEDI_CATEGORY);
    --define my type        
    type tt_CATEGORY is table of FE_JG_MEDI_CATEGORY%rowtype index by PLS_INTEGER;
    --use this variable 
    CATEGORY_list  tt_CATEGORY;
    
--TIMER
    start_time number;
    end_time number;
Begin
    ---get the start time
    start_time :=dbms_utility.get_time;
    --open my cursor
    open cur_CATEGORY;
        loop 
            --- loop through cursor limit at a time
            fetch cur_CATEGORY bulk collect into CATEGORY_list limit 1000;
            ---loop through what I just fetch
            for indx in 1..CATEGORY_list.count loop
                insert into FE_JG_MEDI_CATEGORY
                values CATEGORY_list(indx);
            end loop;
            --exit loop
            exit when cur_CATEGORY%notfound;
        END LOOP;   
      
    --- close cursor
    close cur_category;

    end_time := dbms_utility.get_time;
    dbms_output.put_line('Elapsed when load category:' ||(end_time - start_time) / 100);
END;




------------------------------------------------------------------------
-- 3. load DBA
procedure p_fe_load_dba as

    cursor cur_DBA is 
        select Seq_FE_JG_MEDI_DBA.nextval DBA_PK, dba_name,company_fk 
            from (
            select trim(upper(dba_name)) dba_name, company_pk company_fk 
    from (select distinct company_name, dba_name from MASY_IB48.MEDI_SUPPLIER_STAGE) data, 
    FE_JG_MEDI_COMPANY company
    where data.company_name=company.name
    minus
    select NAME, COMPANY_FK from FE_JG_MEDI_DBA);
 
    --define my type        
    type tt_DBA is table of FE_JG_MEDI_DBA%rowtype index by PLS_INTEGER;
    --use this variable 
    DBA_list  tt_DBA;
    
--TIMER
    start_time number;
    end_time number;
Begin
    ---get the start time
    start_time :=dbms_utility.get_time;
    --open my cursor
    open cur_DBA;
        loop 
            --- loop through cursor limit at a time
            fetch cur_DBA bulk collect into DBA_list limit 1000;
            ---loop through what I just fetch
            for indx in 1..DBA_list.count loop
                insert into FE_JG_MEDI_DBA
                values DBA_list(indx);
            end loop;
            --fluhes from memory to disk
            commit;
            --exit loop
            exit when cur_DBA%notfound;
        END LOOP;   

    
    
    --- close cursor
    close cur_dba;
    end_time := dbms_utility.get_time;
    dbms_output.put_line('Elapsed when load DBA:' ||(end_time - start_time) / 100);
END;


------------------------------------------------------------------------
-- 4. load dba category
procedure  p_fe_load_dba_category as 

    CURSOR cur_dba_category IS
    SELECT
        seq_FE_JG_medi_dba_category.NEXTVAL dba_category_pk,
        dba_fk,
        category_fk
        
    FROM
        (
            select dba_pk dba_fk,
                   category_pk category_fk
             from (select dba_name,product_category from masy_ib48.medi_supplier_stage) data,
                   FE_JG_MEDI_DBA dba,
                   FE_JG_MEDI_CATEGORY category
              where trim(upper(data.dba_name)) = trim(upper(dba.name))
                and trim(upper(data.product_category)) = trim(upper(category.name))
              
              minus 
              select dba_fk,category_fk
              from FE_JG_MEDI_dba_category
        );
    
    --define my type 
    type tt_dba_category is table of FE_JG_MEDI_dba_category%rowtype index by pls_integer;
    --- use this var
    dba_category_list tt_dba_category;
    
    --timer 
    start_time  NUMBER;
    end_time    NUMBER;

BEGIN
    --- get the start time 
    start_time := dbms_utility.get_time;
    
    ---open cursor 
    open cur_dba_category;
        loop
              ---- use bulk to fetch >1
             fetch cur_dba_category bulk collect into dba_category_list limit 1000;
             --- loop through whay i just fetch
                for indx in 1..dba_category_list.count loop
                   insert into FE_JG_MEDI_dba_category values dba_category_list(indx);
                end loop;
                commit; -- clushes from memory to disk
             --exit loop
             exit when cur_dba_category%notfound;
        end loop;
    
    
    --- close cursor
    close cur_dba_category;

    end_time := dbms_utility.get_time;
    dbms_output.put_line('Elapsed when dba category:' ||(end_time - start_time) / 100);
END;



------------------------------------------------------------------------
------5. load address 

procedure p_fe_load_address as
    cursor cur_address is     
        select SEQ_FE_JG_MEDI_ADDRESS.nextval, ADDRESS,ADDRESS2, CITY,STATE_CODE,ZIP,dba_fk
            from (
        select address, ADDRESS2, CITY,state_code,ZIP,dba_pk dba_fk
        from 
        (select distinct dba_name, address, ADDRESS2, CITY,STATE state_code,ZIP from MASY_IB48.MEDI_SUPPLIER_STAGE) data,
        FE_JG_MEDI_DBA dba
        where dba.name=data.dba_name
        minus
  select ADDRESS, ADDRESS2, CITY, STATE_CODE, ZIP, DBA_FK from FE_JG_MEDI_address);

    --define my type        
    type tt_address is table of FE_JG_MEDI_address%rowtype index by PLS_INTEGER;
    --use this variable 
    address_list  tt_address;
    
--TIMER
    start_time number;
    end_time number;
Begin
    ---get the start time
    start_time :=dbms_utility.get_time;
    --open my cursor
    open cur_address;
        loop 
            --- loop through cursor limit at a time
            fetch cur_address bulk collect into address_list limit 1000;
            ---loop through what I just fetch
            for indx in 1..address_list.count loop
                insert into FE_JG_MEDI_address
                values address_list(indx);
            end loop;
            --exit loop
            exit when cur_address%notfound;
        END LOOP;   

    
    
    --- close cursor
    close cur_address;

    end_time := dbms_utility.get_time;
    dbms_output.put_line('Elapsed when load address:' ||(end_time - start_time) / 100);
END;


-- 6. load phone 

procedure p_fe_load_phone as

     cursor cur_phone is    
  select Seq_FE_JG_MEDI_PHONE.nextval phone_PK, phone_number, address_fk
            from (
            select trim(upper(phone)) phone_number, address_pk address_fk 
    from (select distinct address, phone from MASY_IB48.MEDI_SUPPLIER_STAGE) data, 
    FE_JG_MEDI_ADDRESS address
    where data.address=address.address
    minus
    select PHONE_NUMBER, ADDRESS_FK from FE_JG_MEDI_phone);
 
    --define my type        
    type tt_phone is table of FE_JG_MEDI_phone%rowtype index by PLS_INTEGER;
    --use this variable 
    phone_list  tt_phone;
    
--TIMER
    start_time number;
    end_time number;
Begin
    ---get the start time
    start_time :=dbms_utility.get_time;
    --open my cursor
    open cur_phone;
        loop 
            --- loop through cursor limit at a time
            fetch cur_phone bulk collect into phone_list limit 1000;
            ---loop through what I just fetch
            for indx in 1..phone_list.count loop
                insert into FE_JG_MEDI_phone
                values phone_list(indx);
            end loop;
            --exit loop
            exit when cur_phone%notfound;
        END LOOP;   
    
    
    --- close cursor
    close cur_phone;

    end_time := dbms_utility.get_time;
    dbms_output.put_line('Elapsed when load phone:' ||(end_time - start_time) / 100);
END;


------------process all ---------
procedure p_process_all as 

begin 

   p_fe_load_company;
   p_fe_load_category;
   p_fe_load_dba;
   p_fe_load_dba_category;
   p_fe_load_address;
   p_fe_load_phone;
end;

end;

--call the procedure
begin
pkg_fe_jg_medi.p_process_all;
end;


--create a view to join tables
CREATE VIEW view_FE_JG_MEDI AS
select FE_JG_MEDI_COMPANY.name company_name,FE_JG_MEDI_DBA.name dba_name, address,address2,
city,state_code,zip,phone_number,
fe_jg_medi_category.name product_category
FROM 
FE_JG_MEDI_COMPANY JOIN FE_JG_MEDI_DBA
on fe_jg_medi_company.company_pk=fe_jg_medi_dba.company_fk
JOIN fe_jg_medi_address
on fe_jg_medi_address.dba_fk=fe_jg_medi_dba.dba_pk
join fe_jg_medi_phone
on fe_jg_medi_phone.address_fk=fe_jg_medi_address.address_pk
join fe_jg_medi_dba_category
on fe_jg_medi_dba_category.dba_fk=fe_jg_medi_dba.dba_pk
join fe_jg_medi_category
on fe_jg_medi_category.category_pk=fe_jg_medi_dba_category.category_fk


---create a trigger to insert
create or replace trigger io_insert_VIEW_FE_JG_MEDI 
instead of insert
on VIEW_FE_JG_MEDI 
referencing new as new old as old
declare
l_company_id number;
l_dba_id number;
l_ADDRESS_id number;
l_category_id number;
v_count_nr number;

Begin  
    -- insert into FE_JG_MEDI_company
    select count(*) 
    into v_count_nr
    from fe_jg_medi_company
    where trim(upper(name)) = trim(upper(:new.company_name));
    --if company name does not exist, insert 
    if v_count_nr = 0 then
    insert into FE_JG_MEDI_company(name)
    values(:new.company_name)
    RETURNING company_pk INTO l_company_id;
    --if the company name exists,skip
    else 
        DBMS_OUTPUT.PUT_LINE('company EXIST, CANNOT INSERT DUPLICATE RECORDS');
    end if;
  
    -- insert into FE_JG_MEDI_DBA
    select count(*) 
    into v_count_nr
    from FE_JG_MEDI_DBA
    where trim(upper(name)) = trim(upper(:new.dba_name));
    --if DBA name does not exist, insert 
    if v_count_nr = 0 then
         insert into FE_JG_MEDI_DBA(name, company_fk)
        values(:new.dba_name,l_company_id)
        RETURNING DBA_pk INTO l_dba_id;
     --if the DBA name exists,skip 
    else 
        DBMS_OUTPUT.PUT_LINE('dba_name EXIST, CANNOT INSERT DUPLICATE RECORDS');
    end if;
   
    -- insert into FE_JG_MEDI_Address
   select count(*) 
        into v_count_nr from FE_JG_MEDI_ADDRESS
        where address = :new.address
        and address2 = :new.address2
        and city = :new.city
        and state_code = :new.state_code
        and zip = :new.zip;      
    if v_count_nr = 0 then    
     insert into FE_JG_MEDI_address(ADDRESS, ADDRESS2, CITY, STATE_CODE, ZIP, DBA_FK)
     values(:new.ADDRESS, :new.ADDRESS2, :new.CITY, :new.STATE_CODE, :new.ZIP, l_dba_id)
     RETURNING ADDRESS_pk INTO l_ADDRESS_id;
     --if the address exists,skip 
    else 
        DBMS_OUTPUT.PUT_LINE('address EXIST, CANNOT INSERT DUPLICATE RECORDS');
    end if;
    
    -- insert into FE_JG_MEDI_PHONE
     select count(*) 
    into v_count_nr
    from FE_JG_MEDI_PHONE
    where trim(upper(phone_number)) = trim(upper(:new.PHONE_NUMBER));
    --if phone number does not exist, insert 
    if v_count_nr = 0 then
         insert into FE_JG_MEDI_phone(PHONE_NUMBER, ADDRESS_FK)
         values(:new.PHONE_NUMBER,l_ADDRESS_id);
     --if the phone number exists,skip 
    else 
        DBMS_OUTPUT.PUT_LINE('phone EXIST, CANNOT INSERT DUPLICATE RECORDS');
    end if;
    -- insert into FE_JG_MEDI_category
    Select count(*) 
    into v_count_nr
    from FE_JG_MEDI_CATEGORY
    where trim(upper(NAME)) = trim(upper(:new.PRODUCT_CATEGORY));
    if v_count_nr = 0 then
    --if CATEGORY does not exist, insert 
    insert into FE_JG_MEDI_category(NAME)
     values(:new.product_category)
     RETURNING category_pk INTO l_category_id;
    --if the CATEGORY exists,skip 
    else 
        DBMS_OUTPUT.PUT_LINE('category EXIST, CANNOT INSERT DUPLICATE RECORDS');
    end if;   
   -- insert into FE_JG_MEDI_dba_category
    insert into FE_JG_MEDI_dba_category(DBA_FK,CATEGORY_FK)
     values(l_dba_id, l_category_id);
end;
     
     
    
--insert data to view
create procedure p_insert_in_view
is 
begin
    insert into VIEW_FE_JG_MEDI(COMPANY_NAME, DBA_NAME, ADDRESS,ADDRESS2, CITY, STATE_CODE, ZIP, PHONE_NUMBER, PRODUCT_CATEGORY)
    values ('KRE', 'KRE LLC','235 Grand Street','UNIT101','Jersey City','NJ','07302','201-238-1775','service');
end;

begin
p_insert_in_view;
end;

--check if data is correctly inserted 
select * from VIEW_FE_JG_MEDI 
where company_name='KRE'


----create a trigger to update
create or replace trigger tbu_VIEW_FE_JG_MEDI 
instead of update
on VIEW_FE_JG_MEDI 
referencing new as new old as old
declare
l_company_id number;
l_dba_id number;
l_ADDRESS_id number;
Begin  
    --update company
    update FE_JG_MEDI_company
    SET name = :NEW.COMPANY_name 
    where name = :OLD.COMPANY_name
    RETURNING company_pk INTO l_company_id;
    --update DBA
    update FE_JG_MEDI_dba
    SET name = :NEW.dba_name 
    where name = :OLD.dba_name
    or company_fk=l_company_id
   RETURNING DBA_pk INTO l_dba_id;
   --update address
    update FE_JG_MEDI_address
    SET address = :NEW.address
    where address = :OLD.address
    or dba_fk=l_dba_id
    RETURNING ADDRESS_pk INTO l_ADDRESS_id; 
    
    update FE_JG_MEDI_address
    SET address2 = :NEW.address2
    where address2 = :OLD.address2
    or dba_fk=l_dba_id; 
    
    update FE_JG_MEDI_address
    SET city = :NEW.city
    where city = :OLD.city
    or dba_fk=l_dba_id; 
    
    update FE_JG_MEDI_address
    SET state_code = :NEW.state_code
    where state_code = :OLD.state_code
    or dba_fk=l_dba_id;
    
    update FE_JG_MEDI_address
    SET zip = :NEW.zip
    where zip = :OLD.zip
    or dba_fk=l_dba_id;
    
     --update phone
    update FE_JG_MEDI_phone
    SET phone_number = :NEW.phone_number
    where phone_number = :OLD.phone_number
    or address_fk=l_ADDRESS_id; 
    
 --update category
    update FE_JG_MEDI_category
    SET name = :NEW.product_category
    where name = :OLD.product_category;
end;


---create a procedure to update view
create or replace procedure p_update_in_view
is 
begin
    update VIEW_FE_JG_MEDI
        set company_name='KRE Cleaning service',
        dba_name='KRE Cleaning LLC',
        address='244 grand street', 
        phone_number='1234557',
        product_category='clearning service'
        where company_name='KRE Cleaning';
end;
---call the procedure
begin
p_update_in_view;
end;

--check if the trigger works
select * from VIEW_FE_JG_MEDI 
where company_NAME='KRE Cleaning service'


---create a triger to delete
create or replace trigger tbd_VIEW_FE_JG_MEDI 
instead of delete
on VIEW_FE_JG_MEDI 
referencing new as new old as old
declare
l_company_id number;
l_dba_id number;
l_ADDRESS_id number;
l_dba_category_id number;
Begin  
    --delete dba_category
    delete from  FE_JG_MEDI_dba_category
    where dba_fk= (select dba_pk from (select * from FE_JG_MEDI_dba where name=:new.dba_name))
    or category_fk=(select category_pk from (select *from  FE_JG_MEDI_category where name=:new.product_category))
    returning dba_category_pk into l_dba_category_id;   
    --delete category
    delete from FE_JG_MEDI_category
    where name = :new.product_category
    or category_pk=l_dba_category_id;
    --delete phone
    delete from  FE_JG_MEDI_phone
    where phone_number = :new.phone_number
    returning address_fk into l_address_id;   
    --delete address
    delete from FE_JG_MEDI_address
    where address = :new.address
    or address2 = :new.address2
    or city = :new.city
    or state_code = :new.state_code
    or zip = :new.zip
    or ADDRESS_pk=l_ADDRESS_id
    RETURNING DBA_fk INTO l_dba_id;   
  --delete DBA
    delete from FE_JG_MEDI_dba
    where name = :new.dba_name 
    or dba_pk=l_dba_id
   RETURNING company_fk INTO l_company_id; 
    --delete company
    delete from FE_JG_MEDI_company
    where name = :new.COMPANY_name
   or company_pk=l_company_id;

end;


create or replace procedure p_delete_in_view
is 
begin
    delete from VIEW_FE_JG_MEDI
        where company_name='KRE Cleaning service';
end;
---call the procedure
begin
p_delete_in_view;
end;
---check the delete result 
select * from VIEW_FE_JG_MEDI 
where company_NAME='KRE Cleaning service'



----COMBINE three trigger  into one

CREATE or replace TRIGGER TBIDU_VIEW_FE_JG_MEDI 
INSTEAD OF INSERT OR UPDATE OR DELETE
ON VIEW_FE_JG_MEDI 
FOR EACH ROW

DECLARE
l_company_id number;
l_dba_id number;
l_ADDRESS_id number;
l_category_id number;
v_count_nr number;
l_dba_category_id number;

BEGIN
    IF inserting THEN
    -- insert into FE_JG_MEDI_company
    select count(*) 
    into v_count_nr
    from fe_jg_medi_company
    where trim(upper(name)) = trim(upper(:new.company_name));
    --if company name does not exist, insert 
    if v_count_nr = 0 then
    insert into FE_JG_MEDI_company(name)
    values(:new.company_name)
    RETURNING company_pk INTO l_company_id;
    --if the company name exists,skip
    else 
        DBMS_OUTPUT.PUT_LINE('company EXIST, CANNOT INSERT DUPLICATE RECORDS');
    end if;
  
    -- insert into FE_JG_MEDI_DBA
    select count(*) 
    into v_count_nr
    from FE_JG_MEDI_DBA
    where trim(upper(name)) = trim(upper(:new.dba_name));
    --if DBA name does not exist, insert 
    if v_count_nr = 0 then
         insert into FE_JG_MEDI_DBA(name, company_fk)
        values(:new.dba_name,l_company_id)
        RETURNING DBA_pk INTO l_dba_id;
     --if the DBA name exists,skip 
    else 
        DBMS_OUTPUT.PUT_LINE('dba_name EXIST, CANNOT INSERT DUPLICATE RECORDS');
    end if;
   
    -- insert into FE_JG_MEDI_Address
   select count(*) 
        into v_count_nr from FE_JG_MEDI_ADDRESS
        where address = :new.address
        and address2 = :new.address2
        and city = :new.city
        and state_code = :new.state_code
        and zip = :new.zip;      
    if v_count_nr = 0 then    
     insert into FE_JG_MEDI_address(ADDRESS, ADDRESS2, CITY, STATE_CODE, ZIP, DBA_FK)
     values(:new.ADDRESS, :new.ADDRESS2, :new.CITY, :new.STATE_CODE, :new.ZIP, l_dba_id)
     RETURNING ADDRESS_pk INTO l_ADDRESS_id;
     --if the address exists,skip 
    else 
        DBMS_OUTPUT.PUT_LINE('address EXIST, CANNOT INSERT DUPLICATE RECORDS');
    end if;
    
    -- insert into FE_JG_MEDI_PHONE
     select count(*) 
    into v_count_nr
    from FE_JG_MEDI_PHONE
    where trim(upper(phone_number)) = trim(upper(:new.PHONE_NUMBER));
    --if phone number does not exist, insert 
    if v_count_nr = 0 then
         insert into FE_JG_MEDI_phone(PHONE_NUMBER, ADDRESS_FK)
         values(:new.PHONE_NUMBER,l_ADDRESS_id);
     --if the phone number exists,skip 
    else 
        DBMS_OUTPUT.PUT_LINE('phone EXIST, CANNOT INSERT DUPLICATE RECORDS');
    end if;
    -- insert into FE_JG_MEDI_category
    Select count(*) 
    into v_count_nr
    from FE_JG_MEDI_CATEGORY
    where trim(upper(NAME)) = trim(upper(:new.PRODUCT_CATEGORY));
    if v_count_nr = 0 then
    --if CATEGORY does not exist, insert 
    insert into FE_JG_MEDI_category(NAME)
     values(:new.product_category)
     RETURNING category_pk INTO l_category_id;
    --if the CATEGORY exists,skip 
    else 
        DBMS_OUTPUT.PUT_LINE('category EXIST, CANNOT INSERT DUPLICATE RECORDS');
    end if;   
   -- insert into FE_JG_MEDI_dba_category
    insert into FE_JG_MEDI_dba_category(DBA_FK,CATEGORY_FK)
     values(l_dba_id, l_category_id);
     
    ELSIF updating THEN
    --update company
    update FE_JG_MEDI_company
    SET name = :NEW.COMPANY_name 
    where name = :OLD.COMPANY_name
    RETURNING company_pk INTO l_company_id;
    --update DBA
    update FE_JG_MEDI_dba
    SET name = :NEW.dba_name 
    where name = :OLD.dba_name
    or company_fk=l_company_id
   RETURNING DBA_pk INTO l_dba_id;
   --update address
    update FE_JG_MEDI_address
    SET address = :NEW.address
    where address = :OLD.address
    or dba_fk=l_dba_id
    RETURNING ADDRESS_pk INTO l_ADDRESS_id; 
    
    update FE_JG_MEDI_address
    SET address2 = :NEW.address2
    where address2 = :OLD.address2
    or dba_fk=l_dba_id; 
    
    update FE_JG_MEDI_address
    SET city = :NEW.city
    where city = :OLD.city
    or dba_fk=l_dba_id; 
    
    update FE_JG_MEDI_address
    SET state_code = :NEW.state_code
    where state_code = :OLD.state_code
    or dba_fk=l_dba_id;
    
    update FE_JG_MEDI_address
    SET zip = :NEW.zip
    where zip = :OLD.zip
    or dba_fk=l_dba_id;
    
     --update phone
    update FE_JG_MEDI_phone
    SET phone_number = :NEW.phone_number
    where phone_number = :OLD.phone_number
    or address_fk=l_ADDRESS_id; 
    
 --update category
    update FE_JG_MEDI_category
    SET name = :NEW.product_category
    where name = :OLD.product_category;

    ELSIF deleting THEN
--delete dba_category
    delete from  FE_JG_MEDI_dba_category
    where dba_fk= (select dba_pk from (select * from FE_JG_MEDI_dba where name=:new.dba_name))
    or category_fk=(select category_pk from (select *from  FE_JG_MEDI_category where name=:new.product_category))
    returning dba_category_pk into l_dba_category_id;   
    --delete category
    delete from FE_JG_MEDI_category
    where name = :new.product_category
    or category_pk=l_dba_category_id;
    --delete phone
    delete from  FE_JG_MEDI_phone
    where phone_number = :new.phone_number
    returning address_fk into l_address_id;   
    --delete address
    delete from FE_JG_MEDI_address
    where address = :new.address
    or address2 = :new.address2
    or city = :new.city
    or state_code = :new.state_code
    or zip = :new.zip
    or ADDRESS_pk=l_ADDRESS_id
    RETURNING DBA_fk INTO l_dba_id;   
  --delete DBA
    delete from FE_JG_MEDI_dba
    where name = :new.dba_name 
    or dba_pk=l_dba_id
   RETURNING company_fk INTO l_company_id; 
    --delete company
    delete from FE_JG_MEDI_company
    where name = :new.COMPANY_name
   or company_pk=l_company_id;
    end if;

    
END;


        











