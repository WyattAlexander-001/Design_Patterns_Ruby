class Human
  attr_accessor :name, :age, :gender

  def initialize(name, age, gender)
    @name = name
    @age = age
    @gender = gender
  end

  def introduce
    "Hi, my name is #{@name}. I am #{@age} years old and identify as #{@gender}."
  end

  def birthday
    @age += 1
    "Happy Birthday! #{@name} is now #{@age} years old!"
  end
end

# Creating an instance of Human
person1 = Human.new("Wyatt", 29, "Male")

# Accessing instance variables thanks to attr_accessor which makes setting and getting instance variables easier
puts person1.name  # Output: Wyatt
puts person1.age   # Output: 29
puts person1.gender  # Output Male  

person1.age = 30  # Output: 30
puts person1.age   # Output: 30


# Calling instance methods
puts person1.introduce  # Output: Hi, my name is Wyatt. I am 29 years old and identify as Male.

puts person1.birthday   # Output: Happy Birthday! Wyatt is now 30 years old!

puts person1.introduce  # Output: Hi, my name is Wyatt. I am 30 years old and identify as Male.
