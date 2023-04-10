create database GPA;
use GPA;




CREATE TABLE Customers(
    VehicleNo  varchar(10) NOT NULL,
    C_Fname char(20),
    C_Lname char(20),
    CustomerID  Int(25),
    PhoneNo int(10),
    Email_ID varchar(25) NOT NULL UNIQUE,
    Primary Key(VehicleNo)

 );


select * from Customers;


--- To check constraints:
-- 1)
INSERT INTO Customers VALUES('ACB123',NULL,'Smith',1,469920464,'adam.smith@gmail.com');

-- As we can see that since Fist name in Customers table doesn't have 'NOT NULL' stated , we can insert null Values to the FIELDS

-- ERROR 2)
INSERT INTO Customers VALUES(NULL,'Jack','Griffin',2,469920462,'jg@gmail.com');
-- As we can see that since VehicleNo is stated to be as a "NOT NULL" field, we cannot enter a NULL value - it throws an error

-- ERROR3)
INSERT INTO Customers VALUES('ABC125','Adam','Smithy',2,469920461,'adam.smith@gmail.com');




delete from Customers;



-- Entering Data for Custromers Table:

INSERT INTO Customers VALUES('ACB123','Adam','Smith',1,469920464,'adam.smith@gmail.com');
INSERT INTO Customers VALUES('DEF124','Mark','Mathews',2,469920462,'m.mathews@gmail.com');
INSERT INTO Customers VALUES('GHI125','Rose','Geller',3,469920477,'rose.g@gmail.com');
INSERT INTO Customers VALUES('JKL126','Emma','Perry',4,469920467,'emma.perry@gmail.com');
INSERT INTO Customers VALUES('MNO127','Jack','Griffin',5,469921461,'jck.griffin@gmail.com');
INSERT INTO Customers VALUES('PQR128','Bob','Richards',6,469920499,'bob.rich@gmail.com');
INSERT INTO Customers VALUES('STU129','Andrew','Smith',7,469921000,'Andrew.smith@gmail.com');
INSERT INTO Customers VALUES('VWX130','Rob','Jerry',8,469920002,'rob.jerry@gmail.com');

select * from customers;





CREATE TABLE Ticket(
    TicketNo  varchar(20) NOT NULL,
    VehicleNo  varchar(10),
    Lot_ID Int(20),
    Price_ID int(20),
    Ticket_Date date,
    PRIMARY KEY (TicketNo),
    FOREIGN KEY (VehicleNo) REFERENCES Customers(VehicleNo)

 );

INSERT INTO Ticket VALUES('T01','ACB123',1,100,'2021-02-21');
INSERT INTO Ticket VALUES('T02','DEF124',2,500,'2021-02-21');
INSERT INTO Ticket VALUES('T03','GHI125',1,101,'2021-02-21');
INSERT INTO Ticket VALUES('T04','JKL126',2,501,'2021-02-21');
INSERT INTO Ticket VALUES('T05','MNO127',3,300,'2021-02-22');
INSERT INTO Ticket VALUES('T06','PQR128',2,400,'2021-02-23');
INSERT INTO Ticket VALUES('T07','STU129',3,401,'2021-02-23');
INSERT INTO Ticket VALUES('T08','VWX130',2,402,'2021-02-23');

 select * from Ticket;


 -- Inner Join:
 -- select only those customers who have bought tickets and display their order details
 -- by their order date in a descending order

 select * from Customers
 inner join Ticket
 on Customers.VehicleNo = Ticket.VehicleNo
 order by Ticket_Date desc;




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Display the TicketNo, VehileNo, Lot_ID, Ticket_Date from Ticket table and Customer name and email
-- from Customers table who have parked at lot 2:

-- left join

select Ticket.TicketNo, Ticket.VehicleNo, Ticket.Lot_ID, Ticket.Ticket_Date, Customers.C_Fname, 
Customers.C_Lname, Customers.Email_ID
from Ticket left join Customers
on Ticket.VehicleNo = Customers.VehicleNo
where Ticket.Lot_ID = 2;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- right join

-- Display the Frsit name, Last Name and Customer email from Customers table and thier
 --respective Ticket details such as  TicketNo, Vehicle NO and Date of issue and also display it in decending order
 --of Date


select Customers.C_Fname, Customers.C_Lname, Customers.Email_ID, Ticket.TicketNo, Ticket.VehicleNo,  Ticket.Ticket_Date
from Customers right join Ticket
on Customers.VehicleNo = Ticket.VehicleNo
order by Ticket.Ticket_Date desc;

select * from Ticket;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Full Outer join
-- Write a select statement which returns customer name, Email, Ticket_No, Vehicle_No, Lot_ID, Ticket_Date  where customers
-- who have received tickets and Customers who haven't received a ticket:

-- Note - for better understanding we have added a Ticket in the Ticket table which has NULL value for for a ticket which is yet TEMPORARY
-- be alloted for a customer


INSERT INTO Ticket VALUES('T09',NULL,NULL,NULL,NULL);
select Customers.C_Fname, Customers.C_Lname, Customers.Email_ID, Ticket.TicketNo,Ticket.Ticket_Date, Ticket.Lot_ID,
Ticket.VehicleNo
from Ticket left join Customers
on Ticket.VehicleNo = Customers.VehicleNo
Union 
select  Customers.C_Fname, Customers.C_Lname, Customers.Email_ID, Ticket.TicketNo,Ticket.Ticket_Date, Ticket.Lot_ID,
Ticket.VehicleNo
from Customers right join Ticket
on Customers.VehicleNo = Ticket.VehicleNo;


-- Removind the NULL valued Order as this is not compatible with Our lofic of the ERD. We had just added to show the importance of Outer Join
-- Full outer join
delete from Ticket where TicketNo = 'T09';
select * from Ticket;




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- intersect statement
-- Select all the Customers who have been issued ticket between 21 Feb and 22 Feb of year 2021
-- Note as MySql does not support INTERSECT keyword IN operator is used:

SELECT *
FROM Customers
WHERE Customers.VehicleNo  IN
   (SELECT Ticket.VehicleNo
    FROM Ticket
    where Ticket.Ticket_Date between '2021-02-21' and '2021-02-22'
    );


-- For reference

SELECT *
    FROM Ticket
    where Ticket.Ticket_Date between '2021-02-20' and '2021-02-22';



-- Union  - Union does not display duplicates while Union all does display duplicates

-- select all the distinct customers with who have parked their vehicle at Lot_ID = 2 and who don't have Last Name as Smith:
select Customers.VehicleNo from Customers
where Customers.C_Lname not like 'Smith'
UNION
select Ticket.VehicleNo from Ticket
where Ticket.Lot_ID = 2;


-- For Reference
select * from Customers
where Customers.C_Lname not like 'Smith';


-- For Reference
select * from Ticket
where Ticket.Lot_ID = 2;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--- Except statement
-- Select all the Customers who have not Parked at Lod_ID 3:

select Customers.VehicleNo from Customers
where Customers.VehicleNo
not in(
select Ticket.VehicleNo from Ticket
where Ticket.Lot_ID = 3);


-- For reference
select Ticket.VehicleNo from Ticket
where Ticket.Lot_ID = 3;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------- END ----------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------