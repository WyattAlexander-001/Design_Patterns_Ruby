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

This code is a cleaner way to **change how reports are formatted** without changing the `Report` class itself. 

### **What’s Different?**
1. **No More Formatter Superclass**
   - Before, we had a `Formatter` class that all formatters had to inherit from.
   - In Ruby, you **don’t need** to force everything into a class hierarchy. Instead, objects that respond to the same method (`output_report`) can be swapped easily.
   - This makes the code **simpler and more flexible**.

2. **Formatters Get the Whole Report**
   - Instead of passing just `title` and `text`, we now send the entire `Report` object (`self`).
   - Why? In Ruby, objects are **lightweight** and can easily be passed around.
   - This lets formatters grab any part of the report they need, **without changing how Report works**.

### **Why is this Better in Ruby?**
✅ **Ruby doesn’t force strict rules** like Java or C++—if an object has the right method (`output_report`), it works!  
✅ **No unnecessary inheritance**—formatters don’t need a superclass, they just need the right method.  
✅ **More flexible and readable**—changing the format is as easy as switching the `formatter` object.  

### **How This Works**
1. We create a `Report` and give it an `HTMLFormatter`.
2. The `output_report` method tells the formatter to print the report.
3. We change the `formatter` to `PlainTextFormatter` and call `output_report` again.
4. We switch to `BroTalkFormatter` and print one last time.
5. The `Report` class **never changes**, but it can produce totally different outputs.

### **Why This is Cool**
- We can **add new formatters anytime** without touching the `Report` class.
- We use **Ruby’s dynamic nature** to treat different objects the same, as long as they have `output_report`.

This is a **Ruby-friendly way** to use the **Strategy Pattern** without making things too complicated.

=end


