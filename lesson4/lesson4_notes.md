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
