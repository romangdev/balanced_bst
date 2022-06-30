class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  # def <=> (other)
  #   @data <=> other.data
  # end
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
end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
bst = Tree.new(array)
bst.pretty_print

bst.insert(60, bst.root)
bst.pretty_print
