# This implementation is all about DELEGATION
# Take out the annoying bit of your algorithm and put it in a separate object

# Deleted The Formatter class from the previous implementation

# ==== Context ====
class Report
  attr_reader :title, :text
  attr_accessor :formatter # How this works is that we are setting the formatter to be an attribute of the Report class

  def initialize(formatter) # Here you'd pass in a concrete strategy object like HTMLFormatter.new or PlainTextFormatter.new
    @title = 'Monthly Report'
    @text = ['Things are going', 'really, really well.']
    @formatter = formatter 
  end

  def output_report
    @formatter.output_report(self) # self refers to the current object which is the Report object
  end
end

# ==== Concrete Strategies ====

# All our classes basically implement the output_report method:

class HTMLFormatter
  def output_report(context) # The context refers to the Report object so context.title and context.text are the title and text of the Report object
    puts('<html>')
    puts(' <head>')
    puts(" <title>#{context.title}</title>")
    puts(' </head>')
    puts(' <body>')
    context.text.each do |line|
      puts(" <p>#{line}</p>")
    end
    puts(' </body>')
    puts('</html>')
  end
end

class PlainTextFormatter
  def output_report(context)
    puts("*** #{context.title} ***")
    context.text.each do |line|
      puts(line)
    end
  end
end

class BroTalkFormatter
  def output_report(context)
    puts("Yo, this is the #{context.title}")
    context.text.each do |line|
      puts("And I'm like, #{line}")
    end
    puts("So yeah, peace out.")
    puts("And remember, bros before shoes.")
  end
end
# ==============================


# Running the code
report = Report.new(HTMLFormatter.new)
report.output_report

report.formatter = PlainTextFormatter.new
report.output_report

report.formatter = BroTalkFormatter.new
report.output_report

=begin

This code demonstrates the **Strategy Pattern** using delegation but with a simplified approach.

### **Key Changes from Previous Implementation**
1. **Removed the `Formatter` superclass**
   - Instead of requiring formatters to inherit from `Formatter`, this version directly implements the formatting logic inside independent classes (`HTMLFormatter`, `PlainTextFormatter`, and `BroTalkFormatter`).
   - This allows for **greater flexibility**, as new formatters do not need to follow an inheritance structure.

2. **`Report` Class as Context**
   - The `Report` class holds:
     - A `title` and `text` as the core data.
     - A `formatter` object that is responsible for displaying the report.
     - The `output_report` method that delegates formatting to `@formatter.output_report(self)`, passing the entire `Report` object (`self`) to the formatter.

3. **Decoupled Formatting Strategies**
   - Instead of formatters receiving a `title` and `text` separately, they now accept the **whole `Report` object** (`context`).
   - This means formatters can extract any needed data (`context.title`, `context.text`) dynamically.
   - This makes the formatting logic **more adaptable**, since formatters are not bound to a fixed set of parameters.

### **Benefits of This Approach**
✅ **Loose Coupling** - The `Report` class does not need to know how each formatter works, only that it has an `output_report(context)` method.  
✅ **Easier Extensibility** - New formatters can be added **without modifying existing code**.  
✅ **More Flexible Formatting** - Since formatters receive the entire `Report` object, they can modify how data is accessed or presented without changing `Report`.  
✅ **Strategy Pattern Without Inheritance** - Uses **composition instead of inheritance**, making it more flexible and reducing unnecessary dependencies.

### **Execution Flow**
1. A `Report` instance is created with an **`HTMLFormatter`**.
2. The `output_report` method calls `formatter.output_report(self)`, printing an HTML-formatted report.
3. The `formatter` is changed to `PlainTextFormatter`, and the report is printed in plain text.
4. The `formatter` is then changed to `BroTalkFormatter`, and the report is printed in a **casual, humorous tone**.

### **Final Thoughts**
- This implementation maintains the **Strategy Pattern** while simplifying the structure.
- It follows the **Open/Closed Principle (OCP)** - new formatters can be added **without modifying existing code**.
- The separation of concerns makes the code **clean, modular, and easy to maintain**.

=end

