=begin

*** Understand the Problem ***

problem: Build a loan calculator. You'll need three pieces of information: 1) loan amount, 2) Annual Percentage Rate (APR), 3) loan duration. Calculate: 1) monthly interest rate, 2) loan duration in months, 3) monthly payment.

formula: m = p * (j / (1 - (1 + j)**(-n))) where m = monthly payment, p = loan amount, j = monthly interest rate, and n = loan duration in months

input(s): 1) loan amount
          2) annual percentage rate (APR)
          3) loan duration

output(s): 1) monthly interest rate
           2) loan duration (months)
           3) monthly payment

problem domain (required knowledge): formula for monthyl payment (provided), formula to convert APR to monthly interest rate

clarifying question(s): what format should user input apr? what format for loan duration input? 

mental model: get input from user, validate input, store in variables, output calculated results


=============================================================================

*** Examples / Test Cases / Edge Cases ***

provided example(s): N/A

test cases:

edge cases:

'bad' input: non-numeric strings

=============================================================================

*** Data Structure(s) ***

data structure(s): floats or integers


=============================================================================

*** Algorithm ***

algorithm: 
  - get loan amount from user
    - validate that it's a valid number
  - get apr from user as a float (0.05 for 5% apr)
    - validate that it's a float between 0 and 1
  - get loan duration 
    - validate that it's a float or integer greater than 0
    - validate that the duration * 12 equals an integer 
  - calculate loan duration in months and store in variable
  - calculate monthly interest rate
  - calculate monthly payment and display to user

=end

def prompt(message)
  # add prompt arrow to all messages
  puts ">> #{message}"
end

def valid_loan_amount?(num)
  # validate that it's a valid number greater than 0
  num.to_f > 0.0
end

def valid_apr?(num)
  # validate that number is between 0 and 1
  if num.to_f != 0.0
    num.to_f > 0.0 && num.to_f <= 1.0
  else
    %w(0 00 000 0000 0.0 0. .0).include?(num)
  end
end

def valid_duration?(num)
  # validate that the number is greater than zero
  # and equates to an integer value number of months
  num.to_f > 0.0 && (num.to_f * 12).floor == (num.to_f * 12).to_i
end

prompt('Welcome to Loan Calculator!')

loan_amount = nil
loop do
  prompt('Please enter loan amount:')
  loan_amount = gets.chomp
  break if valid_loan_amount?(loan_amount)
  prompt('Invalid amount. Please try again.') 
end

apr = nil
loop do
  prompt('Please enter APR (enter a number between 0 and 1):')
  apr = gets.chomp
  break if valid_apr?(apr)
  prompt('Invalid APR. Please try again.')
end

duration = nil
loop do
  prompt('Please enter loan duration (in years):')
  duration = gets.chomp
  break if valid_duration?(duration)
  prompt('Invalid duration. Please try again.')
end

# monthly interest rate
j = apr / 12

# loan duration in months
n = duration * 12

monthly_payment = loan_amount * (j / (1 - (1 + j)**(-n)))

prompt("Your monthly payment is $#{monthly_payment}.") 
