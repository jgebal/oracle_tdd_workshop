describe 'get employee' do

  it 'returns a single employee for a given id' do
    expected = plsql.employees.first('where employee_id = :id', 1)
    expect( plsql.employees_api.get_empolyee(1) ).to eq(expected)
  end

end
