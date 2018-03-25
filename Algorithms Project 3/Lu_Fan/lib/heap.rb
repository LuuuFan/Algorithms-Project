class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = Array.new()
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    extract_el = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, &@prc)
    extract_el
  end

  def peek
    @store.first
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count - 1, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    arr = []
    child_one = parent_index * 2 + 1
    child_two = parent_index * 2 + 2
    if child_one && child_one < len
      arr << child_one
    end
    if child_two && child_two < len
      arr << child_two
    end
    arr
  end

  def self.parent_index(child_index)
    if child_index == 0
      raise 'root has no parent'
    end
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1<=>el2 }
    children = child_indices(len, parent_idx).map{|idx| array[idx]}
    min_child = children[0]
    if children.length > 1 && prc.call(children) > 0
      min_child = children[1]
    end
    child_idx = array.index(min_child)
    return array if min_child.nil? || prc.call(array[parent_idx], array[child_idx]) <= 0
    array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    heapify_down(array, child_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1<=>el2 }
    return array if child_idx == 0
    parent_idx = parent_index(child_idx)
    return array if prc.call(array[parent_idx], array[child_idx]) <= 0
    array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    heapify_up(array, parent_idx, len, &prc)
  end
end
