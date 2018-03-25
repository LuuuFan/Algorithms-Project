def is_shuffle?(str1, str2, str3)
  str1p = 0
  str2p = 0
  str3.each_char do |char|
    if str1[str1p] == char
      str1p += 1
    elsif str2[str2p] == char
      str2p += 1
    else
      return false
    end
  end
  str1p == str1.length && str2p == str2.length
end

def is_shuffle_2?(str1, str2, str3)
  idx1 = 0
  idx2 = 0
  idx3 = 0
  while idx3 < str.length
    if str1[idx1] == str[idx3] && str2[idx2] == str3[idx3]

    end
end
