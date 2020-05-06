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
code here
```
2. a method that takes an array of strings and returns a string that is all those strings concatenated together
3. a method that takes an array of integers and returns a new array with every other element

============================================================================= 

