require 'employee_aip_pkg'

describe 'get employees' do

  it 'returns all employees' do
    plsql.employee_aip_pkg.get_employees do |cursror|
      expect( cursror.fetch_hash_all ).to eq plsql.employees.all
    end

  end

end
