# This file contains helper functions that can be used in other Ruby programs
# This swap function swaps the values of two variables and returns the first variable
def swap(a, b)
  # puts "a: #{a}, b: #{b}"
  temp_var = a
  a = b
  b = temp_var
  # puts "a: #{a}, b: #{b}"
  return a # This is the return value
end

def get_date_time_12hr()
  # return Time.now.strftime("%m/%d/%Y %I:%M:%S %p")
  return Time.now.strftime("%m/%d/%Y %I:%M%p")
end

puts get_time