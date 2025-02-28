# This area serves as a playground for testing out code snippets
puts "hello world"
puts "Reading the Pickaxe book"
puts "It's true, you should get into the habit of writing code every day"

fave_language = "Ruby"
multi_line_string = %Q{
  *************
  # This is a comment, well actually no, it's part of a multi-line string!
  But this is not a comment, it's a string
  Anyway I love #{fave_language} it's my favorite language
  Yeah the above was string interpolation
  Honestly the 3 main things to learn cold in programming are:
  1. Variables
  2. Loops
  3. Conditionals
  And then you can build on that, like
  Functions are simply reusable code blocks that use variables, loops, and conditionals
  An Object or Struct is simply a collection of variables and functions
  Arrays, Hashmaps, and LinkedLists are just points 1 and 2
    Like an array is a collection of variables and a hashmap is a collection of variables with keys
  
  #{fave_language} is the perfect language to learn these concepts
  And as a programmer, you are always reading and writing code, and relearning concepts to get better
  So keep at it, and you'll get better
  And remember, the best way to learn is to teach, so teach others what you know
  And always be learning, because the world is always changing
  But the fundamentals of programming are always the same
  And that's why I love programming
  - Wyatt B
  *************
}

puts multi_line_string