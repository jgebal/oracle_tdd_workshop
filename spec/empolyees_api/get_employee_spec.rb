plsql.execute <<-SQL
create or replace package employees_api as
  function get_employee( p_employee_id integer ) return employees%rowtype;
end;
SQL


plsql.execute <<-SQL
create or replace package body employees_api as
  function get_employee( p_employee_id integer ) return employees%rowtype is
    v_result employees%rowtype;
  begin
    select *
      into v_result
      from employees where employee_id = p_employee_id;
    return v_result;
  end;
end;
SQL


describe 'get employee' do

  it 'returns a single employee for a given id' do
    expected = plsql.employees.first('where employee_id = :id', 100)
    expect( plsql.employees_api.get_employee(100) ).to eq(expected)
  end

end
