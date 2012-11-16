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

      out_rows = []
      @matrix.each do |row|
        row.each_with_index do |cell,i|
          row[i] = cell.to_s.rjust(column_sizes[i])
        end
        out_rows << [row.join(' ')]
      end
      puts out_rows.join("\n")
    end
  end
end

