create table sales(salesman_id number, 
                   sales_year number,
                   sales_amt number);

insert into sales values(54, 2016, 44000);
insert into sales values(54, 2017, 47000);
insert into sales values(55, 2015, 34000);
insert into sales values(55, 2016, 38900);
insert into sales values(55, 2017, 41950);
insert into sales values(56, 2016, 45000);
insert into sales values(56, 2017, 47000);
insert into sales values(57, 2015, 35000);
insert into sales values(57, 2016, 50000);
insert into sales values(57, 2017, 53000);
insert into sales values(59, 2015, 35300);
insert into sales values(59, 2016, 56000);
insert into sales values(59, 2017, 49000);
--select statements--
--1
select ename from emp where ename like
'%S';
--2
select * from emp where deptno=10;
--3
select * from emp where deptno<>20;
--4
select ename,sal from emp where sal between 1000 and 2000;
--5
select job from emp where comm is null;
--6
select ename from emp where mgr=(select empno from emp 
where ename='BLAKE');
--7
select hiredate from emp where ename='TURNER';
--8
select ename,empno from emp where empno in(7698,7566,7902);
--9
select ename,deptno from emp where deptno=10 or deptno=20;
--10
select ename,hiredate from emp where hiredate>(select hiredate from emp where
ename='JONES');
--11
select * from emp order by sal;
--12
select * from emp order by hiredate;


--Alter--
--13
alter table emp add gross_salary number;

update  emp set gross_salary=sal+nvl(comm,0);

--Update--
--14
update emp set ename=lower(ename) where job='MANAGER';
--15
update emp set sal=sal+(0.05*sal) where ename='SCOTT';
--16 
update emp set deptno=20 where deptno=10 and ename like 'L%';
--17
update emp set job='MANAGER' where ename='BOB';

--Built in functions--
--18
select ename from emp where INSTR(ename,'A')>0;
--19 
select deptno||'_'||empno from emp;
--20
select substr(ename,-3) from emp where deptno=20;
--21
select ename,mgr,case when mgr is not null then 'has a manager'
else 'do not have a manager' end as mgr_availability from emp;

select ename,mgr,decode(mgr,NULL,'do not have a manager','has a manager') as
manager_avail from emp;
--22
select ename,sal,case when sal<1000 then 'poor sal'
when sal<2000 then 'just okay'
when sal<3000 then 'Good sal'
else 'Big Shots' end as sal_comment from emp;
--23
select next_day(to_date('31-12-2022','DD-MM-YYYY'),'SUNDAY') from dual;
--24
select to_char(to_date('31-03-2023','DD-MM-YYYY'),'DAY') from dual;
--25
select ename||' '|| 'Joined on ' ||to_char(hiredate,'DD')||' '||
'day of '||to_char(hiredate,'FMMonth')||' '||'in/,'||
to_char(hiredate,'Year') as join_detail from emp;

--Aggregations--
--26
select deptno,sum(sal) from emp group by deptno;
--27
select job,avg(sal) from emp group by job;
--28
select count(empno) from emp where sal>1500;
--29
select deptno,min(sal),max(sal) from emp group by deptno having
avg(sal)>2000;
--30
select * from emp where deptno in(select deptno from emp group by deptno 
having avg(sal)>1500);
--31
select ename,deptno,(select min(sal) from emp where deptno=30),
(select max(sal) from emp where deptno=30) from emp where deptno=30;
--32
select deptno,avg(sal) from emp group by deptno having avg(sal)>
(select avg(sal) from emp);

--Fruit Import datasets--
--33
select state from fruit_imports where supply=(select max(supply) from
fruit_imports);
--34
select season,max(cost_per_unit) from fruit_imports group by season;
--35
select state from(select state,name from fruit_imports group by
state,name having count(*)>1);
--36
select season,count(name) from fruit_imports group by season
having count( distinct name)=3 or count(distinct name)=4; 

--37
select state from(select state,sum(supply*cost_per_unit) as total_cost 
from
fruit_imports group by state order by total_cost desc) where rownum<=1;


--Joins--
--38
select e.* from emp e join dept d on e.deptno=d.deptno 
where dname='ACCOUNTING';
--39
select e.* from emp e join dept d on e.deptno=d.deptno
where d.loc in ('NEW YORK','CHICAGO');
--40
select count(e.empno) from emp e join dept d on e.deptno=d.deptno
where loc='BOSTON';
--41
select e.* from emp e join dept d on e.deptno=d.deptno 
where e.deptno=(select e.deptno from emp e where e.ename='KING');

--Sub queries--
--42
select e.* from emp e join dept d on e.deptno=d.deptno 
where e.deptno=(select e.deptno from emp e where e.ename='KING');
--43
select ename from emp where 
mgr=(select mgr from emp where ename='blake');
--44
select ename from emp where hiredate>(select hiredate from emp
where ename='SMITH');
--45
select ename,sal from emp  where sal<
(select avg(sal) from emp e where deptno=e.deptno);
--46
select ename,sal from emp where sal>
(select sal from emp where ename='jones');
--47
select count(empno) from emp where deptno in(select deptno from emp
where ename in('blake','clark'));
--48
select count(empno) from emp where deptno=(select deptno from emp
where ename='KING');
--49
select ename,sal from emp where sal>(select max(sal) from emp where
ename='clark' or ename='WARD');
--50
select count(empno) from emp where sal>any(select sal from emp
where ename in('ALLEN','WARD'));







select * from emp;
select * from dept;
select * from sales;
select * from fruit_imports;