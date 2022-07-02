require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(arr)
    @arr = arr.sort.uniq
    @root = build_tree(@arr, 0, @arr.length - 1)
  end

  def build_tree(arr, start, ending)
    return nil if start > ending

    mid = (start + ending) / 2
    node = Node.new(arr[mid])

    node.left = build_tree(arr, start, mid - 1)
    node.right = build_tree(arr, mid + 1, ending)

    node
  end

  # visually display binary search tree in current state
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, root)
    return if @arr.include?(value)
    return Node.new(value) if root.nil?

    root.data < value ? root.right = insert(value, root.right) : root.left = insert(value, root.left)

    root
  end

  # find the node with the smallest value
  def minValueNode(node)
    current = node

    current = current.left until current.left.nil?
    current
  end

  def delete(value, root)
    return root if root.nil?

    if value < root.data
      root.left = delete(value, root.left)
    elsif value > root.data
      root.right = delete(value, root.right)
    else

      if root.left.nil?
        temp = root.right
        root = nil
        return temp
      elsif root.right.nil?
        temp = root.left
        root = nil
        return temp
      end

      temp = minValueNode(root.right)
      root.data = temp.data
      root.right = delete(temp.data, root.right)
    end
    root
  end

  # returns true if specific node is found in binary tree
  def find(value)
    queue = [@root]
    until queue.empty?
      check_node = queue.shift
      return true if check_node == value

      queue << check_node.left unless check_node.left.nil?
      queue << check_node.right unless check_node.right.nil?
    end

    false
  end

  # returns specific node if node equals argument passed
  def find_for_measure(value)
    queue = [@root]
    until queue.empty?
      check_node = queue.shift
      return check_node if check_node == value

      queue << check_node.left unless check_node.left.nil?
      queue << check_node.right unless check_node.right.nil?
    end

    false
  end

  # conduct a breadth first search traversal
  def level_order(arr = [], &block)
    queue = [@root]
    until queue.empty?
      check_node = queue.shift
      if block_given?
        block.call(check_node)
      else
        arr << check_node
      end

      queue << check_node.left unless check_node.left.nil?
      queue << check_node.right unless check_node.right.nil?
    end
  end

  # inorder depth first search traversal
  def inorder(root = @root, arr = [], &block)
    return if root.nil?

    if block_given?
      inorder(root.left, &block)
      block.call(root)
      inorder(root.right, &block)
    else
      arr << root
    end
  end

  # preorder depth first search traversal
  def preorder(root = @root, arr = [], &block)
    return if root.nil?

    if block_given?
      block.call(root)
      preorder(root.left, &block)
      preorder(root.right, &block)
    else
      arr << root
    end
  end

  # postorder depth first search traversal
  def postorder(root = @root, arr = [], &block)
    return if root.nil?

    if block_given?
      postorder(root.left, &block)
      postorder(root.right, &block)
      block.call(root)
    else
      arr << root
    end
  end

  # return the height of a given node (measured from furthest leaf node in tree)
  def height(root, height = 0)
    return height - 1 if root.nil?
    return 'Number not in tree' if root == false

    height += 1

    [height(root.left, height), height(root.right, height)].max
  end

  # return the depth of a given node (measured from root node of tree)
  def depth(node, level = 0, check_node = nil)
    return 0 if node == @root
    return 'Number not in tree' if node == false

    queue = [@root]
    arr = []

    until check_node == node
      check_node = queue.shift
      return level if check_node == node

      arr << check_node.left unless check_node.left.nil?
      arr << check_node.right unless check_node.right.nil?

      next unless queue.empty?

      level += 1

      arr.each do |node_element|
        queue << node_element
      end
    end
  end

  def balanced?
    return false if height(@root.left) - height(@root.right) > 1
    return false if height(@root.right) - height(@root.left) > 1

    true
  end

  def rebalance(arr = [])
    inorder { |node| arr << node.data }
    @root = build_tree(arr, 0, arr.length - 1)
  end
end
