plsql.execute 'drop type employee_tab force' rescue nil
plsql.execute 'drop type employee_obj force' rescue nil

plsql.execute <<-SQL
create type employee_obj as object (
EMPLOYEE_ID       NUMBER(6,0),
FIRST_NAME       VARCHAR2(20),
LAST_NAME        VARCHAR2(25),
EMAIL            VARCHAR2(25),
PHONE_NUMBER     VARCHAR2(20),
HIRE_DATE        DATE,
JOB_ID           VARCHAR2(10),
SALARY           NUMBER(8,2),
COMMISSION_PCT   NUMBER(2,2),
MANAGER_ID       NUMBER(6,0),
DEPARTMENT_ID    NUMBER(4,0)
)
SQL

plsql.execute 'create type employee_tab as table of employee_obj'

plsql.execute <<-SQL
create or replace package employees_api as

  function get_by_id( p_employee_id integer ) return employees%rowtype;

  function get_by_salary_above( p_min_salary integer ) return sys_refcursor;

  procedure add_one( p_employee employee_obj );

end;
SQL


plsql.execute <<-SQL
create or replace package body employees_api as

  function get_by_id( p_employee_id integer ) return employees%rowtype is
    v_result employees%rowtype;
  begin
    if p_employee_id is null then
      raise VALUE_ERROR;
    end if;
    select *
      into v_result
      from employees where employee_id = p_employee_id;
    return v_result;
  end;

  function get_by_salary_above( p_min_salary integer ) return sys_refcursor is
    v_cursor sys_refcursor;
  begin
    open v_cursor for select * from employees where salary > p_min_salary;
    return v_cursor;
  end;

  procedure add_one( p_employee employee_obj ) is
  begin
    insert into employees
    select * from table( employee_tab( p_employee ) );
  end;
end;
SQL
