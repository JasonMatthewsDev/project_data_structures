Location = Struct.new(:location, :path)

class Knight
    @@moves = [[ 1,  2], [ 2,  1], [ 1, -2], [ 2, -1],
               [-1,  2], [-2,  1], [-1, -2], [-2, -1]]
               
    def initialize(board_size = 8)
        @board_size = board_size
    end
    
    def knight_moves(loc, dest)
        return nil unless valid_loc?(dest) || valid_loc?(loc)
        return loc if loc == dest
        
        queue = [Location.new(loc, [loc])]
        visited = [loc]
        
        until queue.empty? do
            current = queue.shift
            
            return current.path << dest if get_moves(current.location).include?(dest)
            get_moves(current.location).each do |p| 
                queue << Location.new(p, current.path + [p]) unless visited.include?(p)
                visited << p
            end
        end
        
        nil
    end
    
    def knight_moves_helper(loc, dest, path = [])
        
    end
    
    def get_moves(loc)
        result = []
        @@moves.each { |p| result << add_move(loc, p) if valid_loc?(add_move(loc, p)) }
        result
    end
    
    def add_move(loc, move)
       [loc[0] + move[0], loc[1] + move[1]]
    end
    
    def valid_loc?(point)
       return true if point[0].between?(0, @board_size - 1) && point[1].between?(0, @board_size - 1)
       false
    end
end

knight = Knight.new
knight.knight_moves([3,3],[4,3])
