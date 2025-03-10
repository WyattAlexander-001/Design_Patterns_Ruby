# ====== Subject (Observable) ======
class Employee
  attr_reader :name
  attr_accessor :title, :salary

  def initialize(name, title, salary)
    @name = name
    @title = title
    @salary = salary
    @observers = [] # This is the list of observers
  end

  # Notify each observer about a specific attribute change
  def notify_observers(attribute)
    @observers.each do |observer|
      observer.update(self, attribute)
    end
  end

  def add_observer(observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

  # When title changes, notify observers with :title
  def title=(new_title)
    @title = new_title
    notify_observers(:title)
  end

  # When salary changes, notify observers with :salary
  def salary=(new_salary)
    @salary = new_salary
    notify_observers(:salary)
  end
end

# ====== Observers ======
class Payroll
  # Called by 'notify_observers'
  def update(changed_employee, changed_attribute)
    case changed_attribute
    when :salary
      puts("Cut a new check for: #{changed_employee.name}")
      puts("His salary is now $#{changed_employee.salary}")
    when :title
      puts("Payroll updated! #{changed_employee.name} has a new title: #{changed_employee.title}")
    end
  end
end

class TaxMan
  def update(changed_employee, changed_attribute)
    case changed_attribute
    when :salary
      puts("Send #{changed_employee.name} a new tax bill! Salary is now $#{changed_employee.salary}")
    when :title
      puts("Send #{changed_employee.name} a tax form revision notice—title changed to #{changed_employee.title}.")
    end
  end
end

class WeeklyPayroll
  def update(changed_employee, changed_attribute)
    case changed_attribute
    when :salary
      puts("Looking at weekly salary for #{changed_employee.name}.")
      puts("Weekly: $#{format('%.2f', changed_employee.salary / 52.0)}")
    when :title
      puts("#{changed_employee.name} changed title to '#{changed_employee.title}'—no weekly pay impact.")
    end
  end
end

class MonthlyPayroll
  def update(changed_employee, changed_attribute)
    case changed_attribute
    when :salary
      puts("Looking at monthly salary for #{changed_employee.name}.")
      puts("Monthly: $#{format('%.2f', changed_employee.salary / 12.0)}")
    when :title
      puts("#{changed_employee.name} has a new title (#{changed_employee.title})—check any monthly adjustments.")
    end
  end
end

# ====== Demonstration ======
fred = Employee.new('Frank', 'Janitor', 30_000.00)

# Observers
payroll         = Payroll.new
tax_man         = TaxMan.new
weekly_payroll  = WeeklyPayroll.new
monthly_payroll = MonthlyPayroll.new

# Add observers to 'fred'
fred.add_observer(payroll)
fred.add_observer(tax_man)
fred.add_observer(weekly_payroll)
fred.add_observer(monthly_payroll)

# Changing salary
puts "***** Changing salary ******"
fred.salary = 35_000.00
puts "#######################"
fred.salary = 40_000.00

# Changing title
puts "******* Changing title *******"
fred.title = 'Head Janitor'
puts "#######################"
fred.title = 'Operations Manager'


=begin
  This block of code illustrates the Observer (publish-subscribe) pattern in Ruby.

  1. Subject (Employee):
     - Maintains a list of observers.
     - Notifies observers whenever one of its attributes changes (title or salary).
     - Observers register themselves to receive updates.

  2. Observers (Payroll, TaxMan, WeeklyPayroll, MonthlyPayroll):
     - Implement an `update` method, which is called by the subject.
     - Each observer receives both the changed employee (subject) and the attribute that changed (:salary or :title).
     - They can then handle the change accordingly (e.g., printing out salary changes, sending notices, etc.).

  This decouples the objects (observers) from the subject, promoting loose coupling and scalability:
  - You can add or remove observers without modifying the subject’s core logic.
  - Each observer focuses on its own specific behavior when changes occur.

  In short, this example demonstrates how to keep multiple parts of a system in sync
  whenever a notable change happens, all without unnecessary inter-dependencies.
=end
