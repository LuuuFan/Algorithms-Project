require_relative 'graph'
require 'byebug'
# Implementing topological sort using both Khan's and Tarian's algorithms


# Kahn's Algorithm
def topological_sort(vertices)
  sorted = []
  top = []
  vertices.each do |vertex|
    if vertex.in_edges.empty?
      top.push(vertex)
    end
  end
  until top.empty?
    current = top.pop
    sorted.push(current)
    current.out_edges.each do |edge|
      if (edge.to_vertex.in_edges - [edge]).empty?
        top.push(edge.to_vertex)
      end
    end
    current.out_edges.each do |edge|
      edge.destroy!
    end
    # vertices.delete(current)
  end
  sorted.length == vertices.length ? sorted : []
end



# Tarjan's Algorithm
# def topological_sort(vertices)
#   sorted = []
#   visited = Hash.new { false }
#   vertices.each {|vertex| visited[vertex] = false}
#   visited.each do |vertex, value|
#     visit(vertex, visited, sorted)
#   end
#   sorted
#   # sorted.length == vertices.length ? sorted : []
# end
#
# def visit(vertex, visited, sorted)
#   if !visited[vertex]
#     vertex.out_edges.each do |edge|
#       # p edge.to_vertex.value
#       visit(edge.to_vertex, visited, sorted)
#     end
#     visited[vertex] = true
#     sorted.unshift(vertex)
#   end
# end
