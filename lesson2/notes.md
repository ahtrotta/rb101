# ** LESSON 2 NOTES **

=============================================================================

## **Ruby Style**

1. Set editor's tab function to 2 spaces, indenting should use spaces.
2. Use `#` at the beginnig of a line for comments.
3. For methods, variables, or files, use `snake_case` formatting.
4. Use constants for values that will not change in your Ruby program. Define them with all uppercase letters.
```ruby
# Constant declaration

FOUR = 'four'
FIVE = 5
```
5. Use `{}` instead of `do...end` if the expression fits on one line.
6. Use `CamelCase` formatting when declaring a class name.

=============================================================================

## **Lecture: Kickoff**

- build fluency in syntax
- learn to think like a programmer
- learn to build applications
- debugging mindset

#### 3 main buckets

1. learning to program procedurally
2. object-oriented programming
3. other stuff
   1. testing
   2. blocks
   3. tools
   4. problem solving

#### learning to code vs learning to program
1. learn grammar and syntax
2. build applications
- frustrating to jump between the two
- pseudo code
```
if total cards > 21
  then I busted
otherwise,
  1 hit or
  I stay
```

#### looking for help
- search using the 'right phrases'
  - use the stack trace
  - reading error messages
  - adding 'ruby'
- stack overflow
- ruby docs
 
#### asking for help
- treat launch school people like coworkers
- push everything to github
- forums
- chatrooms
- TA office hours

#### we're learning application development
- lots of different types of programming
- ruby is the syntax, good for all kinds of programming

=============================================================================

## **A Note on Style**

#### parentheses

- in ruby, the parentheses are optional when you invoke a method
  - can make it difficult to differentiate between method invocations and local variableo

#### puts and gets

- `puts` displays something while `gets` can get input from the user
- these methods can alternatively be called with `Kernel.puts()` or `Kernel.gets()` 

=============================================================================

## **Truthiness** 

- a boolean is an object whose only purpose is to convey whether it is 'true' or 'false'
- in ruby, booleans are represented by the `true` and `false` objects
- like everything else, boolean objects have real classes behind them and you can call methods on `true` and `false`

#### logical operators

- `&&`: this is the 'and' operator, returning `true` only if both expressions are true
  - notice that in `num < 10 && num.odd?` parentheses weren't need around `num < 10`, meaning that `<` has higher precedence than `&&` 
  - it is possible to chain multiple expressions together and it will return `true` unless any expression is `false`
```ruby
num = 5

# this returns true
num < 10 && num.odd? && num > 0

# this returns false
num < 10 && num.odd? && num > 0 && false
```
- `||`: this is the 'or' operator, return `true` if either expression is true
- the `&&` and `||` operators can be short circuited, which means they will stop evaluating expressions once the return value is guaranteed
  - the expression `false && 3/0` will return `false` even though it would return a `ZeroDivisionError` if `3/0` were evaluated
  - in contrast, `false || 3/0` will return `ZeroDivisionError: divided by 0`
  - the expression `true || 3/0` will return `true` because it short circuits

#### truthiness

- ruby considers more than the `true` object to be 'truthy'
- everything is truthy other than `nil` and `false`
- example of an application:
```ruby
if name = find_name
  puts 'got a name'
else
  puts "couldn't find it"
end
```
- presumably, the `find_name` method will either return a valid object or it will return `nil` or `false`
- this is not recommended because it may be misunderstood as equality comparison
- more commonly:
```ruby
name = find_name

if name && name.valid?
  puts 'great name!'
else
  puts "either couldn't find name or it's invalid"
end
```
- the `if` conditional first checks that `name` is not `nil`, then checks the validity of `name`

=============================================================================

## **Walk-through: Calculator**

#### tips and gotchas

1. in a conditional (like an `if` statement) be sure to do equality comparison with `==` as opposed to an assignment with `=`
2. pay attention to what type of object you're comparing against
```ruby
if operator == 1
# vs
if operator == '1'
```
3. understand the concep tof integer division
4. `String#to_i` and `String#to_f` are handy but read the documentation
5. local variables initialized within an `if` statement can be accessed outside of the `if` statement
6. `if` expressions can return a value
```ruby
answer = if true
           'yes'
         else
           'no'
         end
# answer gets the value 'yes'
```

=============================================================================

## **Pseudo-Code**

- when you write code, you're writing it for other programs to process
- when writing ruby, you're writing it for the ruby interpreter to process
- a single syntax error can break the code and prevent proper processing
- pseudo-code is meant for humans
- when you first approach any problem it is important to understand it well
- here is an example of pseudo-code:
```
Given a collection of integers.

Iterate through the collection one by one.
  - save the first value as the starting value.
  - for each iteration, compare the saved value with the current value.
  - if the saved value is greater or if it's the same
    - move to the next value in the collection
  - otherwise, if the current value is greater
    - reassign the saved value as the current value

After iterating through the collection, return the saved value
```
- loading a problem into your brain while working with a programming language is challenging because you are constantly struggling with syntax (probably)
- there are two layers to solving any problem:
1. the logical problem domain layer
2. the syntactical programming language layer
- psuedo-code helps to focus on the logical problem domain layer
- the problem with pseudo-code is that we can't verify its logic

#### formal pseudo-code

keyword | meaning
------- | -------
START | start of the program
SET | sets a variable we can use later
GET | retrieve input from user
PRINT | displays output to user
READ | retrieve value from variable
IF / ELSE IF / ELSE | show conditional branches in logic
WHILE | show looping logic
END | end of the program

- the pseudo-code from above becomes:
```
START

# Given a collection of integers called 'numbers'

SET iterator = 1
SET saved_number = value within numbers collection at space 1

WHILE iterator <= length of numbers
  SET current_number = value within numbers collection at space 'iterator'
  IF saved_number >= current_number
    go to the next iteration
  ELSE 
    saved_number = current_number

  iterator = iterator + 1

PRINT saved_number

END
```
- we still can't verify that the logic is sound

#### translating pseudo-code to program code

```ruby
def find_greatest(numbers)
  saved_number = nil

  numbers.each do |num|
    saved_number ||= num
    if saved_number >= num
      next
    else
      saved_number = num
    end
  end

  saved_number
end
```
- what if `numbers` is `nil`? perhaps a guard clause that returns `nil`: `return if numbers.nil?`
- perhaps `saved_number = numbers.first` before the loop and remove `saved_number ||= num` altogether
- most of the time it will be more difficult than the provided example
- many times you'll discover that a lot of your logic or assumptions in the pseudo-code are incorrect, and you'll need to make changes that will ripple accross the entire program
-practice writing pseudo-code:
1. a method that returns the sum of two integers:
```
get an integer from the user and save to a variable
get another integer from the user and save to a different variable
add the two integers together and save to a new variable
return the sum of the two integers
```
- more formal:
```
START

GET integer1
GET integer2
PRINT integer1 + integer2

END
```
2. a method that takes an array of strings and returns a string that is all those strings concatenated together
3. a method that takes an array of integers and returns a new array with every other element

============================================================================= 

## **Flowchart**

- flowcharts can help visually map out logical sequences
- solving a problem using specific step-by-step logic is called the imperative or procedural way to solve a problem
- in ruby, there is an `each` method for similar problems, and using `each` is the declarative way of solving a problem

#### a larger problem

problem: the user supplies N collections of numbers and we take the largest number out of each collection and display it

high-level pseudo-code:
```
while user wants to keep going
  - ask the user for a collection of numbers
  - extract the largest one from that collection and save it
  - ask the user if they want to input another collection

return saved list of numbers
```
- the line `extract the largest one from that collection` is a sub-process that contains a lot of logic
- declarative syntax states what you want and imperative syntax states how to get it
when problem solving:
1. start at a high level using declarative syntax
2. then use imperative pseudo-code and outline specifics 

=============================================================================

## **Debugging**

- most of the day-to-day life of a programmer is spent stuck on some problem
- the trivial code gets done quickly and then most of the time is spent analyzing and understanding a problem, experimenting or coming up with an approach, or debugging code

#### temperment

- if the key to programming is debugging, then the key to debugging is having a patient and logical temperment

### reading error messages

- when you get an error message you get a stack trace
- be sure to carefully read the stack trace because it has a lot of information in it

#### online resources

1. search engine
  - it's often useful to use a search engine to look up the error message
  - be sure to not include terms that are specific to your computer or program
  - sometimes different languages will use similar names for common errors

2. stack overflow
  - treasure trove!

3. documentation
  - also a good place to look

#### steps to debugging

1. reproduce the error
2. determine the boundaries of the error
  - tweak the data that caused th error
  - do we get expected errors or does a new error occur that sheds light on the underlying problem?
3. trace the code
4. understand the problem well
5. implement a fix
  - fix one problem at a time
6. test the fix

#### techniques for debuggin

1. line by line
  - the best debugging tool is patience
  - most bugs are from overlooking a detail
2. rubber duck
  - use some object (like a rubber duck) as a sounding board for talking through problems
3. walking away
  - this is only effective if you've first spent time loading the problem into your brain
4. using pry
5. using a debugger

=============================================================================

## **Order of Precedence**

- order of precedence is the order in which operators are evaluated

#### diving deeper

```ruby
array = [1, 2, 3]

array.map { |num| num + 1 }  # => [2, 3, 4]
```
It returns `[2, 3, 4]` as expected. But what if `p` is prepended?
```ruby
p array.map { |num| num + 1 }  # outputs [2, 3, 4] to console
                               # => [2, 3, 4]
```
Now switch `{}` block with a `do...end` block
```ruby
array.map do |num|
  num + 1
end
```
Same as last time, prepend with `p`
```ruby
p array.map do |num|
  num + 1
end                   # outputs #<Enumerator: [1, 2, 3]:map>
                      # => #<Enumerator: [1, 2, 3:map>
```
That's odd. We got different output and a different return value.
- blocks have the lowest precedence of all operators, but `{}` is higher than `do...end`
- `array.map`, without the block, gets evaluated first, resolving to an `Enumerator`, which then gets passed into `p` as an argument along with `do...end` as the block
- `p` doesn't take blocks, so the block gets ignored
```ruby
p array.map           # outputs <Enumerator: [1, 2, 3]:map>

p array.map do |num|
  num + 1
end                   # outputs <Enumerator: [1, 2, 3]: map>
```
The code below is equivalent to the code above but it uses parentheses
```ruby
array = [1, 2, 3] 

p(array.map) do |num|
  num + 1                        # <Enumerator: [1, 2, 3]:map>
end                              # => <Enumerator: [1, 2, 3]:map>

p(array.map { |num| num + 1})    # [2, 3, 4]
                                 # => [2, 3, 4]
```

#### ruby's `tap` method

- helpful debugging tool
- `tap` is an Object instance method that passes in the colling object inside a block and returns that same object back
```ruby
mapped_array = array.map { |num| num + 1 }

mapped_array.tap { |value| p value }           # => [2, 3, 4]
```
- anohter use case for `tap` is to debug intermediate objects in method chains
```ruby
(1..10)                  .tap { |x| p x }    # 1..10
  .to_a                  .tap { |x| p x }    # [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  .select {|x| x.even? } .tap { |x| p x }    # [2, 4, 6, 8, 10]
  .map {|x| x*x }        .tap { |x| p x }    # [4, 16, 36, 64, 100]
```

=============================================================================

