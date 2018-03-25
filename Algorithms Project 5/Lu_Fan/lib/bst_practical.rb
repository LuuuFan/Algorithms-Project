require_relative 'binary_search_tree'
require 'byebug'

def kth_largest(tree_node, k)
  arr = post_order_traversal(tree_node)
  arr[k - 1]
end



def post_order_traversal(tree_node, arr=[])
  return arr if tree_node.nil?
  return [tree_node] if tree_node.left.nil? && tree_node.right.nil?
  post_order_traversal(tree_node.right)
    .concat([tree_node])
    .concat(post_order_traversal(tree_node.left))
end
