
def preorder(tree_node, arr=[])
  return arr if tree_node.nil?
  return arr.push(tree_node) if tree_node.left.nil? && tree_node.right.nil?
  arr.push(tree_node)
  arr.concat(preoder(tree_node.left, arr)).concat(preorder.right, arr)
end

def postorder(tree_node, arr=[])
  return arr if tree_node.nil?
  return arr.push(tree_node) if tree_node.left.nil? && tree_node.right.nil?
  postorder(tree_node.left, arr).concat(postorder(tree_node.right, arr)).concat([tree_node])
end
