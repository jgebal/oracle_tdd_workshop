require 'spec_helper'

# load 'award_bonus' procedure into the database
require 'award_bonus'

describe 'Award bonus' do
  include EmployeeFactory

  [ [1000,  1234.55,  0.10,   1123.46],
    [nil,   1234.56,  0.10,   123.46],
    [1000,  1234.54,  0.10,   1123.45]
  ].each do |salary, sales_amt, commission_pct, result|
    it "is updating salary to #{result.inspect} = base salary #{salary.inspect} + sales amount #{sales_amt} * commission percentage #{commission_pct}" do
      employee = create_employee(
        :commission_pct => commission_pct,
        :salary => salary
      )
      plsql.award_bonus(employee[:employee_id], sales_amt)
      expect(get_employee(employee[:employee_id])[:salary]).to eq result
    end
  end

  it 'is raising ORA-06510 exception if commission percentage is missing' do
    salary, sales_amt, commission_pct = 1000,  1234.55,  NULL
    employee = create_employee(
      :commission_pct => commission_pct,
      :salary => salary
    )
    expect {
      plsql.award_bonus(employee[:employee_id], sales_amt)
    }.to raise_error(/ORA-06510/)
  end

end

