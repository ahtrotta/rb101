ages = { 'Herman' => 32, 'Lily' => 30, 'Grandpa' => 5843, 'Eddie' => 10, 'Marilyn' => 22, 'Spot' => 237 }

minimum_age = 
ages.each { |_, age| minimum_age[0] = age if age < minimum_age[0] }

puts minimum_age
