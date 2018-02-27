require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @start_idx = 0
  end

  # O(1)
  def [](index)
    if index >= @length
      raise 'index out of bounds'
    end
    @store[index + @start_idx]
  end

  # O(1)
  def []=(index, val)
    if index > @length
      self.resize!
      @store[index] = val
    else
      @store[(index + start_idx) % @capacity] = val
    end
  end

  # O(1)
  def pop
    if @length == 0
      raise "index out of bounds"
    else
      result = @store[@length - 1 + @start_idx]
      @store[@length - 1  + @start_idx] = nil
      @length -= 1
    end
    result
  end

  # O(1) ammortized
  def push(val)
    if @length == @capacity
      self.resize!
    end
    @store[@length + @start_idx] = val
    @length += 1
  end

  # O(1)
  def shift
    if @length == 0
      raise "index out of bounds"
    else
      result = @store[@start_idx]
      @store[@start_idx] = nil
      @start_idx += 1
      @length -= 1
    end
    result
  end

  # O(1) ammortized
  def unshift(val)
    if @length == @capacity
      self.resize!
    end
    @store[@start_idx - 1] = val
    @start_idx -= 1
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)

  end

  def resize!
    newStore = StaticArray.new(@capacity * 2)
    @length.times do |i|
      newStore[i] = @store[@start_idx + i]
    end
    @capacity *= 2
    @start_idx = 0
    @store = newStore
  end
end
