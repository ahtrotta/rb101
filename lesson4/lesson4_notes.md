# ** LESSON 4 NOTES **

=============================================================================

## **Collections Basics**

#### element reference

- strings use an integer-based index that represents each character in the string
- index starts at 0
- reference multiple characters by using an index starting point and the number of characters to return:
```ruby
str = 'abcdefghi'
str[2, 3]                   # => "cde"
str.slice(2, 3)             # => "cde"
```
- arrays are also ordered, zero-indexed collections
- each element can be any object
- multilpe elements can be accessed in the same way as above for strings:
```ruby
arr = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
arr[2, 3]                   # => ["c", "d", "e"]
```
- `Array#slice` and `String#slice` are not the same method, even though they have a lot of the same functionality
- when selecting multiple elements in a new array using `Array#slice`, a new array is returned
- when selecting a single element by passing in only an index using `Array#slice`, the element at that index is returned (not an array)
```ruby
arr = [1, 'two', :three, '4']
arr.slice(3, 1)             # => ["4"]
arr.slice(3..3)             # => ["4"]
arr.slice(3)                # => "4"
```
- it is important to be aware of exactly what is returned
- hashes use key-value pairs, where the key or value can be any type of ruby object
object
- when initializing a hash, the keys must be unique
- if the keys are not unique, they will be overwritten by the last entry
```ruby
hsh = { 'fruit' => 'apple', 'vegetable' => 'carrot', 'fruit' => 'pear' }
(irb): warning: key 'fruit' is duplicated and overwritten on line 1
=> {"fruit"=>"pear", "vegetable"=>"carrot"}
```
- values can be duplicated without problem
- we can access just the keys or just the values using `#keys` or `#values`, which return an array:
```ruby
country_capitals = { uk: 'London', france: 'Paris', germany: 'Berlin' }
country_capitals.keys      # => [:uk, :france, :germany]
country_capitals.values    # => ["London", "Paris", "Berlin"]
country_capitals.values[0] # => "London"
```
- in the above example, symbols are used as keys, which is a common convention in ruby
- there are advantages to using symbols as keys

#### element reference gotchas

- referening an out-of-bounds index returns `nil`
```ruby
str = 'abcde'
arr = ['a', 'b', 'c', 'd', 'e']
str[2] # => "c"
arr[2] # => "c"
str[5] # => nil
arr[5] # => nil
```
- this is not a problem for a string since `nil` is an invalid return value
- with an array, `nil` could be a valid return value since arrays can contain any type of object
```ruby
arr = [3, 'd', nil]
arr[2] # => nil
arr[3] # => nil
```
- ruby has a method called `Array#fetch` that tries to return the element at position index, but throws an `IndexError` if the referenced index lies outside of the array bounds
```ruby
arr.fetch(2) # => nil
arr.fetch(3) # => IndexError: index 3 outside of array bounds: -3...3
             #        from (irb):3:in `fetch'
             #        from (irb):3
             #        from /usr/bin/irb:11:in `<main>'
```
- the key point is to be careful when using `#[]` and getting `nil`
- elements in `String` and `Array` can be referenced using negative indices, starting from the last index in the collection `-1` and working backwards
- `Hash` also has a `#fetch` method which can be useful when trying to disambiguate valid hash keys with a `nil` value from invalid hash keys
```ruby
hsh = { :a => 1, 'b' => 'two', :c => nil }

hsh['b']       # => "two"
hsh[:c]        # => nil
hsh['c']       # => nil
hsh[:d]        # => nil

hsh.fetch(:c)  # => nil
hsh.fetch('c') # => KeyError: key not found: "c"
               #        from (irb):2:in `fetch'
               #        from (irb):2
               #        from /usr/bin/irb:11:in `<main>'
hsh.fetch(:d)  # => KeyError: key not found: :d
               #        from (irb):3:in `fetch'
               #        from (irb):3
               #        from /usr/bin/irb:11:in `<main>'
```
- `Hash#to_a` returns an array
```ruby
hsh = { sky: "blue", grass: "green" }
hsh.to_a # => [[:sky, "blue"], [:grass, "green"]]
```
- `Array#to_h` does the reverse
```ruby
arr = [[:name, 'Joe'], [:age, 10], [:favorite_color, 'blue']]
arr.to_h # => { :name => "Joe", :age => 10, :favorite_color => "blue" }
```
- it is possible to use the element assignment notation of `String` to change the value of a specific character within a string
```ruby
str = "joe's favorite color is blue"
str[0] = 'J'
str # => "Joe's favorite color is blue"
```
- note that this is a destructive action and the `str` is changed permanently
- the same action can be performed on arrays
```ruby
arr = [1, 2, 3, 4, 5]
arr[0] += 1 # => 2
arr         # => [2, 2, 3, 4, 5]
```

=============================================================================

## **Introduction to PEDAC process**

1. [Understand the] **P**roblem
2. **E**xamples/Test cases
3. **D**ata Structure
4. **A**lgorithm
5. **C**ode

- following the PEDAC process saves time and lets you solve complex problems more efficiently

#### [understand the] **p**roblem

1. read the problem description
2. check the test cases, if any
3. if any part is unclear, ask the interviewer or problem requester for clarification

example:
```ruby
# PROBLEM:

# Given a string, write a method change_me which returns the same
# string but with all the words in it that are palindromes uppercased.

# change_me("We will meet at noon") == "We will meet at NOON"
# change_me("No palindromes here") == "No palindromes here"
# change_me("") == ""
# change_me("I LOVE my mom and dad equally") == "I LOVE my MOM and DAD equally"
```
After reading, some items may need clarification:
1. **What is a palindrom?** 
2. **Should the words in the string remain the same if they already use uppercase?** Check the test cases. In the fourth one, `LOVE` already uses uppercase and remains uppercase in the solution
3. **How should I deal with empty strings provided as input?** Test case 3 provides the answser.
4. **Can I assume that all inputs are strings?** Test cases don't show any non-string inputs, so ask the interviewer.
5. **Should I consider letter case when deciding whether a word is palindrome?** Test cases don't help. The interviewer may say that palindrome words should be case sensitive
6. **Do I need to return the same string object or an entirely new string?** This is one of the most overlooked questions. 

- to conclude this part of the PEDAC process, you need to write down inputs and outputs, and describe rules to follow
```ruby
# input: string
# output: string (not the same object)
# rules:
#      Explicit requirements:
#        - every palindrome in the string must be converted to
#          uppercase. (Reminder: a palindrome is a word that reads
#          the same forwards and backward).
#        - Palindromes are case sensitive ("Dad" is not a palindrome, but "dad" is.)

#      Implicit requirements:
#        - the returned string shouldn't be the same string object.
```

#### **d**ata structure / **a**lgorithm

- data structures influence your algorithm, so these steps are often paired
- the biggest problem students usually have with algorithms is providing enough detail
another example:
```ruby
# PROBLEM:

# Given a string, write a method `palindrome_substrings` which returns
# all the substrings from a given string which are palindromes. Consider
# palindrome words case sensitive.

# Test cases:

# palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
# palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
# palindrome_substrings("palindrome") == []
# palindrome_substrings("") == []
```
questions
1. return same object or new object?
2. how should whitepsace be treated?
3. how should non-alphabetic characters be treated?
input: a string
output: an array of substrings
```ruby
# Some questions you might have?
# 1. What is a substring?
# 2. What is a palindrome?
# 3. Will inputs always be strings?
# 4. What does it mean to treat palindrome words case-sensitively?

# input: string
# output: an array of substrings
# rules:
#      Explicit requirements:
#        - return only substrings which are palindromes.
#        - palindrome words should be case sensitive, meaning "abBA"
#          is not a palindrome.
```
```ruby
# Algorithm:
#  - initialize a result variable to an empty array
#  - create an array named substring_arr that contains all of the
#    substrings of the input string that are at least 2 characters long.
#  - loop through the words in the substring_arr array.
#  - if the word is a palindrome, append it to the result
#    array
#  - return the result array
```
- the above algorithm is representative of those often seen during student interviews
- it's missing a lot of detail because there is no explanation of how to get all substrtings of at least 2 characters in length
- there should be a sub-algorithm 
```ruby
# - create an empty array called `result` that will contain all
#   the required substrings
# - initialize variable start_substring_idx and assign 0 to it.
# - initialize variable end_substring_idx and assign value of
#   start_substring_idx + 1 to it.
# - Enter loop which will break when start_substring_idx is equal
#     to str.size
#   - Within that loop enter another loop that will break if
#     end_substring_idx is equal to str.size
#     - append to the result array part of the string from
#       start_substring_idx to end_substring_idx
#     - increment `end_substring_idx` by 1.
#   - end the inner loop
#   - increment `start_substring_idx` by 1.
#   - reassign `end_substring_idx` to `start_substring_idx += 1`
# - end outer loop
# - return `result` array
```
```ruby
def substrings(str)
  result = []
  start_substring_idx = 0
  end_substring_idx = start_substring_idx + 1
  loop do
    break if start_substring_idx == str.size
    loop do
      break if end_substring_idx == str.size
      result << str[start_substring_idx..end_substring_idx]
      end_substring_idx += 1
    end
    start_substring_idx += 1
    end_substring_idx = start_substring_idx + 1
  end
  result
end
```
- here's the complete pseudo-code:
```ruby
# input: a string
# output: an array of substrings
# rules: palindrome words should be case sensitive, meaning "abBA"
#        is not a palindrome

# Algorithm:
#  substrings method
#  =================
#  - create an empty array called `result` which will contain all
#    the required substrings
#  - initialize variable start_substring_idx and assign 0 to it.
#  - initialize variable end_substring_idx and assign value of
#    start_substring_idx + 1 to it.
#  - Enter loop which will break when start_substring_idx is equal
#      to str.size
#    - Within that loop enter another loop which will break if
#      end_substring_idx is equal to str.size
#      - append to the result array part of the string from
#        start_substring_idx to end_substring_idx
#      - increment `end_substring_idx` by 1.
#    - end the inner loop
#    - increment `start_substring_idx` by 1.
#    - reassign `end_substring_idx` to `start_substring_idx += 1`
#  - end outer loop
#  - return `result` array

#  is_palindrome? method
#  =====================
#  - check whether the string value is equal to its reversed
#    value. You can use the String#reverse method.

#  palindrome_substrings method
#  ============================
#  - initialize a result variable to an empty array
#  - create an array named substring_arr that contains all of the
#    substrings of the input string that are at least 2 characters long.
#  - loop through the words in the substring_arr array.
#    - if the word is a palindrome, append it to the result
#      array
#  - return the result array
```
- here's the code:
```ruby
def substrings(str)
  result = []
  start_substring_idx = 0
  end_substring_idx = start_substring_idx + 1
  loop do
    break if start_substring_idx == str.size
    loop do
      break if end_substring_idx == str.size
      result << str[start_substring_idx..end_substring_idx]
      end_substring_idx += 1
    end
    start_substring_idx += 1
    end_substring_idx = start_substring_idx + 1
  end
  result
end

def is_palindrome?(str)
  str == str.reverse
end

def palindrome_substrings(str)
  result = []
  substrings_arr = substrings(str)
  substrings_arr.each do |substring|
    result << substring if is_palindrome?(substring)
  end
  result
end
```
- note that you don't need to write all of your pseudo-code jbefore you start coding
- you might start with a high level version, write the code for it, and then return to write the relevant helper methods
- if you can't write a plain English solution to the problem you won't be able to code it either

#### testing frequently

- testing isn't properly part of the PEDAC approach, but it's very important
- test your code early and often while writing it

=============================================================================

## **Selection and Tranformation**

- besides iteration, the two most common actions to perform on a collection are selection and transformation
- selection is picking certain elements out based on some criteria
- transformation is manipulating every element in the collection
- if there are `n` elements, selection will result in `n` or fewer elements while transformation will result in exactly `n` elements
- selection and transformation utilize the basics of looping:
1. loop
2. counter
3. retrieve current value
4. exit the loop
- additionally, selection and transformation require some criteria 
- example of selection (basic loop with an added `if` statement):
```ruby
alphabet = 'abcdefghijklmnopqrstuvwxyz'
selected_chars = ''
counter = 0

loop do
  current_char = alphabet[counter]

  if current_char == 'g'
    selected_chars << current_char    # appends current_char into the selected_chars string
  end

  counter += 1
  break if counter == alphabet.size
end

selected_chars # => "g"
```
- the `if` condition is the selection criteria
- same principles apply to transformation
```ruby
fruits = ['apple', 'banana', 'pear']
transformed_elements = []
counter = 0

loop do
  current_element = fruits[counter]

  transformed_elements << current_element + 's'   # appends transformed string into array

  counter += 1
  break if counter == fruits.size
end

transformed_elements # => ["apples", "bananas", "pears"]
```
- it's important to pay attention to whether the original collection was mutated or if a new collection was returned

#### extracting to methods

- most often selecting or transforming a collection is a very specific action that lends itself to extraction into convenience methods
- example: select vowels in a string
```ruby
if 'aeiouAEIOU'.include?(current_char)
  selected_chars << current_char
end
```
```ruby
def select_vowels(str)
  selected_chars = ''
  counter = 0

  loop do
    current_char = str[counter]

    if 'aeiouAEIOU'.include?(current_char)
      selected_chars << current_char
    end

    counter += 1
    break if counter == str.size
  end

  selected_chars
end
```
- an example with hashes: select the key-value pairs where the value is `'Fruit'`
```ruby
produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

def select_fruit(hash)
  new_hash = {}
  hash.keys.each do |key|
    new_hash[key] = 'Fruit' if hash[key] == 'Fruit'
  end
  new_hash
end

select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}
```
- example that doubles each number in an array
```ruby
def double_numbers!(numbers)
  0.upto(numbers.size - 1).each { |i| numbers[i] *= 2 }
  numbers
end
```
- transformation can only occur on a subset of elements in the collection
```ruby
def double_odd_numbers(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    current_number *= 2 if current_number.odd?
    doubled_numbers << current_number

    counter += 1
  end

  doubled_numbers
end
```
- doubling the numbers that have odd indices:
```ruby
def double_odd_numbers(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    current_number *= 2 if counter.odd?
    doubled_numbers << current_number

    counter += 1
  end

  doubled_numbers
end
```
- defining methods that take additional arguments to alter the logic of the iteration allows for more flexible and generic methods
- a more general version of `select_fruit`
```ruby
def general_select(produce_list, selection_criteria)
  produce_keys = produce_list.keys
  counter = 0
  selected_produce = {}

  loop do
    break if counter == produce_keys.size

    current_key = produce_keys[counter]
    current_value = produce_list[current_key]

    # used to be current_value == 'Fruit'
    if current_value == selection_criteria
      selected_produce[current_key] = current_value
    end

    counter += 1
  end

  selected_produce
end

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

general_select(produce, 'Fruit')     # => {"apple"=>"Fruit", "pear"=>"Fruit"}
general_select(produce, 'Vegetable') # => {"carrot"=>"Vegetable", "broccoli"=>"Vegetable"}
general_select(produce, 'Meat')      # => {}
```
- updated version of `double_numbers`
```ruby
def multiply(numbers, multiplier)
  numbers.map { |n| n *= multiplier }
end
```

=============================================================================

## **Methods**

- iterating over a collection is so common that ruby provides a method for it
- the `each` method is functionally equivalent to using `loop`
```ruby
numbers = [1, 2, 3]
counter = 0

loop do
  break if counter == numbers.size
  puts numbers[counter]
  counter += 1
end
```
is equivalent to:
```ruby
[1, 2, 3].each do |num|
  puts num
end
```
- calling each on a hash looks different because the method passes both the key and the value to the block for each iteration
```ruby
hash = { a: 1, b: 2, c: 3 }

hash.each do |key, value|
  puts "The key is #{key} and the value is #{value}"
end
```
- once `each` is done iterating, it returns the original collection
```
irb :001 > [1, 2, 3].each do |num|
irb :002 >   puts num
irb :003 > end
1
2
3
=> [1, 2, 3] 
```
- arrays and hashes also have a built-in way to iterate over a collection and perform selection
```ruby
[1, 2, 3].select do |num|
  num.odd?
end
```
- if the value of the block is 'truthy' then the element during that iteration will be selected
- when an element is selected it is placed in a new collection
```ruby
[1, 2, 3].select do |num|
  num + 1
  puts num
end
```
- the above example will return an empty array because the return value of puts is `nil`
```
irb :001 > [1, 2, 3].select do |num|
irb :002 >   num + 1
irb :003 >   puts num
irb :004 > end
1
2
3
=> []
```
- similarly to `select`, `map` also considers the return value of the block
- `map` uses the return value to perform a transformation instead of selection
- `map` returns a new collection
```ruby
[1, 2, 3].map do |num|
  num * 2
end
```
```
irb :001 > [1, 2, 3].map do |num|
irb :002 >   num * 2
irb :003 > end
=> [2, 4, 6]
```
- what happens if the code in the block is not a transformation instruction?
```ruby
[1, 2, 3].map do |num|
  num.odd?
end
```
- the collection returned by `map` is an array of booleans
```
irb :001 > [1, 2, 3].map do |num|
irb :002 >   num.odd?
irb :003 > end
=> [true, false, true]
```
- the `select` and `map` methods are defined in a module called Enumerable and are made available to the `Array` and `Hash` classes
- certain collection types have access to specific methods for a reason
Method | Action | Considers the return value of the block? | Returns a new collection from the method? | Length of the returned collection
----- | ----- | ----- | ----- | -----
`each` | Iteration | No | No, it returns the original | Length of original
`select` | Selection | Yes, its truthiness | Yes | Length of original or less
`map` | Transformation | Yes | Yes | Length of original

=============================================================================


