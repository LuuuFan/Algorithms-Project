# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative "bst_node"

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    node = BSTNode.new(value)
    if @root.nil?
      @root = node
    else
      append_child(@root, node)
    end
  end

  def find(value, tree_node = @root)
    return tree_node if tree_node.value == value
    if tree_node.value >= value
      return nil if tree_node.left.nil?
      find(value, tree_node.left)
    else
      return nil if tree_node.right.nil?
      find(value, tree_node.right)
    end
  end

  def delete(value)
    return @root = nil if @root.value == value
    node = find(value)
    if node
      parent_node = find_parent(value)
      if node.left.nil? && node.right.nil?
        if parent_node.left && parent_node.left.value == value
          parent_node.left = nil
        else
          parent_node.right = nil
        end
      elsif node.left.nil?
        if parent_node.left && parent_node.left.value == value
          parent_node.left = node.right
        else
          parent_node.right = node.right
        end
      else
        max_node = maximum(node.left)
        # p '---max_node value is ---'
        # p max_node.value
        delete(max_node.value)
        if parent_node.left && parent_node.left.value == value
          parent_node.left = max_node
        else
          parent_node.right = max_node
        end
      end
    else
      raise 'no this value in the tree'
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right.nil?
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return 0 if tree_node.nil? || (tree_node.left.nil? && tree_node.right.nil?)
    left  = tree_node.left
    right = tree_node.right
    d = 1
    left_d = depth(left)
    right_d = depth(right)
    if left_d >= right_d
      d += left_d
    else
      d += right_d
    end
    d
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil? || (tree_node.left.nil? && tree_node.right.nil?)
    left_d = depth(tree_node.left)
    right_d = depth(tree_node.right)
    if (left_d - right_d) <= 1
      is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
    else
      false
    end
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return arr if tree_node.nil?
    return [tree_node.value] if tree_node.left.nil? && tree_node.right.nil?
    in_order_traversal(tree_node.left)
      .concat([tree_node.value])
      .concat(in_order_traversal(tree_node.right))
  end


  private
  # optional helper methods go here:
  def append_child(parent_node, child_node)
    if parent_node.value >= child_node.value && parent_node.left.nil?
      parent_node.left = child_node
    elsif parent_node.value >= child_node.value
      append_child(parent_node.left, child_node)
    elsif parent_node.value < child_node.value && parent_node.right.nil?
      parent_node.right = child_node
    else
      append_child(parent_node.right, child_node)
    end
  end

  def find_parent(value, tree_node = @root)
    if (tree_node.left && tree_node.left.value == value) ||
      (tree_node.right && tree_node.right.value == value)
      return tree_node
    elsif tree_node.value >= value
      find_parent(value, tree_node.left)
    else
      find_parent(value, tree_node.right)
    end
  end

end
