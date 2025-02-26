# This is the example problem:

class Report
  def initialize
    @title = 'Monthly Report'
    @text = ['Things are going', 'really, really well.']
  end

  def output_report
    puts '<html>'
    puts '  <head>'
    puts "    <title>#{@title}</title>"
    puts '  </head>'
    puts '  <body>'
    @text.each do |line|
      puts "    <p>#{line}</p>"
    end
    puts '  </body>'
    puts '</html>'
  end
end

report = Report.new
report.output_report

# This code is fine for generating basic HTML
# The issue is that it is not very flexible
# The reason it isn't flexible is because the output_report method is hard-coded to generate HTML