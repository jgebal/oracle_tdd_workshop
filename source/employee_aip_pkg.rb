plsql.execute <<-SQL
create or replace package employee_aip_pkg as
  procedure add_employee( p_employee employees%rowtype );
end;
SQL


plsql.execute <<-SQL
create or replace package body employee_aip_pkg as
  procedure add_employee( p_employee employees%rowtype ) is
  begin
    insert into employees values p_employee;
  end;
end;
SQL
