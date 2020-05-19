flintstones = %w(Fred Barney Wilma Betty Pebbles BamBam)

hash = {}
flintstones.each_with_index do |name, i|
  hash[name] = i
end

p hash

counter = 0
new_hsh = flintstones.each_with_object({}) do |name, hsh|
  hsh[name] = counter
  counter += 1
end

p new_hsh
