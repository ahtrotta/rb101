arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

new_arr =  arr.map do |hsh|
  new_hsh = {}
  hsh.each { |key, value| new_hsh[key] = value + 1 }
  new_hsh
end

p new_arr
