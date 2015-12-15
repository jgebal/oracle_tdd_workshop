require_relative 'employees_api'

describe 'Add an employee using UDT' do

  it 'adds a valid employee' do
    valid_employee =
    { employee_id: -1,
      first_name: 'Jacek',
      last_name: 'Gebal',
      email: 'jacek.gebal',
      phone_number: '515.123.4567',
      hire_date: Time.local(2015,03,30),
      job_id: 'AD_PRES',
      salary: 100000.00,
      commission_pct: NULL,
      manager_id: NULL,
      department_id: 90 }
    expect{ plsql.employees_api.add_employee(valid_employee) }.not_to raise_exception

    expect( plsql.employees.first( employee_id: -1 ) ).to eq valid_employee

  end

end
