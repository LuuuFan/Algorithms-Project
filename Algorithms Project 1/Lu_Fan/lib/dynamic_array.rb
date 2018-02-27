require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
  end

  # O(1)
  def [](index)
    if index >= @length
      raise 'index out of bounds'
    else
      @store[index]
    end
  end

  # O(1)
  def []=(index, value)
    if index == @length
      @store = @store + [value]
      @length += 1
    elsif index > @length
      newStore = StaticArray.new(index - @length + 1)
      newStore[index - @length] = value
      @store = @store + newStore
      @length = index + 1
    else
      @store[index] = value
    end
  end

  # O(1)
  def pop
    if @length == 0
      raise "index out of bounds"
    else
      @store[@length - 1] = nil
      @length -= 1
    end
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length == @capacity
      self.resize!
    end
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    if @length == 0
      raise "index out of bounds"
    else
      newStore = StaticArray.new(@length - 1)
      (0..@length-1).each do |idx|
        newStore[idx] = @store[idx + 1]
      end
      @store = newStore
      @length -= 1
    end
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    newStore = StaticArray.new(@length + 1)
    newStore[0] = val
    (0..@length - 1).each do |idx|
      newStore[idx + 1] = @store[idx]
    end
    @store = newStore
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity = @capacity * 2
    newStore = StaticArray.new(@capacity)
    (0..@length-1).each do |idx|
      newStore[idx] = @store[idx]
    end
    @store = newStore
  end
end
