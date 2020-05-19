flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles Bert)

name_index = 0
flintstones.each_with_index do |name, idx|
  if name[0..1] == 'Be'
    name_index = idx
    break
  end
end

p name_index

# launch school solution
#
# flintstones.index { |name| name[0, 2] == 'Be' }
