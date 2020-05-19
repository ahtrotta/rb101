words = 'the flintstones rock'

def titleize(str)
  str.split.map { |word| word.capitalize }.join(' ')
end

puts words
puts titleize(words)
