-- Assignment 2 Queries
-- Grant Novota
-- CSCI 3308

/* 1. */
select lastname, firstname, country as "Country" from employees                                                      
where country!='USA' and hiredate <= '2014-7-8' order by lastname, firstname asc;
/* 2 */
select productid, productname, unitsinstock, unitprice from products where unitsinstock <= reorderlevel and unitsinstock > 0; 
/* 3 */
select productname, unitprice from products where unitprice = (select max(unitprice) from products) 
or unitprice = (select min(unitprice) from products);
/* 4 */
select productid, productname, unitsinstock * unitprice as "Total Inventory Value" 
from products where unitsinstock * unitprice > 2000 order by "Total Inventory Value" desc;
/* 5 */
select shipcountry, count(shipcountry) from orders where shipcountry != 'USA' and shippeddate >= '2013/09/01' and 
shippeddate < '2013/10/01' group by shipcountry order by shipcountry asc;
/* 6 */
select customerid, companyname from orders group by customerid, shipname having count(customerid) >= 20;
/* 7 */
select sum(unitprice * unitsinstock) as "Total Inventory Value", supplierid from products group by supplierid having count(supplierid) > 3;
/* 8 */
select companyname, productname, unitprice from products, suppliers where                                     
country = 'USA' and suppliers.supplierid=products.supplierid order by unitprice desc;  
/* 9 */
select lastname, firstname, title, extension, count(orders.employeeid) as "Number of Orders" from orders, employees where orders.employeeid = employees.employeeid 
group by lastname, firstname, title, extension having count(orders.employeeid) > 100 order by lastname desc;
/* 10 */
select customerid, companyname from customers where customerid not in (select customerid from orders); 
/* 11 */
select companyname, suppliers.contactname, categoryname, description, productname, unitsonorder from suppliers, products, categories 
where unitsinstock = 0 and suppliers.supplierid=products.supplierid and products.categoryid = categories.categoryid; 
/* 12 */
select productname, companyname, country, unitsinstock from suppliers, products
where (quantityperunit like '%bottle%' or quantityperunit like '%bottles%') and suppliers.supplierid = products.supplierid; 
/* 13 */
DROP TABLE IF EXISTS nwtopitems ;
CREATE TABLE nwtopitems
   (
   ItemID         int  unique  NOT NULL , 
   ItemCode       int          NOT NULL ,
   ItemName       varchar(40)  NOT NULL , 
   InventoryDate  date   	   NOT NULL ,
   SupplierID     int          NOT NULL , 
   ItemQuantity   int          NOT NULL , 
   ItemPrice      decimal(9,2) NOT NULL , 
   PRIMARY KEY  (ItemID)
   ) ;

/* 14 */
insert into nwtopitems (itemid, itemcode, itemname, inventorydate, supplierid, itemquantity, itemprice)
select productid, categoryid, productname, CURRENT_DATE, supplierid, unitsinstock, unitprice from products where (unitprice * unitsinstock) > 2500;
/* 15 */
delete from nwtopitems where supplierid in (select top_items.supplierid from top_items, 
suppliers where country = 'Canada' and top_items.supplierid = suppliers.supplierid);
/* 16 */
alter table nwtopitems
add InventoryValue decimal(9, 2);
/* 17 */
update nwtopitems
set inventoryvalue=itemquantity * itemprice;
/* 18 */
drop table nwtopitems;