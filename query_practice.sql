CREATE DATABASE ORG;
SHOW DATABASES;
USE ORG;

CREATE TABLE worker(
	WORKER_ID INT NOT NULL PRIMARY KEY auto_increment,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    SALARY INT(15),
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(25)
);
drop table worker;

show tables;
INSERT INTO worker
(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
	(001, 'Monika', 'Arora', 100000, '14-02-20 09:00:00', 'HR'),
	(002, 'Niharika', 'Verma', 80000, '14-06-11 09:00:00', 'Admin'),
	(003, 'Vishal', 'Singhal', 300000, '14-07-20 09:00:00', 'HR'),
	(004, 'Amitabh', 'Singh', 500000, '14-02-20 09:00:00', 'Admin'),
	(005, 'Vivek', 'Bhati', 500000, '14-06-11 09:00:00', 'Admin'),
	(006, 'Vipul', 'Diwakar', 200000, '14-06-11 09:00:00', 'Account'),
	(007, 'Satish', 'Kumar', 75000, '14-01-20 09:00:00', 'Account'),
	(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09:00:00', 'Admin');
    
SELECT * FROM Title;
CREATE TABLE Bonus(
	WORKER_REF_ID INT,
    BONUS_AMOUNT INT(10),
    BONUS_DATE DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus
		(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
        (001, 5000, '16-02-20'),
        (002, 3000, '16-06-11'),
        (003, 4000, '16-02-20'),
        (001, 4500, '16-02-20'),
        (002, 3500, '16-06-11');
        
CREATE TABLE Title(
	WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(Worker_id)
		ON DELETE CASCADE
);

INSERT INTO Title
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
    (001, 'Manager', '2016-02-20 00:00:00'),
    (002, 'Executive', '2016-06-11 00:00:00'),
    (008, 'Executive', '2016-06-11 00:00:00'),
    (005, 'Manager', '2016-06-11 00:00:00'),
    (004, 'Asst. Manager', '2016-06-11 00:00:00'),
    (007, 'Executive', '2016-06-11 00:00:00'),
	(006, 'Lead', '2016-06-11 00:00:00'),
	(003, 'Lead', '2016-06-11 00:00:00');

-- 1 
select FIRST_NAME as WORKER_NAME from Worker;

-- 2 
select upper(FIRST_NAME) from Worker;
    
-- 3     
select distinct DEPARTMENT from Worker;

select DEPARTMENT from Worker group by DEPARTMENT;

-- 4
select substring(FIRST_NAME, 1, 3) from Worker;

-- 5 
select INSTR(FIRST_NAME, 'B') from Worker where FIRST_NAME like '%b_';
-- 6
select rtrim(first_name) from Worker; 
-- 7
select ltrim(first_name) from Worker; 
-- 8
select distinct department, length(department) as length from worker;  
-- 9
select replace(first_name, 'a', 'A') from worker; 
-- 10
select concat(first_name, ' ',last_name) as complete_name from worker;
-- 11
select * from Worker order by first_name ASC; 
-- 12
select * from Worker order by first_name, department desc;
-- 13
select * from Worker where first_name in ("Vipul", "Satish"); 
-- 14
select * from Worker where first_name not in ("Vipul", "Satish");  
-- 15
select * from worker where department like "Admin%"; 
-- 16
select * from worker where first_name like "%a%";
-- 17
select * from worker where first_name like "%a";
-- 18
select * from worker where first_name like "_____h" and length(first_name)=6;
-- 19
select * from worker where salary between 100000 and 500000; 
-- 20
select * from worker where year(joining_date)=2014 and month(joining_date)=02;
-- 21
select count(*) as Admins from worker where department = "Admin";
-- 22 
select concat(first_name, " ", last_name) as full_name from worker where salary between 50000 and 100000;
-- 23
select department, count(worker_id) as worker_d from worker group by department order by worker_d desc;
-- 24
select w.* from worker as w inner join title as t on w.worker_id = t.worker_ref_id and worker_title like "%Manager";  
-- 25
select worker_title, count(*) as numbers from title group by worker_title having numbers>1;  
-- 26
select * from worker where mod(worker_id, 2)<>0; 
-- 27
select * from worker where mod(worker_id, 2)=0;
-- 28
create table Worker_clone like Worker;
insert into worker_clone select * from worker;
select * from worker_clone;
-- 29
select worker.* from worker inner join worker_clone using(worker_id);
-- 30
select worker.* from worker left join worker_clone using(worker_id) where worker_id is null;
-- 31
-- DUAL
select curdate();
select now();
-- 32
select * from worker order by salary desc limit 5;
-- 33
select * from worker order by salary desc limit 4,1;
-- 34
select * from worker w1 where 5 =(
	select count(distinct(w2.salary)) from worker w2 
    where w2.salary>=w1.salary
    );
    
-- 35
select w1.* from worker w1, worker w2 where w1.salary = w2.salary and w1.worker_id!=w2.worker_id;

-- 36
select max(salary) from worker where salary not in (select max(salary) from worker);
-- 37
select * from worker 
union all 
select * from worker order by worker_id;
-- 38
select w.* from worker w where w.worker_id not in (select b.worker_ref_id from bonus b);
-- 39 
select * from worker where worker_id <= (select count(worker_id)/2 from worker);
-- 40 
select department from worker group by department having count(department)<4; 
-- 41 
select department, count(department) as people from worker group by department;
-- 42
select * from worker where worker_id = (select max(worker_id) from worker);
-- 43
select * from worker limit 1;
-- 44
(select * from worker order by worker_id desc limit 5) order by worker_id; 
-- 45
select w.first_name, w.department, w.salary from worker w inner join (select max(salary) as s, department from worker group by department) as mx on mx.s=w.salary; 
-- 46
select * from worker w1 where 3>=(select count(w2.salary) 
from worker w2 where w1.salary<=w2.salary) order by w1.salary;  

(select distinct salary, first_name from worker order by salary desc limit 3) order by salary; 

-- 47
select w1.* from worker w1 where 3<=(select count(w2.salary) from
worker w2 where w1.salary <= w2.salary) order by w1.salary limit 3; 

-- 48
select * from worker w1 where n>=(select count(w2.salary) 
from worker w2 where w1.salary<=w2.salary) order by w1.salary desc;  

-- 49
select department, sum(salary) as totalsalary from worker group by department order by totalsalary desc; 
-- 50 
select * from worker order by salary desc limit 1; 
select w1.* from worker w1 where 1 = (select count(w2.salary) from worker w2 where w1.salary<=w2.salary); 
select w1.* from worker w1 where salary = (select max(salary) from worker);

-- 51 

create database temp;
use temp;

create table pairs(
A int,
B int
);

insert into pairs values(1,2),(2,4),(2,1),(3,2),(4,2),(5,6),(6,5),(7,8);
select * from pairs;
select distinct * from pairs lt left join pairs rt on lt.A = rt.B  and lt.B = rt.A
where lt.A<rt.A and rt.A is null;


