describe 'invoking sqlplus with a file' do

  before(:all) do
    plsql.execute 'drop table new_table' rescue nil
  end

  after(:all) do
    plsql.execute 'drop table new_table' rescue nil
  end

  it 'creates a table from a file' do
    system 'sqlplus hr/hr@xe @spec/call_a_shell/new_table.sql'
    expect( plsql.new_table ).to be_a(PLSQL::Table)
  end

end
