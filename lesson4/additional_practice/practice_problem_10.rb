munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

=begin
munsters.each do |name, hash|
  hash['age_group'] = 'kid' if hash['age'] < 18
  hash['age_group'] = 'adult' if hash['age'] >= 18 && hash['age'] < 65
  hash['age_group'] = 'senior' if hash['age'] >= 65
=end

munsters.each do |name, hash|
  case hash['age']
  when 0..17    then hash['age_group'] = 'kid'
  when 18..64   then hash['age_group'] = 'adult'
  else               hash['age_group'] = 'senior'
  end
end

p munsters
