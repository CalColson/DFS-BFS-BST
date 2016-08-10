class ChessBoard
	class Cell
		attr_accessor :pos, :x, :y, :prev_cell
		def initialize(pos, last = nil)
			@pos = pos
			@x, @y = pos
			@prev_cell = last
		end
	end

	class Knight
		attr_accessor :pos

		def initialize(pos)
			@pos = pos
		end

		def moves
			moves = []
			x, y = @pos

			moves << [x - 2, y + 1] if onboard [x - 2, y + 1]
			moves << [x - 2, y - 1] if onboard [x - 2, y - 1]
			moves << [x + 2, y + 1] if onboard [x + 2, y + 1]
			moves << [x + 2, y - 1] if onboard [x + 2, y - 1]

			moves << [x + 1, y + 2] if onboard [x + 1, y + 2]
			moves << [x - 1, y + 2] if onboard [x - 1, y + 2]
			moves << [x + 1, y - 2] if onboard [x + 1, y - 2]
			moves << [x - 1, y - 2] if onboard [x - 1, y - 2]

			moves
		end

		def onboard(pos)
			return pos.all? { |num| num.between?(0,7) }
		end
	end

	def knight_moves(start_pos, finish_pos)
		queue = [Cell.new(start_pos)]
		marked = Hash.new(false)

		until queue.empty?
			cell = queue.shift
			marked[cell.pos] = true
			break if cell.pos == finish_pos

			Knight.new(cell.pos).moves.each do |pos|
				move = Cell.new(pos, cell)
				queue << move unless marked[move.pos]
			end
		end

		if cell.pos = finish_pos
			path = []
			current_cell = cell

			until current_cell.nil?
				path.unshift current_cell.pos
				current_cell = current_cell.prev_cell
			end
			return path
		else
			return nil
		end
	end
end

board = ChessBoard.new
path = board.knight_moves([3,3],[7,7])

p "You made it in #{path.length - 1} moves! Here's your path:"
path.each do |pos|
	p pos
	#p "possible moves:"
	#p ChessBoard::Knight.new(pos).moves
end