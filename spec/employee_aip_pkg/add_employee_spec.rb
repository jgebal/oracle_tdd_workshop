# require 'employee_aip_pkg'

describe 'Add employee' do
  # include EmployeeFactory

  it 'saves employee into employee table' do

    new_employee = {
      :employee_id => plsql.employees_seq.nextval,
      :first_name => 'First',
      :last_name => 'Last',
      :email => 'first.last@example.com',
      :phone_number => nil,
      :hire_date => Time.today,
      :job_id => plsql.jobs.first[:job_id],
      :commission_pct => nil,
      :salary => nil,
      :manager_id => nil,
      :department_id =>nil
    }

    plsql.employee_aip_pkg.add_employee( new_employee )

    expect( plsql.employees.first( employee_id: new_employee[:employee_id] ) ).to eq new_employee
  end


  it 'runs faster than 5ms' do
    new_employee = {
      :employee_id => plsql.employees_seq.nextval,
      :first_name => 'First',
      :last_name => 'Last',
      :email => 'first.last@example.com',
      :phone_number => nil,
      :hire_date => Time.today,
      :job_id => plsql.jobs.first[:job_id],
      :commission_pct => nil,
      :salary => nil,
      :manager_id => nil,
      :department_id =>nil
    }

    expect(
      duration{
        plsql.employee_aip_pkg.add_employee( new_employee )
      }
    ).to be < 0.005

  end

  # it 'fails when employee mail is not unique' do
  #
  #   new_employee = {
  #     :employee_id => plsql.employees_seq.nextval,
  #     :first_name => 'First',
  #     :last_name => 'Last',
  #     :email => 'first.last@example.com',
  #     :phone_number => nil,
  #     :hire_date => Time.today,
  #     :job_id => plsql.jobs.first[:job_id],
  #     :commission_pct => nil,
  #     :salary => nil,
  #     :manager_id => nil,
  #     :department_id =>nil
  #   }
  #   plsql.employee_aip_pkg.add_employee( new_employee )
  #
  #   expect{ plsql.employee_aip_pkg.add_employee( new_employee ) }.to raise_exception /EMAIL/
  #
  # end

end
