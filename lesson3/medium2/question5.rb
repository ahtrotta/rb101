def add_rutabaga!(a_string_param, an_array_param)
  a_string_param << 'rutabaga'
  an_array_param << 'rutabaga'
end

# launch school answer

def not_so_tricky_method(a_string_param, an_array_param)
  a_string_param += 'rutabaga'
  an_array_param += ['rutabaga']

  return a_string_param, an_array_param
end

