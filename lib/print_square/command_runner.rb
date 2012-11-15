module PrintSquare
  class CommandRunner
    def self.run(args)
      usage unless valid_args? args
    end

    def self.valid_args?(args)
      args.count == 1 && Integer(args[0])
    rescue
      false
    end

    def self.usage
      puts <<-USAGE
  print_square [number]
      USAGE
    end
  end
end
