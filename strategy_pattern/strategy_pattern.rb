# This implementation is all about DELEGATION
# Take out the annoying bit of your algorithm and put it in a separate object

class Formatter
  def output_report(title, text) # All subclasses of Formatter must implement this method
    raise 'Called abstract method: output_report'
  end
end

# ==== Concrete Strategies ====

class HTMLFormatter < Formatter
  def output_report(title, text)
    puts('<html>')
    puts(' <head>')
    puts(" <title>#{title}</title>")
    puts(' </head>')
    puts(' <body>')
    text.each do |line|
      puts(" <p>#{line}</p>")
    end
    puts(' </body>')
    puts('</html>')
  end
end

class PlainTextFormatter < Formatter
  def output_report(title, text)
    puts("*** #{title} ***")
    text.each do |line|
      puts(line)
    end
  end
end

class BroTalkFormatter < Formatter
  def output_report(title, text)
    puts("Yo, this is the #{title}")
    text.each do |line|
      puts("And I'm like, #{line}")
    end
    puts("So yeah, peace out.")
    puts("And remember, bros before shoes.")
  end
end
# ==============================


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
    @formatter.output_report(@title, @text)
  end
end



  report = Report.new(HTMLFormatter.new) # Here we are using the HTMLFormatter
  report.output_report # This will output the report in HTML
  puts "====================="
  report.formatter = PlainTextFormatter.new # Here we are using the PlainTextFormatter notice that we are changing the formatter
  report.output_report
  puts "====================="
  report.formatter = BroTalkFormatter.new
  report.output_report


=begin

This code demonstrates the **Strategy Pattern** using delegation.

1. The `Formatter` class defines an interface (abstract method `output_report`) that all formatters must implement.
2. The `HTMLFormatter` and `PlainTextFormatter` classes inherit from `Formatter` and implement `output_report` in different ways.
3. The `Report` class contains:
   - A `formatter` attribute that determines how the report is formatted.
   - A `title` and `text` for the report content.
   - The `output_report` method that calls the assigned formatter's `output_report` method.
4. The **key feature** of this implementation is that it allows changing the formatting logic dynamically by assigning a different formatter to the `Report` object.
5. This approach **promotes code reuse and separation of concerns** by isolating formatting logic from the `Report` class.

=end

