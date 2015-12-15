require_relative 'get_employees'

describe 'get employees with salary above a value' do

  it 'returns a cursor with all columns from employee table' do
    columns = NULL
    plsql.employees_api.get_employees(100) do |cursor|
      columns = cursor.fields
    end

    expected = plsql.employees.columns.keys
    expect( columns ).to eq( expected )
  end

end
