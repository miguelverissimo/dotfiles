# frozen_string_literal: true

Dir[File.join(File.dirname(__FILE__), 'lib/**/lib')].each do |dir|
  $LOAD_PATH << dir
end

require 'git-style-binary/command'

$dotfiles = File.join(ENV['HOME'], '.dotfiles')
