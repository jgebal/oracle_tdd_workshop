require_relative 'employees_api'

describe 'get employees by last name salary above a value' do

  before(:all) do
    very_high_salary_person = [-1, 'Jacek', 'Gebal', 'jacek.gebal', '515.123.4567', Time.local(2015, 03, 30), 'AD_PRES', 200000, NULL, NULL, 90]
    plsql.employees.insert_values( very_high_salary_person )
  end

  it 'returns a persons with salary above the given value' do
    min_salary     = 100000
    expected_data = plsql.employees.all('where salary > :min_salary', min_salary)
    plsql.employees_api.get_by_salary_above(min_salary) do |cursor|
      expect( cursor.fetch_hash_all ).to eq expected_data
    end
  end

end
