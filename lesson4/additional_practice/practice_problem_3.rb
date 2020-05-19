ages = { 'Herman' => 32, 'Lily' => 30, 'Grandpa' => 402, 'Eddie' => 10 }

under_100 = ages.select { |_, age| age < 100 }
puts under_100
