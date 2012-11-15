module PrintSquare
  class CommandRunner
    class << self
      def run(args)
        validate_args(args)
        print_square(args[0].to_i)
      end

      def print_square(number)
        size = Math.sqrt(number).to_i
        m = (1..size).reduce([]) {|matrix,n| matrix + [(1..size).map { nil }]}
        dx = 1
        dy = 0
        px = py = 0
        ox = oy = 0
        n = number
        s = size

        until n == 0
          m[py][px] = n
          if dx == 1
            px += dx
            if px == (s - 1)
              dx = 0
              dy = 1
              oy += 1
            end
          elsif dy == 1
            py += dy
            if py == (s - 1)
              dx = -1
              dy = 0
            end
          elsif dx == -1
            px += dx
            if px == ox
              dx = 0
              dy = -1
            end
          elsif dy == -1
            py += dy
            if py == oy
              dx = 1
              dy = 0
              s -= 1
              ox += 1
            end
          end
          n -= 1
        end

        column_sizes = m.first.map(&:to_s).map(&:size)
        m.each{|r| r.each_with_index{|c,i| print "#{' ' if i > 0}%#{column_sizes[i]}s" % c}; puts}
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
