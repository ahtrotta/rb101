=begin
def factors(number)
  divisor = number
  factors = []
  begin
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end until divisor == 0
  factors
=end

def factors(number)
  (1..number).select { |num| number % num == 0 }
end

puts factors(10) == [1, 2, 5, 10]
puts factors(12) == [1, 2, 3, 4, 6, 12]
p factors(0)
p factors(-10)
puts "#{45}: #{factors(45)}"
