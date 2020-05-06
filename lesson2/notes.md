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


