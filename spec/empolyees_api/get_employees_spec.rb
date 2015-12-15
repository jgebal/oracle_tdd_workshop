require_relative 'get_employees'

describe 'get employees with salary above a value' do

  before(:all) do
    @very_high_salary_person = [-1, 'Jacek', 'Gebal', 'jacek.gebal', '515.123.4567', Time.local(2015, 03, 30), 'AD_PRES', 100000.00, NULL, NULL, 90]
    plsql.employees.insert_values(@very_high_salary_person )
  end

  it 'returns a cursor with all columns from employee table' do
    columns = NULL
    plsql.employees_api.get_employees(100) do |cursor|
      columns = cursor.fields
    end

    expected = plsql.employees.columns.keys
    expect( columns ).to eq( expected )
  end

  it 'returns a person with very high salary' do
    data = NULL
    plsql.employees_api.get_employees(100000) do |cursor|
      data = cursor.fetch_all
    end
    expect( data ).to eq [ @very_high_salary_person ]
  end

end
