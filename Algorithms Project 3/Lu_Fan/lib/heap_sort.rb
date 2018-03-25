require_relative "heap"

class Array
  def heap_sort!
    # prc = Proc.new { |el1, el2| (el1 <=> el2) }
    heap = BinaryMinHeap.new
    # (&prc)
    length = self.length
    length.times do
      heap.push(self.shift)
      # p heap.store
    end
    length.times do
      self << heap.extract
    end
    self
  end
end
