class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return self.class.hash if empty?
    self.map.with_index do |el, idx|
      el.object_id.hash + idx.hash
    end.reduce(:-)
  end
end

class String
  def hash
    self.unpack("n")[0].hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    return 0 if keys.empty?
    keys.map do |el|
      el.object_id.hash
    end.reduce(:+)
  end
end
