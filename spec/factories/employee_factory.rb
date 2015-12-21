module EmployeeFactory
  # Creates new employee with valid field values.
  # Pass in parameters only field values that you want to override.
  def get_new_employee(params)
    id = plsql.employees_seq.nextval
    {
      :employee_id => id,
      :first_name => 'First',
      :last_name => 'Last'+id,
      :email => "first.last#{id}@example.com",
      :phone_number => nil,
      :hire_date => Time.today,
      :job_id => plsql.jobs.first[:job_id],
      :commission_pct => nil,
      :salary => nil,
      :manager_id => nil,
      :department_id =>nil,
    }.merge(params)
  end

  def create_employee(params)
    employee = get_new_employee(params)
    plsql.employees.insert employee
    get_employee employee[:employee_id]
  end

  # Select employee by primary key
  def get_employee(employee_id)
    plsql.employees.first :employee_id => employee_id
  end

end
