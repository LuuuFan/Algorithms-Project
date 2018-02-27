require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(0)
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
    @store = @store.slice(0, @length - 1)
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    @length += 1
    @store = StaticArray.new(@length)
    @store[@length] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    (0..@length-1).each do |idx|
      @store[idx] = @store[idx + 1]
    end
    @store = @store.slice(0, @length - 1)
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
  end
end
