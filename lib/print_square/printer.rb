module PrintSquare
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

end

