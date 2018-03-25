class MaxIntSet
  def initialize(max)
    @store = Array.new(max)
  end

  def insert(num)
    raise 'Out of bounds' unless is_valid?(num)
    @store[num] = num
  end

  def remove(num)
    raise 'Out of bounds' unless is_valid?(num)
    @store[num] = nil
  end

  def include?(num)
    @store[num] == num
  end

  private

  def is_valid?(num)
    if num <= @store.length && num >= 0
      return true
    end
    false
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return false if include?(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if include?(num)
    if @count == num_buckets
      resize!
    end
    self[num] << num
    @count += 1
  end

  def remove(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2){Array.new}
    old_store.flatten.each do |el|
      insert(el)
    end
  end
end
