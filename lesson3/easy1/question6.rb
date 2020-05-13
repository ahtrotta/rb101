famous_words = "seven years ago..."
famous_words = famous_words.split.insert(0, "Four score and").join(' ')
puts famous_words

famous_words = "seven years ago..."
famous_words = "Four score and " + famous_words
puts famous_words

famous_words = "seven years ago..."
famous_words = "Four score and " << famous_words
puts famous_words
