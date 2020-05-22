# ** LESSON 5 **

=============================================================================

## **Sorting**

- another common way to work with collections is to sort them into some kind of order
- sorting is mostly performed on arrays; since items in arrays are accessed via their index, the order in which they appear is important
- strings don't have sorting methods
- since ruby 1.9 it is possible to sort `Hash` objects
```ruby
[2, 5, 3, 4, 1]
[1, 2, 3, 4, 5]
```
- how to turn the first array into the second array?
- it is possible to write looping code to perform manual sorting, it is beyond the scope of this lesson
- ruby provides a copule of methods that do this: `sort` and `sort_by`
```ruby
[2, 5, 3, 4, 1].sort            # => [1, 2, 3, 4, 5]
['c', 'a', 'e', 'b', 'd'].sort  # => ['a', 'b', 'c', 'd', 'e']
```
- how does ruby know how to order the elements in the array?

#### the `<=>` method

- any object in a collection that we want to sort must implement a `<=>` method
- this method performs a comparison between two objects of the same type and returns `-1`, `0`, or `1` depending on whether the first object is less than, equal to, or greater than the second object
- if the two objects can't be compared then `nil` is returned
```ruby
2 <=> 1     # => 1
1 <=> 2     # => -1
2 <=> 2     # => 0
'b' <=> 'a' # => 1
'a' <=> 'b' # => -1
'b' <=> 'b' # => 0
1 <=> 'a'   # => nil
```
- if you want to sort a collection that contains particular types of objects you need to know two things:
1. does that object type implement a `<=>` comparison method?
2. If yes, what is the implementation of that method for that object type?
- `String#<=>` determines order based on the ASCII table
- for example, `'A' <=> 'a'` returns `-1` because `'A'` precedes `'a'` in ASCIIbetical order
```ruby
'A' <=> 'a' # => -1
'!' <=> 'A' # => -1
# call ord to determine ASCII position
'b'.ord # => 98
'}'.ord # => 125
'b' <=> '}' # => -1
```
1. uppercase letters come before lowercase letters
2. digits and (most) punctuation come before letters
3. there is an extended ASCII table containing accented and other characters, these come after the main ASCII table

#### the `sort` method

- it's possible to call `sort` with a block, giving us more control over how the items are sorted
- the block needs two arguments (the two items to be compared) and the return value must be `-1`, `0`, `1`, and `nil`
```ruby
[2, 5, 3, 4, 1].sort do |a, b|
  a <=> b
end
# => [1, 2, 3, 4, 5]
```
- in the above example, we're just using `Integer#<=>` to perform the comparison, which is what `sort` would have done without the block
- the below example switches the order, returning the array in descending order
```ruby
[2, 5, 3, 4, 1].sort do |a, b|
  b <=> a
end
# => [5, 4, 3, 2, 1]
```
- additional code can be written in the block as long as the return value is `-1`, `0`, `1`, and `nil`
```ruby
[2, 5, 3, 4, 1].sort do |a, b|
  puts "a is #{a} and b is #{b}"
  a <=> b
end
# a is 2 and b is 5
# a is 4 and b is 1
# a is 3 and b is 1
# a is 3 and b is 4
# a is 2 and b is 1
# a is 2 and b is 3
# a is 5 and b is 3
# a is 5 and b is 4
# => [1, 2, 3, 4, 5]
```
