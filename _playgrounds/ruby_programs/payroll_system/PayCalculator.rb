module PayCalculator
  def calculate_pay
    raise NotImplementedError, "Subclasses must define `calculate_pay`"
  end
end

# Design pattern used: Strategy Pattern
class HourlyPayCalculator # We don't need to inherit from PayCalculator, we can just include the module, this is a mixin
  include PayCalculator # We can include the module to avoid duplication of the method signature, so like Java's interface

  def initialize(hourly_rate, hours_worked, overtime_rate = 1.5)
    @hourly_rate = hourly_rate
    @hours_worked = hours_worked
    @overtime_rate = overtime_rate
  end

  def calculate_pay # This method is required to be implemented by the PayCalculator module, no need for an override keyword
    overtime_hours = [@hours_worked - 40, 0].max
    regular_hours = @hours_worked - overtime_hours
    (regular_hours * @hourly_rate) + (overtime_hours * @hourly_rate * @overtime_rate)
  end
end

class SalariedPayCalculator
  include PayCalculator

  def initialize(annual_salary, pay_periods)
    @annual_salary = annual_salary
    @pay_periods = pay_periods
  end

  def calculate_pay
    @annual_salary / @pay_periods
  end
end

class Employee
  attr_reader :name, :pay_calculator, :deductions # Getters

  def initialize(name, pay_calculator, deductions = [])
    @name = name
    @pay_calculator = pay_calculator # This is a strategy object, it can be either HourlyPayCalculator or SalariedPayCalculator
    @deductions = deductions
    # ... Can add other stuff like address, date of birth, gender, etc.
    # e.g. @address = address, it would be a huge constructor if we add all the fields here
    # A possible solution is to use the Builder Pattern to create the Employee object
  end

  def net_pay
    gross = @pay_calculator.calculate_pay # calculate_pay is a method that is defined in the PayCalculator module, and is able to 
    total_deductions = @deductions.sum { |d| d.apply(gross) } 
    gross - total_deductions
  end
end

class Deduction
  attr_reader :name

  def initialize(name, percentage)
    @name = name
    @percentage = percentage
  end

  def apply(gross_pay)
    gross_pay * (@percentage / 100.0) # Convert percentage to decimal e.g. 20% to 0.20
  end
end

# Say we have a tax rate of 20% and a 401k deduction of 5%
deductions = [Deduction.new("Tax", 20), Deduction.new("401k", 5)]

# Create an employee with an hourly pay rate of $20, and worked 45 hours
john_hourly= Employee.new("John Doe", HourlyPayCalculator.new(20, 45), deductions)

# Create an employee with an annual salary of $60,000, and 26 pay periods
jane_salary = Employee.new("Jane Smith", SalariedPayCalculator.new(60000, 26), deductions)

puts "#{john_hourly.name} - Net Pay: $#{john_hourly.net_pay.round(2)}"
puts "#{jane_salary.name} - Net Pay: $#{jane_salary.net_pay.round(2)}"
