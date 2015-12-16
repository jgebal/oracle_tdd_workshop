require_relative 'employees_api'

describe 'get employee' do

  it 'returns a single employee record for a given id' do
    expected = plsql.employees.first('where employee_id = :id', 100)
    expect( plsql.employees_api.get_by_id(100) ).to eq(expected)
  end

  it 'raises exception if record is not found' do
    expect{ plsql.employees_api.get_by_id(-100) }.to raise_exception(/no data found/)
  end

  it 'raises exception if null parameter given' do
    expect{ plsql.employees_api.get_by_id(NULL) }.to raise_exception(/value error/)
  end
end
