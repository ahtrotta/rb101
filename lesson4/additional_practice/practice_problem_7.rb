statement = 'The Flinstones Rock'

letters = statement.chars.each_with_object(Hash.new(0)) { |c, hsh| hsh[c] += 1 }
p letters

# launch school solution
#
# result = {}
# letters = ('A'..'Z').to_a + ('a'..'z').to_a
# letters.each do |letter|
#   letter_frequency = statement.scan(letter).count
#   result[letter] = letter_frequency if letter_frequency > 0
# end
