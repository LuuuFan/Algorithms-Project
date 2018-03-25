require_relative 'heap'

def k_largest_elements(array, k)
  prc = Proc.new { |el1, el2| -1 * (el1 <=> el2) }
  heap = BinaryMinHeap.new(&prc)
  length = array.length
  length.times do
    heap.push(array.shift)
  end
  k.times do
    array << heap.extract
  end
  array
end
