plsql.execute <<-SQL
create or replace package employees_api as

  function get_employee( p_employee_id integer ) return employees%rowtype;

  function get_employees( p_min_salary integer ) return sys_refcursor;

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

end;
SQL

