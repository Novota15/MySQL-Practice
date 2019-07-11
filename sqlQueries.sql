-- Assignment 2 Queries
-- Grant Novota
-- CSCI 3308

/* 1. */
select lastname, firstname, country as "Country" from nwEmployees                                                      
where country!='USA' and hiredate <= '2014-7-8' order by lastname, firstname asc;
/* 2 */
select productid, productname, unitsinstock, unitprice from nwProducts where unitsinstock <= reorderlevel and unitsinstock > 0; 
/* 3 */
select productname, unitprice from nwProducts where unitprice = (select max(unitprice) from nwProducts);
/* 4 */
select productid, productname, unitsinstock * unitprice as "Total Inventory Value" 
from nwProducts where unitsinstock * unitprice > 2000 order by "Total Inventory Value" desc;
/* 5 */
select shipcountry, count(shipcountry) from nwOrders where shipcountry != 'USA' and shippeddate >= '2013/09/01' and 
shippeddate < '2013/10/01' group by shipcountry order by shipcountry asc;
/* 6 */
select nwOrders.customerid, companyname from nwOrders inner join nwCustomers on nwOrders.customerid = nwCustomers.customerid group by nwOrders.customerid having count(nwOrders.customerid) > 20;
/* 7 */
select sum(unitprice * unitsinstock) as "Total Inventory Value", supplierid from nwProducts group by supplierid having count(supplierid) > 3;
/* 8 */
select companyname, productname, unitprice from nwProducts, nwSuppliers where                                     
country = 'USA' and nwSuppliers.supplierid=nwProducts.supplierid order by unitprice desc;  
/* 9 */
select lastname, firstname, title, extension, count(nwOrders.employeeid) as "Number of Orders" from nwOrders, nwEmployees where nwOrders.employeeid = nwEmployees.employeeid 
group by lastname, firstname, title, extension having count(nwOrders.employeeid) > 100 order by lastname desc;
/* 10 */
select customerid, companyname from nwCustomers where customerid not in (select customerid from nwOrders); 
/* 11 */
select companyname, nwSuppliers.contactname, categoryname, description, productname, unitsonorder from nwSuppliers, nwProducts, nwCategories 
where unitsinstock = 0 and nwSuppliers.supplierid=nwProducts.supplierid and nwProducts.categoryid = nwCategories.categoryid; 
/* 12 */
select productname, companyname, country, unitsinstock from nwSuppliers, nwProducts
where (quantityperunit like '%bottle%' or quantityperunit like '%bottles%') and nwSuppliers.supplierid = nwProducts.supplierid; 
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
select productid, categoryid, productname, CURRENT_DATE, supplierid, unitsinstock, unitprice from nwProducts where (unitprice * unitsinstock) > 2500;
/* 15 */
delete from nwtopitems where supplierid in (select supplierid from nwSuppliers where country = 'Canada' and nwtopitems.supplierid = nwSuppliers.supplierid);
/* 16 */
alter table nwtopitems
add InventoryValue decimal(9, 2);
/* 17 */
update nwtopitems
set inventoryvalue=itemquantity * itemprice;
/* 18 */
drop table nwtopitems;
