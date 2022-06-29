class Node
  def initialize
    @data = nil
    @left_children = nil
    @right_children = nil
  end
end

class Tree
  def initialize(arr)
    @arr = arr
    @root = nil
  end

  def build_tree(arr = @arr)
    arr = arr.sort
    arr = arr.uniq
    print arr
  end
end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
bst = Tree.new(array)
bst.build_tree