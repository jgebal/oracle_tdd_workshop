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
end;
SQL


describe 'get employee' do

  it 'returns a single employee for a given id' do
    expected = plsql.employees.first('where employee_id = :id', 100)
    expect( plsql.employees_api.get_employee(100) ).to eq(expected)
  end

  it 'returns raised if record is not found' do
    expect{ plsql.employees_api.get_employee(-100) }.to raise_exception(/employee.* was not found/)
  end

  it 'returns raises if null value given' do
    expect{ plsql.employees_api.get_employee(NULL) }.to raise_exception(/Null parameter value given/)
  end
end
