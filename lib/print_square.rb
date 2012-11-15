require "print_square/version"
require 'active_support/dependencies/autoload'

module PrintSquare
  extend ActiveSupport::Autoload

  autoload :CommandRunner
end
