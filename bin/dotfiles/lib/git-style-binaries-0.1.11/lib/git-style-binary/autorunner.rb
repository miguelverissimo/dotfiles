# frozen_string_literal: true

require 'git-style-binary/parser'

module GitStyleBinary
  class AutoRunner
    def self.run(_argv = ARGV)
      r = new
      r.run
  end

    def run
      unless GitStyleBinary.run?
        GitStyleBinary.load_primary unless GitStyleBinary.current_command
        GitStyleBinary.current_command.run
      end
    end
    end
end
