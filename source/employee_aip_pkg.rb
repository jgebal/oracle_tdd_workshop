plsql.execute <<-SQL
create or replace package employee_aip_pkg as
  procedure add_employee( p_employee employees%rowtype );
  function get_employees return sys_refcursor;
end;
SQL


plsql.execute <<-SQL
create or replace package body employee_aip_pkg as
  procedure add_employee( p_employee employees%rowtype ) is
  begin
    insert into employees values p_employee;
  end;
  function get_employees return sys_refcursor is
    crsr sys_refcursor;
  begin
    open crsr for select employee_id from employees;
    return crsr;
  end;
end;
SQL
