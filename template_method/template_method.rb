# Somewhere right in the middle of your complex code is a bit that needs to vary
class Report
  def initialize
    @title = 'Monthly Report'
    @text = ['Things are going', 'really, really well.']
  end

  # This is the template method that is the same for all subclasses
  def output_report
    output_start
    output_head
    output_body_start
    output_body
    output_body_end
    output_end
  end

  def output_body
    @text.each do |line| # line refers to each element in the array
      output_line(line)
    end
  end

  def output_start
    raise 'Called abstract method: output_start'
  end

  def output_head
    raise 'Called abstract method: output_head'
  end

  def output_body_start
    raise 'Called abstract method: output_body_start'
  end

  def output_line(_line)
    raise 'Called abstract method: output_line'
  end

  def output_body_end
    raise 'Called abstract method: output_body_end'
  end

  def output_end
    raise 'Called abstract method: output_end'
  end
end

# You could put this in a separate file and simply require it like: require 'html_report.rb'
class HTMLReport < Report
  def output_start
    puts('<html>')
  end

  def output_head
    puts(' <head>')
    puts(" <title>#{@title}</title>")
    puts(' </head>')
  end

  def output_body_start
    puts('<body>')
  end

  def output_line(line)
    puts(" <p>#{line}</p>")
  end

  def output_body_end
    puts('</body>')
  end

  def output_end
    puts('</html>')
  end
end

# Same deal here, you could put this in a separate file and simply require it like: require 'plain_text_report.rb'
class PlainTextReport < Report
  def output_start; end # end means that the method is empty

  def output_head
    puts("**** #{@title} ****")
    puts
  end

  def output_body_start; end

  def output_line(line)
    puts(line)
  end

  def output_body_end; end

  def output_end; end
end

class BroSpeakReport < Report
  def output_start
    puts('Yo, here is your report')
  end

  def output_head
    puts("**** #{@title} ****")
    puts
  end

  def output_body_start; end

  def output_line(line)
    puts(line + ', dude')
  end

  def output_body_end; end

  def output_end
    puts('Peace out')
  end
end

# Now we can create an HTML report

report = HTMLReport.new
report.output_report # output_report exists in the Report class
# Output will reflect the settings we made in the HTMLReport class

report = PlainTextReport.new
report.output_report # again, output_report exists in the Report class
# Output will reflect the settings we made in the PlainTextReport class

report = BroSpeakReport.new
report.output_report # again, output_report exists in the Report class
# Output will reflect the settings we made in the BroSpeakReport class


# ========= Explanation =========
=begin
This code demonstrates the **Template Method Pattern**, a behavioral design pattern 
that defines the structure of an algorithm in a base class and allows subclasses 
to provide specific implementations for some of the steps.

### How It Works:
1. **Abstract Class (`Report`)**:
   - Defines the `output_report` method, which serves as the **template** 
     for generating reports.
   - Contains abstract methods (`output_start`, `output_head`, etc.), 
     which subclasses must implement.

2. **Concrete Subclasses (`HTMLReport` & `PlainTextReport`)**:
   - Implement the abstract methods to output reports in different formats 
     (HTML vs. plain text).
   - Follow the same structure as enforced by `output_report`, ensuring 
     consistency across all report formats.

### Benefits of the Template Method Pattern:
- **Code Reusability**: Common logic is defined in the superclass (`Report`), 
  avoiding duplication in subclasses.
- **Extensibility**: New report formats can be added by creating new subclasses 
  without modifying the existing base class.
- **Encapsulation of Algorithm Structure**: The high-level structure (`output_report`) 
  is fixed, while details are left to subclasses.

This approach ensures **scalability and maintainability**, making it easy to 
introduce new report types with minimal changes to existing code.
=end




