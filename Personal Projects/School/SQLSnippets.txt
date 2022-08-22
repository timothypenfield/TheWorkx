

SELECT count(*) FROM Customers;



SELECT count(*) FROM Products;
SELECT count(*) FROM Salesman;
SELECT count(*) FROM Orders;
SELECT count(*) FROM OrderDetails;

SELECT * FROM Orders;
SELECT * FROM OrderDetails;


select productcode,productname,productline,productDescription from products where buyprice>(select avg(buyprice) from products)


select productline,avg(MSRP) from products group by productline having avg(MSRP)>90


select prod.productcode,prod.productname,prod.productline,prod.buyprice from products AS prod where prod.buyprice < (select avg(buyprice) as LineAve from products where prod.productline=products.productline group by productline) 
select productline, avg(buyprice) from products group by productline 


select ordernumber, orderdate, orders.customernumber from orders where orders.customernumber IN (select customernumber from customers where contactlastname like '%Brown%') 
select contactlastname,count(ordernumber) from orders,customers where orders.customernumber=customers.customernumber group by contactlastname


select officecode, count(ordernumber) as TotalOrders from orders,salesman where orders.soldby=salesman.employeenumber group by officecode order by TotalOrders asc
select * from orders
select * from salesman
Select soldby,officecode,count(ordernumber) as TotalOrders from orders,salesman where orders.soldby=salesman.employeenumber group by soldby having officecode ="1" order by TotalOrders desc


select officecode, count(ordernumber) as TotalNZOrders from orders,salesman,customers where orders.soldby=salesman.employeenumber AND orders.customernumber=customers.customernumber AND country like '%New Z%'  group by officecode order by TotalNZOrders desc


Select orders.ordernumber,orderstatus, sum(quantityordered*priceeach) as OrderTotal from orders,orderdetails where orders.ordernumber=orderdetails.ordernumber group by orders.ordernumber
Select ordernumber, sum(quantityordered*priceeach) as OrderTotal from orderdetails group by ordernumber


Select sum(quantityordered*MSRP) as MaxMSRP, sum(quantityordered*priceeach) as TotalSales, sum(quantityordered*priceeach)/sum(quantityordered*MSRP) as PercentofMSRPSold, sum(quantityordered*MSRP)-sum(quantityordered*priceeach) as SalesDiscountGivenTotal from orders,orderdetails, products where orders.ordernumber=orderdetails.ordernumber and orderdetails.productcode=products.productcode
Select sum(quantityordered) as TotalUnitsSold, sum(quantityordered*priceeach) as TotalSales, count(distinct orders.ordernumber) as NumberofOrders, sum(quantityordered*priceeach)/count(distinct orders.ordernumber)  as AverageOrderSales from orders,orderdetails where orders.ordernumber=orderdetails.ordernumber



Select officecode, sum(quantityordered) as TotalUnitsSold, sum(quantityordered*priceeach) as TotalSales, count(distinct orders.ordernumber) as NumberofOrders, sum(quantityordered*priceeach)/count(distinct orders.ordernumber)  as AverageOrderSales from orders,orderdetails,salesman where orders.ordernumber=orderdetails.ordernumber and orders.soldby=salesman.employeenumber group by officecode order by TotalSales desc
Select lastname,firstname, officecode, sum(quantityordered) as TotalUnitsSold, sum(quantityordered*priceeach) as TotalSales, count(distinct orders.ordernumber) as NumberofOrders, sum(quantityordered*priceeach)/count(distinct orders.ordernumber)  as AverageOrderSales from orders,orderdetails,salesman where orders.ordernumber=orderdetails.ordernumber and orders.soldby=salesman.employeenumber group by soldby order by TotalSales desc

Select lastname,firstname, sum(quantityordered*MSRP) as MaxMSRP, sum(quantityordered*priceeach) as TotalSales, sum(quantityordered*priceeach)/sum(quantityordered*MSRP) as PercentofMSRPSold, sum(quantityordered*MSRP)-sum(quantityordered*priceeach) as SalesDiscountGivenTotal from orders,orderdetails,salesman,products where orders.ordernumber=orderdetails.ordernumber and orders.soldby=salesman.employeenumber and orderdetails.productcode=products.productcode group by soldby order by PercentofMSRPSold desc
Select lastname,firstname, sum(quantityordered*priceeach) as OrderSaleTotal, sum(quantityordered*buyprice) as COGS,sum(quantityordered*priceeach)-sum(quantityordered*buyprice) as OrderGrossMargin from orders,products,orderdetails,salesman where orders.ordernumber=orderdetails.ordernumber and orders.soldby=salesman.employeenumber and orderdetails.productcode=products.productcode group by soldby order by OrderGrossMargin desc

Select CustomerName, officecode, count(distinct orders.ordernumber) as TotalOrders, sum(quantityordered*priceeach) as TotalSales, count(distinct soldby) as TotalSalesman from orders,products,orderdetails,salesman,customers where orders.ordernumber=orderdetails.ordernumber and orders.soldby=salesman.employeenumber and orderdetails.productcode=products.productcode and customers.customernumber=orders.customernumber group by customername, officecode order by TotalOrders desc, TotalSales desc 
Select CustomerName, count(distinct orders.ordernumber) as TotalOrders, sum(quantityordered*priceeach) as TotalSales  from orders,products,orderdetails,salesman,customers where orders.ordernumber=orderdetails.ordernumber and orders.soldby=salesman.employeenumber and orderdetails.productcode=products.productcode and customers.customernumber=orders.customernumber group by customername order by totalorders desc




~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



select count(*) from doctor;
select count(*) from owner;
select count(*) from billingtransaction;
select count(*) from treatment;
select count(*) from patient;

select petname,CONCAT(FirstName, " ",LastName) as OwnerName from owner,patient where owner.ownerid=patient.ownerid
select petname,CONCAT(FirstName, " ",LastName) as OwnerName from owner,patient where owner.ownerid=patient.ownerid AND Species="dog"
select doctorName, visitdate, petName, Species, Breed from patient, billingtransaction, doctor WHERE doctor.DoctorID=billingtransaction.DoctorID AND billingtransaction.PatientID=patient.PatientID;
select doctorName, visitdate, petName, Species, Breed from patient, billingtransaction, doctor WHERE doctor.DoctorID=billingtransaction.DoctorID AND billingtransaction.PatientID=patient.PatientID and doctorName not like '%Dolittle%'
select doctorName, count(distinct ownerid) as UniqueOwners from patient, billingtransaction, doctor WHERE doctor.DoctorID=billingtransaction.DoctorID AND billingtransaction.PatientID=patient.PatientID and doctorName like '%Rai%'

select CONCAT(FirstName, " ",LastName) as OwnerName, addres from owner where IN (select ownerid,species from patient having count(patientid)>1 group by ownerid,species)


select DoctorName, count(distinct visitdate) as DaysWorked from billingtransaction,doctor where billingtransaction.doctorid=doctor.doctorid group by doctorName
Create View patientcounts (OwnerFirst, OwnerLast, NumberPets) as select FirstName, LastName, Count(PatientID) from owner,patient where owner.ownerid=patient.ownerid group by FirstName
Select * from patientcounts

select treatment.*, count(billingtransaction.treatmentid) as TreatmentCount,Cost*count(billingtransaction.treatmentid) as CurrentRevenue from treatment,billingtransaction,patient where treatment.treatmentid=billingtransaction.treatmentid AND billingtransaction.PatientID=patient.PatientID group by TreatDesc order by Cost desc   
select Species, count(billingtransaction.treatmentid) as TreatmentCount,Cost*count(billingtransaction.treatmentid) as CurrentRevenue from treatment,billingtransaction,patient where treatment.treatmentid=billingtransaction.treatmentid AND billingtransaction.PatientID=patient.PatientID group by Species order by CurrentRevenue desc   
select Species, count(billingtransaction.treatmentid) as TreatmentCount, avg(cost) as AverageTreatmentCost from treatment,billingtransaction,patient where treatment.treatmentid=billingtransaction.treatmentid AND billingtransaction.PatientID=patient.PatientID group by Species order by AverageTreatmentCost desc   



select species, sex, count(distinct billingtransaction.patientid) from billingtransaction, patient where billingtransaction.PatientID=patient.PatientID AND sex like '%M%' group by sex, species
select treatment.*, count(billingtransaction.treatmentid) as TreatmentCount from treatment,billingtransaction,patient where treatment.treatmentid=billingtransaction.treatmentid AND billingtransaction.PatientID=patient.PatientID AND species like '%cat%' group by TreatDesc order by TreatmentCount desc   
select PetName from patient where exists(select OwnerID from owner where phone='(336) 336-3355')
select CONCAT(FirstName, " ",LastName) as OwnerName, Address, Phone from owner where exists (select ownerid from patient where species IN (







select breed,count(breed) from patient where species="dog" group by breed  order by count(breed) desc
select breed,count(breed) from patient group by breed order by count(breed) desc
select breed,count(breed) from patient group by breed having count(breed)>2 order by count(breed) desc
select * from patient where breed like '%Border%'
select species,count(transactionid) from billingtransaction, patient where billingtransaction.PatientID=patient.PatientID group by species
select count(transactionid) from billingtransaction


select Species, count(billingtransaction.treatmentid) as TreatmentCount, Cost*count(billingtransaction.treatmentid) as CurrentRevenue, (Cost*count(billingtransaction.treatmentid))/count(billingtransaction.treatmentid) as AVERAGEVISIT from treatment,billingtransaction,patient where treatment.treatmentid=billingtransaction.treatmentid AND billingtransaction.PatientID=patient.PatientID group by Species order by CurrentRevenue desc   billingtransaction

