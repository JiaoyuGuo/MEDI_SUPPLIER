# MEDI_SUPPLIER
Migrate data from MEDI_SUPPLIER_STAGE to normalized set of tables

1) Create a 3NF (Third Normal Form) database to support the stage table
2) For each table, you should have a trigger to generate a Primary Key
3) Create a process to move the data from stage to your 3NF tables
     i. Must use BULK COLLECT/INSERT
    ii. Must use a "sensible" limit ...test and see which size is most efficient
   iii. Must use timers to check how long the process takes (eg: dbms_utility.get_time() )
   iv. Process should be a procedure in a package - which you will call to run the entire process. 
4) Create a view that mimics the stage table
    i. Create an INSTEAD OF trigger that allows you to INSERT, UPDATE and DELETE from this view
   ii. Create a procedure that that does one INSERT, one UPDATE and one DELETE. You can hard code the values needed
