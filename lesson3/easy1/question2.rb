# problem: Describe the difference between ! and ? in Ruby. And explain what would happen in the following scenarios:
#
#   1. what is != and where should you use it?
#   2. put ! before something like, !user_name
#   3. put ! after something, like words.uniq!
#   4. put ? before something
#   5. put ? after something
#   6. put !! before something, like !!user_name
#
# answer: If ! is used at the end of a method name (method_name!) then it signifies that the method mutates the caller. If ? is used at the end of a method name (method_name?) then it typically signifies that the method returns a boolean value (true or false). 
#
#   1. != is the 'not equal to' comparison operator, returning either true or false and used in conditional checks
#   2. when ! is put before something it negates it, returning false if the object was truthy or true if the object was false or nil
#   3. see above
#   4. as far as I'm aware it doesn't do anything
#   5. ? is part of the ternary operator and often denotes methods that return true or false 
#   6. putting !! before something negates it twice
