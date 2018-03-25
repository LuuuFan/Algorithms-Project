require 'byebug'

class DynamicProgramming

  def initialize
    @blair_cache = {1=>1, 2=>2}
    @frog_cache = {
      1=>[[1]],
      2=>[[1,1], [2]],
      3=>[[1,1,1], [2,1], [1,2], [3]]
    }
    @maze_cache = []
  end

  def blair_nums(n)
    return @blair_cache[n] unless @blair_cache[n].nil?
    ans = blair_nums(n - 1) + blair_nums(n - 2) + 2 * (n - 1) - 1
    @blair_cache[n] = ans
    return ans
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    cache[n]
  end

  def frog_cache_builder(n)
    cache = {
      1=>[[1]],
      2=>[[1,1], [2]],
      3=>[[1,1,1], [2,1], [1,2], [3]]
    }
    return cache if n < 3
    (4..n).each do |i|
      s1 = cache[i - 1].map { |el| el.dup << 1}
      s2 = cache[i - 2].map { |el| el.dup << 2}
      s3 = cache[i - 3].map { |el| el.dup << 3}
      cache[i] = s1 + s2 + s3
    end
    cache
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] unless @frog_cache[n].nil?
    s1 = frog_hops_top_down_helper(n - 1).map { |el| el.dup << 1}
    s2 = frog_hops_top_down_helper(n - 2).map { |el| el.dup << 2}
    s3 = frog_hops_top_down_helper(n - 3).map { |el| el.dup << 3}
    @frog_cache[n] = s1 + s2 + s3
    @frog_cache[n]
  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)
    knapsack_table(weights, values, capacity).last.last
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    table = Array.new(capacity + 1){Array.new}
    table[0] = Array.new(weights.length){0}
    return table if capacity == 0
    (1..capacity).each_with_index do |total_wt, t_idx|
      arr = weights.map.with_index do |wt, idx|
        pre_val = table[t_idx][idx - 1].nil? ? 0 : table[t_idx][idx - 1]
        current_val = values[idx] * (total_wt / wt) + pre_val
        [pre_val, current_val].max
      end
      table.push(arr)
    end
    table
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
