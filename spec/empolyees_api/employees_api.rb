plsql.execute 'drop type employee_tab force' rescue nil
plsql.execute 'drop type employee_obj force' rescue nil

plsql.execute <<-SQL
create type employee_obj as object (
EMPLOYEE_ID       NUMBER(6,0),
FIRST_NAME       VARCHAR2(20),
LAST_NAME        VARCHAR2(25), --CONSTRAINT "EMP_LAST_NAME_NN" NOT NULL ENABLE,
EMAIL            VARCHAR2(25), --CONSTRAINT "EMP_EMAIL_NN" NOT NULL ENABLE,
PHONE_NUMBER     VARCHAR2(20),
HIRE_DATE        DATE, --CONSTRAINT "EMP_HIRE_DATE_NN" NOT NULL ENABLE,
JOB_ID           VARCHAR2(10),-- CONSTRAINT "EMP_JOB_NN" NOT NULL ENABLE,
SALARY           NUMBER(8,2),
COMMISSION_PCT   NUMBER(2,2),
MANAGER_ID       NUMBER(6,0),
DEPARTMENT_ID    NUMBER(4,0)
)
SQL

plsql.execute 'create type employee_tab as table of employee_obj'

plsql.execute <<-SQL
create or replace package employees_api as

  function get_employee( p_employee_id integer ) return employees%rowtype;

  function get_employees( p_min_salary integer ) return sys_refcursor;

  procedure add_employee( p_employee employee_obj );

end;
SQL


plsql.execute <<-SQL
create or replace package body employees_api as

  function get_employee( p_employee_id integer ) return employees%rowtype is
    v_result employees%rowtype;
  begin
    if p_employee_id is null then
      raise_application_error(-20001, 'Null parameter value given');
    end if;
    select *
      into v_result
      from employees where employee_id = p_employee_id;
    return v_result;
  exception
    when no_data_found then
      raise_application_error(-20000, 'The employee with id = '||p_employee_id||' was not found');
  end;

  function get_employees( p_min_salary integer ) return sys_refcursor is
    v_cursor sys_refcursor;
  begin
    open v_cursor for select * from employees where salary >= p_min_salary;
    return v_cursor;
  end;

  procedure add_employee( p_employee employee_obj ) is
  begin
    insert into employees
    select * from table( employee_tab( p_employee ) );
  end;
end;
SQL

