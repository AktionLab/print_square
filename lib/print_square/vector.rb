module PrintSquare
  class Vector
    attr_accessor :direction, :position, :offset, :turn, :size

    def initialize(direction, size, size_offset=1)
      @direction, @size, @size_offset = direction, size, size_offset
      @position = size.even? ? 0 : size - 1
      @offset = 0
    end

    def next
      @position += @direction
      @turn.call if bounds?
    end

    def bounds?
      @position == (@direction == 1 ? (@size - @size_offset) : @offset) 
    end
  end
end

