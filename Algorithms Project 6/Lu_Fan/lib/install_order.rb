# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to
require 'byebug'
require_relative 'graph'
require_relative 'topological_sort'


def install_order(arr)
  max_id = arr.flatten.max
  graph = []
  hash = Hash.new
  (1..max_id).each do |el|
    vertex = Vertex.new(el)
    hash[el] = vertex
    graph.push(vertex)
  end
  arr.each do |tuple|
    Edge.new(hash[tuple[1]], hash[tuple[0]])
  end
  topological_sort(graph).map(&:value)
end

# arr = [[3,1], [2,1], [6, 5], [3, 6], [3, 2], [4, 3], [9,1], [1, nil], [5, nil]]

def install_order2(arr)
  hash = Hash.new
  max = 0
  arr.each do |tuple|
    hash[tuple[0]] = Vertex.new(tuple[0]) unless hash[tuple[0]]
    unless tuple[1].nil?
      hash[tuple[1]] = Vertex.new(tuple[1]) unless hash[tuple[1]]
      Edge.new(hash[tuple[1]], hash[tuple[0]])
    end
  end

  topological_sort(hash.values).map(&:value)

end
