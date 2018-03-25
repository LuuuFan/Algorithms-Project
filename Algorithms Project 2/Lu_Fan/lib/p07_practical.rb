require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  oddChars = HashMap.new
  (0..string.length - 1).each do |idx|
    if oddChars.include?(string[idx])
      oddChars.delete(string[idx])
    else
      oddChars.set(string[idx], 1)
    end
  end
  oddChars.count <= 1
end
