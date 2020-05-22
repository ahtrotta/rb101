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
- `String#<=>` compares multi-character strings character by character, if both are the same then the next characters are compared and so on
- in the case of `'cap'` and `'cape'`, the comparable characters are all equal but `'cape'` is longer and so is considered greater
```ruby
['arc', 'bat', 'cape', 'ants', 'cap'].sort
# => ["ants", "arc", "bat", "cap", "cape"]
```
- the implementation of `Array#<=>` is very similar
```ruby
[['a', 'cat', 'b', 'c'], ['b', 2], ['a', 'car', 'd', 3], ['a', 'car', 'd']].sort
# => [["a", "car", "d"], ["a", "car", "d", 3], ["a", "cat", "b", "c"], ["b", 2]]
```
- in the above example, the sub-array that has `'b'` at index 0 has `2` at its second index, which should evaluate to `nil` when compared, causing `sort` to throw an error
- no error is thrown because `sort` did not need to cmopare the second item of that array to be able to establish order
```ruby
[['a', 'cat', 'b', 'c'], ['a', 2], ['a', 'car', 'd', 3], ['a', 'car', 'd']].sort
# => ArgumentError: comparison of Array with Array failed
```

#### the `sort_by` method

- `sort_by` is similar to `sort` but is usually called with a block that determines how the items are compared
```ruby
['cot', 'bed', 'mat'].sort_by do |word|
  word[1]
end
# => ["mat", "bed", "cot"]
```
- here we are sorting using the character at index `1` of each string
- if you want to sort a hash you can use `sort_by`
- when used on a hash two arguments to the block are needed
```ruby
people = { Kate: 27, john: 25, Mike:  18 }
people.sort_by do |_, age|
  age
end
# => [[:Mike, 18], [:john, 25], [:Kate, 27]]
```
- `sort_by` returns an array, even when called on a `Hash`
- to sort the above hash by name `sort` would call `Symbol#<=>`, which converts symbols to strings before comparing them, ultimately using `String#<=>`
- in the above, one of the names isn't capitalized (`:john`), meaning that `:john` will come after `:Kate` and `:Mike`, which may not be desired
```ruby
people.sort_by do |name, _|
  name.capitalize
end
# => [[:john, 25], [:Kate, 27], [:Mike, 18]]
```
- `Array#sort` and `Array#sort_by` have equivalent destructive methods `Array#sort!` and `Array#sort_by`
- these methods are specific to arrays and are not available to hashes

#### other methods that use comparison

1. `min`
2. `max`
3. `minmax`
4. `min_by`
5. `max_by`
6. `minmax_by`
- these can be found in the docs for the `Enumerable` module

#### summary

- when sorting a collection, the objects you want to sort need a `<=>` method

=============================================================================

## **Nested Data Structures**

#### updating collection elements

```ruby
arr = [[1, 3], [2]]
arr[1] = "hi there"
arr                     # => [[1, 3], "hi there"]
```
- `arr[1] = "hi there"` is a destructive action that permanently changed the second element in the array
- it is possible to modify a value in a nested array in a similar way
```ruby
arr = [[1, 3], [2]]
arr[0][1] = 5
```
- in the second line of code above, itlooks like a chained reference, but it's not
- the first part, `arr[0]` is element reference and returns `[1, 3]`
- the second part `[1] = 5` is array element update, not reference
- it's a chained action, but the first part of that chain is element reference, while the second part is element update
```ruby
arr = [[1], [2]]
arr[0] << 3
arr # => [[1, 3], [2]]

arr = [[1], [2]]
arr[0] << [3]
arr # => [[1, [3]], [2]]
```

#### other nested structures

- hashes can also be nested
- arrays and hashes can be nested within each other, too
```ruby
arr = [{ a: 'ant' }, { b: 'bear' }]

arr[0][:c] = 'cat'
arr # => [{ :a => "ant", :c => "cat" }, { :b => "bear" }]
```
- arrays can contain any type of ruby object
```ruby
arr = [['a', ['b']], { b: 'bear', c: 'cat' }, 'cab']

arr[0]              # => ["a", ["b"]]
arr[0][1][0]        # => "b"
arr[1]              # => { :b => "bear", :c => "cat" }
arr[1][:b]          # => "bear"
arr[1][:b][0]       # => "b"
arr[2][2]           # => "b"
```

#### variable refernce for nested collections

```ruby
a = [1, 3]
b = [2]
arr = [a, b]
arr # => [[1, 3], [2]]

a[1] = 5
arr # => [[1, 5], [2]]
```
- the value of `arr` changed because `a` still points to the same `Array` object that is in `arr`
```ruby
arr[0][1] = 8
arr # => [[1, 8], [2]]
a   # => [1, 8]
```
- `a` and `arr[0]` are two ways of referencing the same object

#### shallow copy

- ruby has two methods that copy an object: `dup` and `clone`
- both of these create a shallow copy of the object, meaning that only the object that the method is called on is copied
- if the object contains other objects, then those objects will be shared not copied
```ruby
arr1 = ["a", "b", "c"]
arr2 = arr1.dup
arr2[1].upcase!

arr2 # => ["a", "B", "c"]
arr1 # => ["a", "B", "c"]
```
```ruby
arr1 = ["abc", "def"]
arr2 = arr1.clone
arr2[0].reverse!

arr2 # => ["cba", "def"]
arr1 # => ["cba", "def"]
```
- the objects within the array are shared
```ruby
arr1 = ["a", "b", "c"]
arr2 = arr1.dup
arr2.map! do |char|
  char.upcase
end

arr1 # => ["a", "b", "c"]
arr2 # => ["A", "B", "C"]
```
- we replace each element of `arr2` with a new value
- since we are changing the array, not the elements within it, `arr1` is unchanged
```ruby
arr1 = ["a", "b", "c"]
arr2 = arr1.dup
arr2.each do |char|
  char.upcase!
end

arr1 # => ["A", "B", "C"]
arr2 # => ["A", "B", "C"]
```
- we call the destructive `String#upcase!` on each element of `arr2`
- every element of `arr2` is a reference to the object referenced by the corresponding element in `arr1`

#### freezing objects

- the main difference between `dup` and `clone` is that `clone` preserves the frozen state of the object
```ruby
arr1 = ["a", "b", "c"].freeze
arr2 = arr1.clone
arr2 << "d"
# => RuntimeError: can't modify frozen Array
```
- `dup` doesn't preserve the frozen state of the object
```ruby
arr1 = ["a", "b", "c"].freeze
arr2 = arr1.dup
arr2 << "d"

arr2 # => ["a", "b", "c", "d"]
arr1 # => ["a", "b", "c"]
```
- in ruby, objects can be frozen to prevent them from being modified
```ruby
str = "abc".freeze
str << "d"
# => RuntimeError: can't modify frozen String
```
- only mutable objects can be frozen because immutable objects are already frozen
```ruby
5.frozen? # => true
```
- `freeze` only freezes the object it's called on
- if the object it's called on contains other objects those objects won'e be frozen
```ruby
arr = [[1], [2], [3]].freeze
arr[2] << 4
arr # => [[1], [2], [3, 4]]
```
- this also applies to strings within an array
```ruby
arr = ["a", "b", "c"].freeze
arr[2] << "d"
arr # => ["a", "b", "cd"]
```

#### deep copy

- in ruby, there's no easy way to create a deep copy or deep freeze objects within objects

=============================================================================

## **Working with Blocks**

#### example 1

```ruby
[[1, 2], [3, 4]].each do |arr|
  puts arr.first
end
# 1
# 3
# => [[1, 2], [3, 4]]
```
- when evaluating code like this, ask these questions:
1. what is the type of action being performed (method call, block, conditional, etc.)?
2. what is the objec that that action is being performed on?
3. what is the side-effect of that action (output, destructive action, etc.)?
4. what is the return value of that action?
5. is the return value used by whatever instigated the action?

#### example 2

```ruby
[[1, 2], [3, 4]].map do |arr|
  puts arr.first
end
# 1
# 3
# => [nil, nil]
```

#### example 3

```ruby
[[1, 2], [3, 4]].map do |arr|
  puts arr.first
  arr.first
end
# 1
# 3
# => [1, 3]
```

#### example 4

```ruby
my_arr = [[18, 7], [3, 12]].each do |arr|
  arr.each do |num|
    if num > 5
      puts num
    end
  end
end
# 18
# 7
# 12
# => [[18, 7], [3, 12]]
```

#### example 5

```ruby
[[1, 2], [3, 4]].map do |arr|
  arr.map do |num|
    num * 2
  end
end
# => [[2, 4], [6, 8]]
```

#### example 6

```ruby
[{ a: 'ant', b: 'elephant' }, { c: 'cat' }].select do |hash|
  hash.all? do |key, value|
    value[0] == key.to_s
  end
end
# => [{ :c => "cat" }]
```

#### example 7

- sorting nested data structures can be tricky
```ruby
arr = [['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15'], ['1', '8', '9']]
```
- to sort such an array two sets or comparisons are happening:
1. each of the inner arrays is compared with the other inner arrays
2. the way the arrays are compared is by comparing the elements within them
- because the elements in the arrays are strings, it is ultimately string order which will determine array order
```ruby
arr.sort # => [["1", "8", "11"], ["1", "8", "9"], ["2", "12", "15"], ["2", "6", "13"]]
```
- strings are compared character by character, so `sort` doesn't give a numerical comparison
```ruby
arr.sort_by do |sub_arr|
  sub_arr.map do |num|
    num.to_i
  end
end
# => [["1", "8", "9"], ["1", "8", "11"], ["2", "6", "13"], ["2", "12", "15"]]
```

#### example 8


