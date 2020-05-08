def number?(num)
  if num.include?('.')
    if num[0] == '.'
      num.to_f.to_s == '0' + num
    elsif num[-1] == '.'
      num.to_f.to_s == num + '0'
    else
      num.to_f.to_s == num
    end
  else
    num.to_i.to_s == num
  end
end

loop do
  puts "=> Enter number:"
  number = gets.chomp

  puts "=> Number returns #{number?(number)}"
end

