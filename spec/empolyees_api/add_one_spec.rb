require_relative 'employees_api'

describe 'Add an employee to the Employees table' do

  it 'adds a valid employee' do
    valid_employee =
      { employee_id: 1, first_name: "Jacek", last_name: "Gebal", email: "JGEBAL", phone_number: "515.123.4567", hire_date: Time.local(2003, 06, 17),
        job_id:      "AD_PRES", salary: 24000, commission_pct: NULL, manager_id: NULL, department_id: 90
      }

    expect {
      plsql.employees_api.add_one( valid_employee )
    }.not_to raise_exception

    expect(
      plsql.employees.first(employee_id: valid_employee[:employee_id])
    ).to eq valid_employee

  end

  it 'does not add employee with null id and raises exception' do
    invalid_employee =
      { employee_id: NULL, first_name: "Jacek", last_name: "Gebal", email: NULL, phone_number: "515.123.4567", hire_date: Time.local(2003, 06, 17),
        job_id:      "AD_PRES", salary: 24000, commission_pct: NULL, manager_id: NULL, department_id: 90
      }
    expect{
      expect{
        plsql.employees_api.add_one( invalid_employee )
      }.to raise_exception /cannot insert NULL/
    }.not_to change(plsql.employees, :all)
  end

end
