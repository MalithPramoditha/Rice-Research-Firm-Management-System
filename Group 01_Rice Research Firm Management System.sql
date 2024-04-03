-- Rice Research Firm Management System
-- EG/2020/3795	 Aafrith U.M.
-- EG/2020/3797	 Aberuwan R.M.M.P.
-- EG/2020/3798	 Abesundara W.H.S.

-- drop database Rice_Research_Firm_Management_System;
create database Rice_Research_Firm_Management_System;
use Rice_Research_Firm_Management_System;

-- Create branch table
create table branch(
	Branch_code varchar(10) not null,
    Branch_name varchar(15),
    Branch_location_Street varchar(20),
    Branch_location_City varchar(20),
    Branch_location_Province varchar(20),
    Number_of_employees int,
    primary key(Branch_code)
);
-- Insert data
INSERT INTO branch (Branch_code, Branch_name, Branch_location_Street, Branch_location_City, Branch_location_Province, Number_of_employees) VALUES 
    ('B001', 'Branch 1', 'Street 1', 'City 1', 'Province 1', 10),
    ('B002', 'Branch 2', 'Street 2', 'City 2', 'Province 2', 15),
    ('B003', 'Branch 3', 'Street 3', 'City 3', 'Province 3', 8),
    ('B004', 'Branch 4', 'Street 4', 'City 4', 'Province 4', 12),
    ('B005', 'Branch 5', 'Street 5', 'City 5', 'Province 5', 20),
    ('B006', 'Branch 6', 'Street 6', 'City 6', 'Province 6', 6);
-- Update data
update branch set Branch_location_Street = 'Street 7', Branch_location_Province = 'Province 7', Number_of_employees = 40 where branch_code = 'B006';
update branch set Branch_location_City = 'Gampaha', Number_of_employees = 50 where Branch_code = 'B005';
-- Delete data
delete from branch where branch_code = 'B006';

-- Create buyer table
create table buyer(
	Buyer_id varchar(10) not null,
    Buyer_name varchar(20) ,
    Seeds_id varchar(10) unique ,
	primary key(Buyer_id, Buyer_name)
);

-- Create seed table
create table seed(
	Seeds_id varchar(10) not null,
    Seeds_name varchar(20) not null,
    Seeds_variety varchar(20),
    Seeds_manufacturing_date date,
    Seeds_expiring_date date,
    Seeds_Manufactured_Branch_code varchar(10) not null,
    primary key(Seeds_id),
    constraint FK_key_buyer1 foreign key(Seeds_id) references buyer(Seeds_id)
);


-- Relationships seed and branch


-- Create seedbranchrel table
create table seedbranchrel(
	Seeds_id varchar(10) not null,
    Branch_code varchar(10) not null,    
    primary key(Seeds_id, Branch_code),
    constraint FK_keyb foreign key(Branch_code) references branch(Branch_code),
    constraint FK_keys foreign key(Seeds_id) references seed(Seeds_id)
);

-- Run upto this
-- Insert data
INSERT INTO buyer (Buyer_id, Buyer_name, Seeds_id) VALUES 
('B1', 'John', 'SP001'),
('B2', 'Emily', 'SP002'),
('B3', 'Michael', 'SP003'),
('B4', 'Sarah', 'SP004'),
('B5', 'David', 'SP005'),
('B6', 'Emma', 'SP006');
-- Update data
update buyer set Buyer_name = 'hasith' where Buyer_id = 'B1';
update buyer set Buyer_name = 'Malith' where Buyer_id = 'B6';
-- Delete data
delete from buyer where Buyer_name = 'B006' and Buyer_name = 'Emma';

-- Insert data
INSERT INTO seed(Seeds_id, Seeds_name, Seeds_variety, Seeds_manufacturing_date, Seeds_expiring_date, Seeds_Manufactured_Branch_code) VALUES 
    ('SP001', 'Seed1', 'Variety2', '2021-01-01', '2022-01-01', 'B001'),
    ('SP002', 'Seed2', 'Variety1', '2021-02-02', '2022-02-02', 'B002'),
    ('SP003', 'Seed3', 'Variety3', '2021-03-03', '2022-03-03', 'B002'),
    ('SP004', 'Seed4', 'Variety3', '2021-04-04', '2022-04-04', 'B003');
INSERT INTO seed(Seeds_id, Seeds_name, Seeds_variety, Seeds_manufacturing_date, Seeds_expiring_date, Seeds_Manufactured_Branch_code) VALUES 
    ('SP005', 'Seed5', 'Variety1', '2021-01-01', '2022-01-01', 'B004'),
    ('SP006', 'Seed6', 'Variety1', '2021-02-02', '2022-02-02', 'B005');
-- Update data     
update seed set Seeds_variety = 'Variety2' where Seeds_id = 'SP006';
update seed set Seeds_variety = 'Variety2', Seeds_manufacturing_date = '2020-01-01' where Seeds_id = 'SP005';
-- Delete data
delete from seed where Seeds_id = 'SP006';

-- Create payment table
create table payment(
	Payment_id varchar(10) not null,
    Buyer_id  varchar(10) not null,
    Seeds_variety varchar(20),
    Bought_amount varchar(10),
    Payment_date varchar (20),
    Payment_method varchar(10),
    primary key(Payment_id),
    constraint fk_buyer foreign key(Buyer_id) references buyer(Buyer_id)
);
-- Insert data
INSERT INTO payment (Payment_id, Buyer_id, Seeds_variety, Bought_amount, Payment_date, Payment_method) VALUES 
    ('P0001', 'B1', 'Variety 1', '100', '2022-01-01', 'Cash'),
    ('P0002', 'B2', 'Variety 2', '50', '2022-01-02', 'Credit '),
    ('P0003', 'B1', 'Variety 3', '75', '2022-01-03', 'PayPal'),
    ('P0004', 'B3', 'Variety 1', '200', '2022-01-04', 'Cash'),
    ('P0005', 'B2', 'Variety 2', '150', '2022-01-05', 'Credit'),
    ('P0006', 'B3', 'Variety 3', '100', '2022-01-06', 'PayPal');
-- Update data
update payment set Seeds_variety = 'Variety 4', Bought_amount = '200' where Payment_id = 'P0006';
update payment set Seeds_variety = 'Variety 1', Payment_method = 'Paypal' where Payment_id = 'P0005';
-- Delete data
delete from payment where Payment_id = 'P0006';

-- Create supplier table
create table supplier(
	Supplier_id varchar(10) not null,
    Supplier_name varchar(20),
    Material_id varchar(10),
    Supplying_amount_Kg int,
    Branch_code varchar(10) not null,
    primary key(Supplier_id)
);


-- Relationships supplier and branch


-- Create supplierbranchrel table
create table supplierbranchrel(
	Supplier_id varchar(10) not null,
    Branch_code varchar(10) not null,
    primary key(Supplier_id, Branch_code),
    constraint FK_key_Supp foreign key(Supplier_id) references supplier(Supplier_id),
    constraint FK_key_Branch foreign key(Branch_code) references branch(Branch_code)
);

-- Insert data
INSERT INTO supplier (Supplier_id, Supplier_name, Material_id, Supplying_amount_Kg, Branch_code) VALUES 
    ('S001', 'Supplier 1', 'M001', 100, 'B001'),
    ('S002', 'Supplier 2', 'M002', 200, 'B002'),
    ('S003', 'Supplier 3', 'M003', 150, 'B001'),
    ('S004', 'Supplier 4', 'M001', 300, 'B003'),
    ('S005', 'Supplier 5', 'M002', 250, 'B002'),
    ('S006', 'Supplier 6', 'M004', 120, 'B001');
-- Update data
update supplier set Material_id = 'M003' where Supplier_id = 'S006';
update supplier set Material_id = 'M003', Supplying_amount_Kg = 300 where Supplier_id = 'S005';
-- delete data
delete from supplier where Supplier_id = 'S006'; 
    
-- Create material table
create table Material(
	Material_id varchar(10) not null,
    Material_name varchar(20),
    Material_quantity_kg int,
    Supplier_id varchar(10) not null,
    primary key(Material_id),
    constraint Fk_material foreign key(Supplier_id) references supplier(Supplier_id)
);
-- Insert data
insert into Material (Material_id, Material_name, Material_quantity_kg, Supplier_id) values
    ('M1', 'Material1', 100, 'S001'),
    ('M2', 'Material2', 200, 'S001'),
    ('M3', 'Material3', 150, 'S002'),
    ('M4', 'Material4', 50, 'S002'),
    ('M5', 'Material5', 250, 'S003'),
    ('M6', 'Material6', 120, 'S001');
-- Update data
update material set Material_quantity_kg= 300 where Material_id = 'M6';
update material set Supplier_id = 'S002' where Material_id = 'M6';
-- Delete data
delete from material where Material_id = 'M6';

-- Create variety table
create table Variety(
	Variety_id varchar(10) not null,
    Variety_name varchar(20),
    Variety_description varchar(50),
    Price_per_kg DECIMAL(10, 2),
    Developed_branch_code varchar(10) not null,
    primary key(Variety_id),
    constraint FK_branchvariety foreign key(Developed_branch_code) references branch(Branch_code)
);
-- Insert data
-- Selling and developing varieties are two different scenarios 
INSERT INTO Variety (Variety_id, Variety_name, Variety_description, Price_per_kg, Developed_branch_code) VALUES 
	('V1001', 'Variety 1', 'Red Delicious', 120.50, 'B001'),
	('V1002', 'Variety 2', 'Cavendish', 100.00, 'B001'),
	('V1003', 'Variety 3', 'Valencia', 150.75, 'B002'),
	('V1004', 'Variety 4', 'Seedless', 300.20, 'B003'),
	('V1005', 'Variety 5', 'Sugar rice', 202.00, 'B004'),
	('V1006', 'Variety 6', 'Golden', 70.80, 'B004');
-- Update data
update Variety set Variety_description= 'Sweet Rice' where Variety_id = 'V1006';
update Variety set Price_per_kg = 200.00, Variety_name = 'Variety 7' where Variety_id = 'V1005';
-- Delete data
delete from Variety where Variety_id = 'V1006';

-- Create Research table
create table Research(
	Research_id varchar(10) not null,
    Research_name varchar(20),
    Research_working_duration_months int,
    Research_budget DECIMAL(10, 2),
    Conducted_branch_code varchar(10) not null,
    primary key(Research_id)
);


-- Relationships research and branch


-- Create researchbranchrel table
create table researchbracnchrel(
	Research_id varchar(10) not null,
    Branch_code varchar(10) not null,
    primary key(Research_id, Branch_code),
    constraint FK_branch foreign key(Branch_code) references branch(Branch_code),
    constraint FK_Researh_1 foreign key(Research_id) references Research(Research_id)
);

-- Insert data
INSERT INTO Research (Research_id, Research_name, Research_working_duration_months, Research_budget, Conducted_branch_code) VALUES 
	('RE001', 'Research 1', 12, 50000.00, 'B001'),
	('RE002', 'Research 2', 6, 300000.50, 'B002'),
	('RE003', 'Research 3', 9, 80000.75, 'B003'),
	('RE004', 'Research 4', 18, 100000.00, 'B004'),
	('RE005', 'Research 5', 24, 150000.25, 'B001'),
	('RE006', 'Research 6', 12, 7000.50, 'B002');
-- Update data
update Research set Research_working_duration_months= 15, Research_budget = 100000.00 where Research_id = 'RE006';
update Research set Research_name = 'Research New' where Research_id = 'RE005';
-- Delete data
delete from Research where Research_id = 'RE006';
       
-- Create researcher table
create table Researcher(
	Researcher_id varchar(10) not null,
    Researcher_name varchar(20),
    Researcher_Tel int, -- need to change the domain
    Researcher_address_Province varchar(20),
    Researcher_address_City varchar(20),
    Researcher_address_Street varchar(20),
    Researcher_date_of_Birth date,
    Research_id varchar(10) not null, 
    primary key(Researcher_id),
    constraint FK_Researhcerres foreign key(Research_id) references Research(Research_id) 
);
-- Insert data
INSERT INTO Researcher (Researcher_id, Researcher_name, Researcher_Tel, Researcher_address_Province, Researcher_address_City, Researcher_address_Street, Researcher_date_of_Birth, Research_id) VALUES 
	('R001', 'John Doe', 1234, 'Province A', 'City A', 'Street A', '1990-01-01', 'RE001'),
	('R002', 'Jane Smith', 9876, 'Province B', 'City B', 'Street B', '1995-02-02', 'RE002'),
	('R003', 'Michael Johnson', 5432, 'Province C', 'City C', 'Street C', '1992-03-03', 'RE001'),
	('R004', 'Emily Davis', 7894, 'Province D', 'City D', 'Street D', '1993-04-04', 'RE003'),
	('R005', 'Andrew Wilson', 9876, 'Province E', 'City E', 'Street E', '1998-05-05', 'RE002'),
	('R006', 'Olivia Thompson', 1234, 'Province F', 'City F', 'Street F', '1994-06-06', 'RE003');
-- Update data
update Researcher set Researcher_name= 'Affrith UM', Researcher_date_of_Birth = '1990-10-12' where Researcher_id = 'R006';
update Researcher set Researcher_Tel = 1263 where Researcher_id = 'R005';
-- Delete data
delete from Researcher where Researcher_id = 'R006';

-- Create researcherqualification table
create table researcherQualification(
	Researcher_id varchar(10) not null,
    Qualification varchar(50),
    primary key(Researcher_id, Qualification),
    constraint FK_Key_reseacherqualificaton foreign key(Researcher_id) references Researcher(Researcher_id)
);
-- Insert data
INSERT INTO researcherQualification (Researcher_id, Qualification) VALUES 
	('R001', 'PhD'),
	('R001', 'MSc'),
	('R002', 'PhD'),
	('R002', 'BSc'),
	('R003', 'MSc'),
	('R003', 'BSc');
-- Update data
update researcherQualification set Qualification= 'MPhill' where Researcher_id = 'R003' and Qualification = 'BSc';
update researcherQualification set Qualification= 'MPhill' where Researcher_id = 'R003' and Qualification = 'BSc';
-- Delete data
delete from researcherQualification where Researcher_id = 'R006' and Qualification = 'MSc';

-- Create researcherprojects table
create table researcherprojects(
	Researcher_id varchar(10) not null,
    Research_project varchar(50),
    primary key(Researcher_id, Research_project),
    constraint FK_Key_reseacherproject foreign key(Researcher_id) references Researcher(Researcher_id)
);
-- Insert data
insert into researcherprojects values 
	('R001', 'Project 1'),
	('R001', 'Project 2'),
	('R002', 'Project 3'),
	('R003', 'Project 1'),
	('R004', 'Project 1'),
	('R004', 'Project 3');
-- Update data
update researcherprojects set Research_project= 'Project 2' where Researcher_id = 'R003' and Research_project = 'Project 1';
update researcherprojects set Research_project= 'Project 2' where Researcher_id = 'R004' and Research_project = 'Project 3';
-- Delete data
delete from researcherprojects where Researcher_id = 'R004' and Research_project = 'Project 2';

-- Create fieldname table
create table fieldname(
	Field_name varchar(15),
    Research_id varchar(10) not null,
    constraint FK_Field foreign key(Research_id) references Research(Research_id)
);
-- Insert data
INSERT INTO fieldname (Field_name, Research_id) VALUES 
    ('Field 1', 'RE001'),
    ('Field 2', 'RE001'),
    ('Field 3', 'RE002'),
    ('Field 4', 'RE002'),
    ('Field 5', 'RE003'),
    ('Field 6', 'RE003');
-- Update data
update fieldname set Research_id = 'RE004' where Field_name = 'Field 6' and Research_id = 'RE003';
update fieldname set Research_id = 'RE002' where Field_name = 'Feild 5' and Research_id = 'RE003';
-- Delete data
delete from fieldname where Field_name = 'Field 6' and Research_id = 'RE004';

-- select * from researcherprojects;
-- Insert data
INSERT INTO researcherprojects (Researcher_id, Research_project) VALUES 
    ('R001', 'Project A'),
    ('R002', 'Project B'),
    ('R003', 'Project C'),
    ('R004', 'Project A'),
    ('R001', 'Project D'),
    ('R005', 'Project E');
-- Update data
update researcherprojects set Research_project = 'Project C' where Researcher_id = 'R005' and Research_project = 'Project E';
update researcherprojects set Research_project = 'Project B' where Researcher_id = 'R001' and Research_project = 'Project D';
-- Delete data
delete from researcherprojects where Researcher_id = 'R005' and Research_project = 'Project C';

-- Create experiment table
create table Experiment(
	Experiment_name varchar(20),
    Research_id varchar(10) not null,
    constraint FK_Experiment foreign key(Research_id) references Research(Research_id)
);
-- Insert data
INSERT INTO Experiment (Experiment_name, Research_id) VALUES 
    ('Experiment 1', 'RE001'),
    ('Experiment 2', 'RE001'),
    ('Experiment 3', 'RE002'),
    ('Experiment 4', 'RE003'),
    ('Experiment 5', 'RE003'),
    ('Experiment 6', 'RE004');
-- Update data
update Experiment set Research_id = 'RE001' where Experiment_name = 'Experiment 6' and Research_id = 'RE004';
update Experiment set Research_id = 'RE005' where Experiment_name = 'Experiment 5' and Research_id = 'RE003';
-- Delete data
delete from Experiment where Experiment_name = 'Experiment 6' and Research_id = 'R001';

-- Create worker table
create table Worker(
	Worker_id varchar(10) not null,
    Branch_code varchar(10) not null,
    Worker_name varchar(20),
    Worker_address_Street varchar(20),
    Worker_address_City varchar(20),
    Worker_address_Province varchar(20),
    Worker_date_of_Birth date,
    primary key(Worker_id),
    constraint FK_Worker_id foreign key(Branch_code) references branch(Branch_code)
);
-- Insert data
INSERT INTO Worker (Worker_id, Branch_code, Worker_name, Worker_address_Street, Worker_address_City, Worker_address_Province, Worker_date_of_Birth) VALUES 
    ('W1001', 'B001', 'John Doe', '123 Main Street', 'New York City', 'New York', '1990-01-01'),
    ('W1002', 'B002', 'Jane Smith', '456 Elm Street', 'Los Angeles', 'California', '1995-02-15'),
    ('W1003', 'B001', 'Mike Johnson', '789 Oak Street', 'Chicago', 'Illinois', '1985-06-30'),
    ('W1004', 'B003', 'Lisa Davis', '321 Pine Street', 'Houston', 'Texas', '1992-11-20'),
    ('W1005', 'B002', 'David Wilson', '654 Maple Street', 'San Francisco', 'California', '1988-09-10'),
    ('W1006', 'B003', 'Sarah Turner', '987 Walnut Street', 'Miami', 'Florida', '1993-04-05');
-- Update data
update Worker set Worker_name = 'Malith Promodya',Worker_address_City='Puthlem'  where Worker_id = 'W1006';
update Worker set Worker_name = 'Hashith Sithuruwan' where Worker_id = 'W1005';
-- Delete data
delete from Worker where Worker_id = 'W1005';


-- Writing Queries


-- Simple queries


-- 1. Select operation
select * from branch where Number_of_employees > 10;

-- 2. Project operation
select Buyer_id, Buyer_name from buyer;

-- 3. Cartesian product operation ( cross join )
select * FROM buyer CROSS JOIN seed;

-- 4. User view
create view UV1 as select * from branch as B inner join seed as S on B.Branch_code = S.Seeds_Manufactured_Branch_code;
select * from UV1;

-- 5. Renaming operation
alter table payment rename column payment_date to paid_date;
select Payment_id,Buyer_id,paid_date from payment;
alter table payment rename column paid_date to payment_date;

-- 6. Aggregation function
select branch_code, Avg(Supplying_amount_Kg) from supplier group by branch_code;

-- 7. Like keyword
select Seeds_id from seed where Seeds_manufacturing_date like '2021-__-__';


-- Complex queries 


-- 01. Union
(SELECT B.Branch_code, B.Branch_name FROM branch as B inner join seed as S on B.Branch_code = S.Seeds_Manufactured_Branch_code where S.Seeds_variety = 'Variety2') 
union 
(SELECT BR.Branch_code, BR.Branch_name FROM branch as BR natural join buyer as BYR where BYR.Buyer_name = 'Sarah') ;

-- 02. Intersect (Alternative using inner join):
SELECT R.Researcher_id, R.Researcher_name FROM Researcher as R natural join Research as RE inner join ResearcherProjects as RP on RP.Researcher_id = R.Researcher_id where RE.Research_working_duration_months > 10 and RP.Research_project = 'Project 1';

-- (SELECT R.Researcher_id, R.Researcher_name FROM Researcher as R natural join Research as RE where RE.Research_duration_months > 15)
-- Intersect
-- (SELECT R.Researcher_id, R.Researcher_name FROM Researcher as R natural join ResearcherProjects as RP where RP.Research_project = 'Project 1')

-- 03. Set difference (Alternative using left join and null check)
SELECT R.Researcher_id, R.Researcher_name FROM Researcher as R natural join Research as RE right outer join ResearcherProjects as RP on RP.Researcher_id = R.Researcher_id where RE.Research_working_duration_months > 0 and RP.Research_project = 'Project 2';
explain select R.Researcher_id, R.Researcher_name FROM Researcher as R natural join Research as RE where RE.Research_working_duration_months > 0;
select R.Researcher_id, R.Researcher_name FROM Researcher as R natural join ResearcherProjects as RP where RP.Research_project = 'Project 2';

 -- 04. Division
SELECT (SELECT COUNT(*) FROM Researcher) / (SELECT COUNT(*) FROM Research) AS result;
 
 -- 05. Natural join
CREATE view UV2 as select * from buyer natural join seed;
select * from UV2;
 
 -- 06. Inner join
  CREATE view UV3 as select * from branch as B natural join seed as S where B.Branch_code = S.Seeds_Manufactured_Branch_code;
  select * from UV3;

-- 07. left outer join
create view UV4 as select RE.Research_id, RE.Research_name from research as RE left outer join researcher as R on RE.Research_id = R.Research_id;
select * from UV4;
DROP VIEW UV4;

-- 08. Rigth outer join
create view UV5 as select RE.Research_id, RE.Research_name, RE.Research_working_duration_months, RE.Conducted_branch_code from research as RE right outer join researcher as R on RE.Research_id = R.Research_id;
select * from UV5;
DROP VIEW UV5;

-- 09. Full outer join
create view UV6 as select RE.Research_id, RE.Research_name from research as RE left outer join researcher as R on RE.Research_id = R.Research_id;
create view UV7 as select RE.Research_id, RE.Research_name from research as RE right outer join researcher as R on RE.Research_id = R.Research_id;
(select * from UV6) union (select * from UV7);

-- 10. Outer union
create view UV8 as select RE.Research_id, RE.Research_name from research as RE left outer join researcher as R on RE.Research_id = R.Research_id;
create view UV9 as select RE.Research_id, RE.Research_name from research as RE right outer join researcher as R on RE.Research_id = R.Research_id;
(select * from UV8) union all (select * from UV9);
drop view UV9;

-- 11. 12. 13. Nested queries
select R.Researcher_id from researcher as R where R.Researcher_address_Province = 'Province A' and  R.Researcher_id in (select RP.Researcher_id from ResearcherProjects as RP where RP.Research_project = 'Project 1' );
select R.Researcher_id from researcher as R where R.Researcher_address_Province = 'Province B' and  R.Researcher_id in (select RQ.Researcher_id from researcherQualification as RQ where RQ.Qualification = 'BSc' );
select S.Seeds_Manufactured_Branch_code from seed as S where S.Seeds_expiring_date like '20__-__-__' and  S.Seeds_Manufactured_Branch_code in (select B.Branch_code from branch as B where B.Number_of_employees > 10 );


-- Database Tuning --


-- 1. Without indexing
explain select R.Researcher_id from researcher as R where R.Researcher_address_Province = 'Province A' and  R.Researcher_id in (select RP.Researcher_id from ResearcherProjects as RP where RP.Research_project = 'Project 1' );

-- With secound indexing 
ALTER TABLE researcher ADD INDEX Re_index(Researcher_address_Province);
explain select R.Researcher_id from researcher as R where R.Researcher_address_Province = 'Province A' and  R.Researcher_id in (select RP.Researcher_id from ResearcherProjects as RP where RP.Research_project = 'Project 1' );


-- 2. Without indexing
explain (SELECT B.Branch_code, B.Branch_name FROM branch as B inner join seed as S on B.Branch_code = S.Seeds_Manufactured_Branch_code where S.Seeds_variety = 'Variety2') 
union 
(SELECT BR.Branch_code, BR.Branch_name FROM branch as BR natural join buyer as BYR where BYR.Buyer_name = 'Sarah') ;

-- With indexing to buyer
ALTER TABLE seed ADD INDEX Seed_index(Seeds_variety);
explain (SELECT B.Branch_code, B.Branch_name FROM branch as B inner join seed as S on B.Branch_code = S.Seeds_Manufactured_Branch_code where S.Seeds_variety = 'Variety2') 
union 
(SELECT BR.Branch_code, BR.Branch_name FROM branch as BR natural join buyer as BYR where BYR.Buyer_name = 'Sarah');


-- 03. Without indexing
explain select R.Researcher_id, R.Researcher_name FROM Researcher as R natural join Research as RE where RE.Research_working_duration_months > 0;

-- With indexing to buyer
ALTER TABLE Research ADD INDEX Research_index_duration(Research_working_duration_months);
ALTER TABLE Researcher ADD INDEX Researcher_index_name(Researcher_id);
explain select R.Researcher_id, R.Researcher_name FROM Researcher as R natural join Research as RE where RE.Research_working_duration_months > 0;


-- 04. Without indexing
select * from UV2;

-- With indexing applied from seeds table
CREATE INDEX idx_buyer_buyer_id ON buyer(Seeds_id);
CREATE INDEX idx_seed_buyer_id ON seed(Seeds_id);
DROP INDEX idx_seed_buyer_id on seed;
CREATE VIEW UV10 AS SELECT buyer.buyer_id as buyer_buyer_id, buyer.buyer_name as buyer_name FROM buyer INNER JOIN seed ON buyer.Seeds_id = seed.Seeds_id;
explain SELECT * FROM UV10;


-- 05. Without indexing
explain select R.Researcher_id from researcher as R where R.Researcher_address_Province = 'Province B' and  R.Researcher_id in (select RQ.Researcher_id from researcherQualification as RQ where RQ.Qualification = 'BSc' );

-- With indexing 
CREATE INDEX idx_researcher_province_id ON researcher(Researcher_address_Province, Researcher_id);
DROP INDEX idx_researcher_province_id on researcher;
CREATE INDEX idx_researcherQualification ON researcherQualification(Qualification, Researcher_id);
DROP INDEX idx_researcherQualification on researcherQualification;
EXPLAIN SELECT DISTINCT R.Researcher_id FROM researcher AS R INNER JOIN researcherQualification AS RQ ON R.Researcher_id = RQ.Researcher_id WHERE R.Researcher_address_Province = 'Province B' AND RQ.Qualification = 'BSc';


-- 06. Without indexing 
explain select R.Researcher_id from researcher as R where R.Researcher_address_City = 'City A' and  R.Researcher_id in (select RP.Researcher_id from ResearcherProjects as RP where RP.Research_project = 'Project 1' );

-- With indexing 
ALTER TABLE researcher ADD INDEX Re_City_index(Researcher_address_City);
explain select R.Researcher_id from researcher as R where R.Researcher_address_Province = 'Province A' and  R.Researcher_id in (select RP.Researcher_id from ResearcherProjects as RP where RP.Research_project = 'Project 1' );


-- 07. Without indexing
explain select R.Researcher_id from researcher as R where R.Researcher_address_Street = 'Street A' and  R.Researcher_id in (select RP.Researcher_id from ResearcherProjects as RP where RP.Research_project = 'Project 1' );

-- With indexing
ALTER TABLE researcher ADD INDEX Re_Street_index(Researcher_address_Street);
explain select R.Researcher_id from researcher as R where R.Researcher_address_Street = 'Street A' and  R.Researcher_id in (select RP.Researcher_id from ResearcherProjects as RP where RP.Research_project = 'Project 1' );


-- 08. Without indexing
explain select R.Researcher_id from researcher as R where R.Researcher_Tel = 1234 and  R.Researcher_id in (select RP.Researcher_id from ResearcherProjects as RP where RP.Research_project = 'Project 1' );

-- With indexing
ALTER TABLE researcher ADD INDEX Re_Tel_index(Researcher_Tel);
explain select R.Researcher_id from researcher as R where R.Researcher_Tel = 1234 and  R.Researcher_id in (select RP.Researcher_id from ResearcherProjects as RP where RP.Research_project = 'Project 1' );


-- 09. Without indexing
explain select R.Researcher_id from researcher as R where R.Researcher_date_of_Birth = '1990-01-01' and  R.Researcher_id in (select RP.Researcher_id from ResearcherProjects as RP where RP.Research_project = 'Project 1' );

-- With indexing
ALTER TABLE researcher ADD INDEX Re_dete_of_birth_index(Researcher_date_of_Birth);
explain select R.Researcher_id from researcher as R where R.Researcher_date_of_Birth = '1990-01-01' and  R.Researcher_id in (select RP.Researcher_id from ResearcherProjects as RP where RP.Research_project = 'Project 1' );


-- 10. Without indexing
explain select Research_id from Research where Research_id IN (select Research_id from Fieldname);

-- With indexing
-- Select Depe_name from dependent intersect select Dept_Head from Head;
explain SELECT DISTINCT R.Research_id FROM Research R INNER JOIN Fieldname F ON R.Research_id = F.Research_id;
