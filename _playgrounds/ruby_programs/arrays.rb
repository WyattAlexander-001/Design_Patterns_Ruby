arr = []

# Fill array with 5 words
for i in 0..4
  arr << 'Hello ' + i.to_s
end

def output_arr(arr)
  arr.each do |word|
    puts word
  end
end

arr[3] = 'I WAS ORIGINALLY HELLO 3'
output_arr(arr)
puts "====================================="
puts arr[1..2]

new_arr = [0,1,2,3,4,5,6,7,8,9]
new_arr[0..2] = ["A", "B", "C"]
puts new_arr  

# Array of Strings
arr_w_shorthand = %w[wyatt anni jason trevor thomas mendel]
puts arr_w_shorthand

# Array of Symbols
arr_i_shorthand = %i[wyatt anni jason trevor thomas mendel]

# Pushing and popping
push_pop_arr = ["Apple", "Banana", "Cherry", "Durian", "Elderberry", "Fig"]
push_pop_arr.pop
push_pop_arr.push("Guava")
puts push_pop_arr
puts "====================================="
puts push_pop_arr.first
puts push_pop_arr.last



# Hashes

fave_authors = {
  George_Morikawa: ["Hajime No Ippo", "The Tale of Genji", "The Tale of Genji: The Movie"],
  Douglas_Adams: ["The Hitchhiker's Guide to the Galaxy", "The Hitchhiker's Guide to the Galaxy: The Movie"],
  Sir_Arthur_Conan_Doyle: ["The Hobbit", "The Lord of the Rings", "The Lord of the Rings: The Return of the King"],
}
# Print Author Then Books
fave_authors.each do |author, books|
  puts "#{author} wrote: #{books.join(', ')}"
end
# puts fave_authors[:George_Morikawa]
def adder(num, *more_numw)
  num + more_numw.sum
end

puts adder(1, 2, 3, 4, 5) # 15