class BST

	class Node
		attr_accessor :value, :parent, :l_child, :r_child

		def initialize(value, parent = nil)
			@value = value
			@parent = parent
			@l_child = nil
			@r_child = nil
		end
	end

	# build_tree in the tutorial
	def initialize(arr = [])
		@root = nil
		arr.shuffle!
		
		arr.each do |value|
			insert(value)
		end
	end

	def in_order_traversal(arr = [], node = @root)
		return if node.nil?

		in_order_traversal(arr, node.l_child)
		arr << node.value
		in_order_traversal(arr, node.r_child)

		arr
	end

	def bfs(value, queue = [@root])
		return nil if queue.empty? || @root == nil

		node = queue.shift
		return node if node.value == value

		queue << node.l_child unless node.l_child.nil?
		queue << node.r_child unless node.r_child.nil?

		bfs(value, queue)
	end

	def bfs_loop(value)
		return nil if @root.nil?

		queue = [@root]
		until queue.empty?
			node = queue.shift
			break if node.value == value

			queue << node.l_child unless node.l_child.nil?
			queue << node.r_child unless node.r_child.nil?
		end

		return node.value == value ? node : nil
	end

	def dfs(value, node = @root, marked = Hash.new(false))
		return nil if @root.nil?
		return node if node.value == value

		marked[node] = true

		node = dfs(value, node.l_child, marked) unless node.l_child.nil? || marked[node.l_child]
		return node if node.value == value
		node = dfs(value, node.r_child, marked) unless node.r_child.nil? || marked[node.r_child]
		return node.value == value ? node : node.parent
	end

	def dfs_loop(value)
		return nil if @root.nil? 

		stack = [@root]
		marked = Hash.new(false)

		until stack.empty?
			node = stack.last
			marked[node] = true
			break if node.value == value

			if !node.l_child.nil? && !marked[node.l_child]
				stack << node.l_child
			elsif !node.r_child.nil? && !marked[node.r_child]
				stack << node.r_child
			else
				stack.pop
			end
		end

		return node.value == value ? node : nil
	end

	private
	def find_parent(value)
		cur_node = @root
		parent = nil

		#if node value is equal to (or greater than) value, move right
		until cur_node.nil?
			parent = cur_node
			cur_node = value < cur_node.value ? cur_node.l_child : cur_node.r_child
		end
		parent
	end

	def insert(value)
		parent = find_parent(value)
		node = Node.new(value, parent)

		if parent.nil?
			@root = node
			return node
		end

		if value < parent.value
			parent.l_child = node
		else
			parent.r_child = node
		end
		node
	end
end

arr = []
15.times do
	arr << rand(10)
end

tree = BST.new(arr)
#p tree.in_order_traversal
p arr
p tree.bfs(arr[5]).value
p tree.bfs_loop(arr[5]).value
p tree.dfs(arr[5]).value
p tree.dfs_loop(arr[5]).value