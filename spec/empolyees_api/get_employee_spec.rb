require_relative 'get_employees'

describe 'get employee' do

  it 'returns a single employee record for a given id' do
    expected = plsql.employees.first('where employee_id = :id', 100)
    expect( plsql.employees_api.get_employee(100) ).to eq(expected)
  end

  it 'raises exception if record is not found' do
    expect{ plsql.employees_api.get_employee(-100) }.to raise_exception(/employee.* was not found/)
  end

  it 'raises exception if null value given' do
    expect{ plsql.employees_api.get_employee(NULL) }.to raise_exception(/Null parameter value given/)
  end
end
