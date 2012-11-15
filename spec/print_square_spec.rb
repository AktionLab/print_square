require 'spec_helper'
require 'stringio'

def capture_stdout(&block)
  stdout = $stdout
  out = $stdout = StringIO.new
  begin
    yield
  rescue SystemExit
  end
  $stdout = stdout
  out.seek(0)
  out.read
end

PATTERNS = {
  1  => "1\n",
  4  => "4 3\n1 2\n",
  9  => "9 8 7\n2 1 6\n3 4 5\n",
  16 => "16 15 14 13\n 5  4  3 12\n 6  1  2 11\n 7  8  9 10\n",
  25 => "25 24 23 22 21\n10  9  8  7 20\n11  2  1  6 19\n12  3  4  5 18\n13 14 15 16 17\n",
  36 => "36 35 34 33 32 31\n17 16 15 14 13 30\n18  5  4  3 12 29\n19  6  1  2 11 28\n20  7  8  9 10 27\n21 22 23 24 25 26\n"
}

describe PrintSquare do
  def squares(upto)
    (1..upto).map{|n| n*n}
  end

  it 'with no args outputs the usage' do
    result = capture_stdout { PrintSquare::CommandRunner.run [] }
    result.should == capture_stdout { PrintSquare::CommandRunner.usage(:no_args) }
  end

  it 'with multiple args outputs the usage' do
    result = capture_stdout { PrintSquare::CommandRunner.run %w(1 2) }
    result.should == capture_stdout { PrintSquare::CommandRunner.usage(:too_many_args) }
  end

  it 'with a non integer argument outputs the usage' do
    result = capture_stdout { PrintSquare::CommandRunner.run %w(foo) }
    result.should == capture_stdout { PrintSquare::CommandRunner.usage(:invalid_arg) }
  end

  it 'outputs an error for non square numbers' do
    ((1..(20*20)).to_a - squares(20)).each do |number|
      result = capture_stdout { PrintSquare::CommandRunner.run [number] }
      result.should == capture_stdout { PrintSquare::CommandRunner.usage(:not_square) }
    end
  end

  it 'should not output an error for square numbers' do
    squares(20).each do |n|
      result = capture_stdout { PrintSquare::CommandRunner.run [n] }
      result.should_not == capture_stdout { PrintSquare::CommandRunner.usage(:not_square) }
    end
  end

  it 'should output the proper patterns for each number' do
    squares(6).each do |n|
      result = capture_stdout { PrintSquare::CommandRunner.run [n] }
      result.should == PATTERNS[n]
    end
  end
end
