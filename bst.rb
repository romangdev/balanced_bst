class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    @data <=> other
  end
end

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

  def minValueNode(node)
    current = node

    until current.left.nil?
      current = current.left
    end
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
end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
bst = Tree.new(array)

bst.insert(60, bst.root)
bst.delete(4, bst.root)
bst.pretty_print
# puts bst.find(2)
# bst.level_order
bst.postorder {|node| puts node.data * 2}