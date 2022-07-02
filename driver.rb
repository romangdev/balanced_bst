require_relative "node"
require_relative "tree"

# Test methods to see if tree creation and manipulation work as expected
bst = Tree.new(Array.new(15) { rand(1..100) })
print "Balanced?: "
puts bst.balanced?
bst.pretty_print
print "Preorder: "
bst.preorder { |node| print "#{node.data} " }
print "\nInorder: "
bst.inorder { |node| print "#{node.data} " }
print "\nPostorder: "
bst.postorder { |node| print "#{node.data} " }
puts "\n"
bst.insert(101, bst.root)
bst.insert(102, bst.root)
bst.insert(103, bst.root)
bst.pretty_print
print "Balanced?: "
puts bst.balanced?
bst.rebalance
bst.pretty_print
print "Balanced?: "
puts bst.balanced? 
print "Level order: "
bst.level_order { |node| print "#{node.data} " }
print "\nPreorder: "
bst.preorder { |node| print "#{node.data} " }
print "\nInorder: "
bst.inorder { |node| print "#{node.data} " }
print "\nPostorder: "
bst.postorder { |node| print "#{node.data} " }
puts "\n"