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
j = apr.to_f / 12

# loan duration in months
n = duration.to_f * 12

monthly_payment = loan_amount.to_f * (j / (1 - (1 + j)**(-n)))

prompt("Your monthly payment is $#{monthly_payment.round(2)}.")
