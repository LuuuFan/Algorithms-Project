def truck(num)
  distance = 0
  num.downto(1).each do |truck|
    distance += 100 / truck.to_f
  end
  distance
end
