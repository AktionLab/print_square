module PrintSquare
  class CommandRunner
    class << self
      class Position
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

        def to_s
          <<-TOS
D: #{@direction}
P: #{@position}
O: #{@offset}
S: #{@size}
TOS
        end
      end

      class Printer
        def initialize(size)
          @matrix = (1..size).reduce([]) {|matrix,n| matrix + [(1..size).map { 0 }]}
        end

        def set(x, y, n)
          @matrix[y.position][x.position] = n
        end

        def out
          column_sizes = @matrix.first.map(&:to_s).map(&:size)
          @matrix.each{|r| r.each_with_index{|c,i| print "#{' ' if i > 0}%#{column_sizes[i]}s" % c}; puts}
        end
      end

      def run(args)
        validate_args(args)
        print_square(args[0].to_i)
      end

      def print_square(number)
        size = Math.sqrt(number).to_i
        n = number
        x = Position.new size.even? ? 1 : -1, size, size.even? ? 1 : 0
        y = Position.new 0, size
        print = Printer.new size

        x.turn = proc do
          y.offset += 1 if x.direction == 1
          y.direction = x.direction
          x.direction = 0
        end

        y.turn = proc do
          if y.direction == -1
            x.size -= 1
            y.size -= 1
            x.offset += 1
          end
          x.direction = y.direction * -1
          y.direction = 0
        end

        until n == 0
          print.set x, y, n
          y.direction == 0 ? x.next : y.next
          n -= 1
        end

        print.out
      end

      def is_square?(number)
        return true if number == 1
        position = 2
        spread = 1
        until spread == 0
          current_square = position*position
          return true if current_square == number
          if number < current_square
            spread >>= 1
            position -= spread
          else
            spread <<= 1
            position += spread
          end
        end
        false
      end

      def validate_args(args)
        usage(:no_args) if args.count == 0
        usage(:too_many_args) if args.count > 1
        usage(:invalid_arg) unless (Integer(args[0]) rescue false)
        usage(:not_square) unless is_square?(args[0].to_i)
      end

      def usage(error_type)
        error = case error_type
        when :no_args then 'Missing argument'
        when :invalid_arg then 'Argument must be a number'
        when :too_many_args then 'Too many arguments'
        when :not_square then "Argument is not a square number"
        end
        puts <<-USAGE
    #{error}

    print_square [square_number]
        USAGE

        exit(-1)
      end
    end
  end
end
