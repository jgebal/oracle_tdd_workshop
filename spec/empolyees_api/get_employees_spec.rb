plsql.execute <<-SQL
create or replace package employees_api as
  function get_employees( p_min_salary integer ) return sys_refcursor;
end;
SQL


plsql.execute <<-SQL
create or replace package body employees_api as
  function get_employees( p_min_salary integer ) return sys_refcursor is
    v_cursor sys_refcursor;
  begin
    open v_cursor for select * from employees where salary > p_min_salary;
    return v_cursor;
  end;
end;
SQL

describe 'get employees with salary above a value' do

  it 'returns a cursor with all columns from employee table' do
    columns = NULL
    plsql.employees_api.get_employees(100) do |cursor|
      columns = cursor.fields
    end

    expected = plsql.employees.columns.keys
    expect( columns ).to eq( expected )
  end

end
