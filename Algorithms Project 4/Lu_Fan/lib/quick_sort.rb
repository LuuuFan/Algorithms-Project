require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array.shift
    left = []
    right = []
    array.each do |el|
      if pivot >= el
        left << el
      else
        right << el
      end
    end
    sort1(left).concat([pivot]).concat(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    prc ||= Proc.new {|x, y| x <=> y}
    pivot_idx = QuickSort.partition(array, start, length, &prc)
    # left = pivot_idx - start
    # right = length - pivot_idx - 1
    QuickSort.sort2!(array, start, pivot_idx - start, &prc)
    QuickSort.sort2!(array, pivot_idx + 1, length - pivot_idx - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    return start if length == 1
    prc ||= Proc.new {|x, y| x <=> y}
    pivot_idx = start
    (start + 1).upto(start + length - 1) do |idx|
      if prc.call(array[start], array[idx]) == 1
        array[pivot_idx + 1], array[idx] = array[idx], array[pivot_idx + 1]
        pivot_idx += 1
      end
    end
    array[start], array[pivot_idx] = array[pivot_idx], array[start]
    pivot_idx
end

class Array
  def selection(k)
    left = 0
    right = self.length - 1
    while true
      return self[left] if left == right
      pivot_idx = QuickSort.partition(self, left, right-left+1)
      if k - 1 == pivot_idx
        return self[k - 1]
      elsif k - 1 < pivot_idx
        right = pivot_idx - 1
      else
        left = pivot_idx + 1
      end
    end
  end

end
