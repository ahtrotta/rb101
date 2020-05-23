hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

new_arr = []
hsh.each do |_, sub_hsh|
  if sub_hsh[:type] == 'fruit'
    new_arr << sub_hsh[:colors].map { |word| word.capitalize }
  elsif sub_hsh[:type] == 'vegetable'
    new_arr << sub_hsh[:size].upcase
  end
end

p new_arr
