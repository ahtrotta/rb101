
def joinor(arr, delim=', ', word='or')
  if arr.size > 1
    arr[-1] = "#{word} #{arr[-1]}"
    if arr.size > 2
      arr.join(delim)
    else
      arr.join(' ')
    end
  elsif arr.size == 1
    arr.to_s
  end
end

p joinor([1, 2]) == '1 or 2'
p joinor([1, 2, 3]) == '1, 2, or 3'
p joinor([1, 2, 3], '; ') == '1; 2; or 3'
p joinor([1, 2, 3], ', ', 'and') == '1, 2, and 3'
p joinor([1, 2, 3, 4, 5, 6, 7, 8, 9])
