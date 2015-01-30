class BinaryTree

    def initialize(root = nil)
        @root = root    
    end
    
    def build_tree(a)
        return nil unless a.is_a?(Array) && !a.empty?
        
        #shuffle the data to avoid a tree that is already sorted
        data = a.shuffle

        @root = Node.new(data.shift)
        
        until data.empty? do
            add_node(data.shift)
        end
    end
   
    def add_node(v)
        node = Node.new(v)
        current = @root
        node_placed = false
        
        until node_placed do
            if node.value < current.value
                if current.lchild
                    current = current.lchild 
                else
                    current.lchild = node
                    node.parent = current
                    node_placed = true
                end
            else
                if current.rchild
                    current = current.rchild 
                else
                    current.rchild = node
                    node.parent = current
                    node_placed = true
                end
            end
        end
    end
   
    def breadth_first_search(v)
        queue = [@root]
        
        until queue.empty? do
            current = queue.shift
            return current if current.value == v
            queue << current.lchild if current.lchild
            queue << current.rchild if current.rchild
        end
        nil
    end
    
    def depth_first_search(v)
        stack = [@root]
        
        until stack.empty? do
           current = stack.pop
           return current if current.value == v
           stack << current.rchild if current.rchild
           stack << current.lchild if current.lchild
        end
        nil
    end
    
    def dfs_rec(v)
        dfs_rec_helper(v, @root)
    end
    
    def dfs_rec_helper(v, current = nil)
        #base cases
        return nil if current.nil?
        return current if current.value == v
        
        #check the left and right children if they exist
        left_check = dfs_rec_helper(v, current.lchild) if current.lchild
        right_check = dfs_rec_helper(v, current.rchild) if current.rchild
        
        #return the left or right check if they were successful
        return left_check if left_check
        return right_check if right_check
        
        #return nil if the value was not found
        nil
    end
    
    class Node
        attr_accessor(:value, :parent, :lchild, :rchild)
      
        def initialize(value, parent = nil, lchild = nil, rchild = nil)
            @value = value
            @parent = parent
            @lchild = lchild
            @rchild = rchild
        end
    end
end

#tests
a = (1..10).to_a.shuffle

b = BinaryTree.new
b.build_tree(a)

b.breadth_first_search(8)
b.depth_first_search(3)
b.dfs_rec(2)
