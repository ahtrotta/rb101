HEX_CHARS = ('a'..'f').to_a + ('0'..'9').to_a

def make_uuid
  [8, 4, 4, 4, 12].map do |num|
    str = ''
    num.times { str << HEX_CHARS.sample }
    str
  end.join('-')
end

p make_uuid
