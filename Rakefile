# frozen_string_literal: true

require 'rake'
require 'English'
require 'fileutils'
require 'tty'
require File.join(File.dirname(__FILE__), 'bin', 'dotfiles', 'vundle')

desc 'install homebrew packages'
task :install_homebrew_packages do
  yellow_text 'Step: Install Homebrew packages'
  return if confirm? && !get_response('Install all homebrew packages?')
  # TODO
end

desc 'install prezto'
task :install_prezto do
  yellow_text 'Step: Install prezto'
  return if confirm? && !get_response('Install prezto?')
  install_prezto
end

desc 'link git configurations'
task :link_git_configs do
  yellow_text 'Step: Install git configurations'
  return if confirm? && !get_response('Install git configurations?')
  begin
    install_files(Dir.glob('git/*'))
  rescue => e
    red_text("Failed! : #{e}")
  end
end

desc 'link irb and pry configurations'
task :link_irb_pry_configs do
  yellow_text 'Step: Install irb and pry configurations'
  return if confirm? && !get_response('Install irb and pry configurations?')
  begin
    install_files(Dir.glob('irb/*'))
  rescue => e
    red_text("Failed! : #{e}")
  end
end

desc 'link rubygems configurations'
task :link_rubygems_configs do
  yellow_text 'Step: Install rubygems configurations'
  return if confirm? && !get_response('Install rubygems configurations?')
  begin
    install_files(Dir.glob('ruby/*'))
  rescue => e
    red_text("Failed! : #{e}")
  end
end

desc 'link ctags configurations'
task :link_ctags_configs do
  yellow_text 'Step: Install ctags configurations'
  return if confirm? && !get_response('Install ctags configurations?')
  begin
    install_files(Dir.glob('ctags/*'))
  rescue => e
    red_text("Failed! : #{e}")
  end
end

desc 'link tmux configurations'
task :link_tmux_configs do
  yellow_text 'Step: Install tmux configurations'
  return if confirm? && !get_response('Install tmux configurations?')
  begin
    install_files(Dir.glob('tmux/*'))
  rescue => e
    red_text("Failed! : #{e}")
  end
end

desc 'link global linter configurations'
task :link_linter_configs do
  yellow_text 'Step: Install linter configurations'
  return if confirm? && !get_response('Install linter configurations?')
  begin
    install_files(Dir.glob('linters/*'))
  rescue => e
    red_text("Failed! : #{e}")
  end
end

desc 'link vim configurations and packages'
task :link_vim_and_vundle do
  yellow_text 'Step: Install vim configurations and packages via vundle'
  return if confirm? && !get_response('Install vin configurations and packages?')
  begin
    install_files(Dir.glob('{vim,vimrc}'))
    Rake::Task['install_vundle'].execute
  rescue => e
    red_text("Failed! : #{e}")
  end
end

desc 'install fonts'
task :install_fonts do
  yellow_text 'Step: Install fonts'
  return if confirm? && !get_response('Install fonts?')
  begin
    install_fonts
  rescue => e
    red_text("Failed! : #{e}")
  end
end

desc 'install and choose iTerm2 themes'
task :install_iterm_theme do
  yellow_text 'Step: Install and choose iTerm2 themes'
  return if confirm? && !get_response('Install and choose iTerm2 themes?')
  begin
    install_iterm_themes
  rescue => e
    red_text("Failed! : #{e}")
  end
end

desc 'link bundler configs (no docs)'
task :link_bundler_config do
  yellow_text 'Step: Install bundler configurations'
  return if confirm? && !get_response('Install bundler configurations?')
  begin
    run_bundle_config
  rescue => e
    red_text("Failed! : #{e}")
  end
end

desc 'link all dotfiles (configurations)'
task :link_all_dotfiles do
  Rake::Task['link_git_configs'].execute
  Rake::Task['link_irb_pry_configs'].execute
  Rake::Task['link_rubygems_configs'].execute
  Rake::Task['link_ctags_configs'].execute
  Rake::Task['link_tmux_configs'].execute
  Rake::Task['link_linter_configs'].execute
  Rake::Task['link_bundler_config'].execute
end

desc 'full installation (initial setup)'
task :full_installation do
  Rake::Task['install_homebrew_packages'].execute
  Rake::Task['install_prezto'].execute
  Rake::Task['link_all_dotfiles'].execute
  Rake::Task['install_fonts'].execute
  Rake::Task['install_iterm_theme'].execute
  Rake::Task['link_vim_and_vundle'].execute
  success_msg
end

desc 'Updates the installation'
task :update do
  migrate_to_vundle if needs_migration_to_vundle?
  Rake::Task['full_installation'].execute
end

desc 'Runs Vundle installer in a clean vim environment'
task :install_vundle do
  yellow_text 'Installing and updating vundles.'

  vundle_path = File.join('vim', 'bundle', 'vundle')
  if File.exist?(vundle_path)
    run_shell_command %( cd $HOME/.dotfiles/#{vundle_path} && git pull )
  else
    run_shell_command %( cd $HOME/.dotfiles && git clone https://github.com/gmarik/vundle.git #{vundle_path} )
  end

  Vundle.update_vundle
end

task default: 'install'

private

def get_response(query)
  TTY::Prompt.new.yes?(query)
end

def confirm?
  ENV['ASK'] == 'true'
end

def migrate_to_vundle
  puts 'Migrating from pathogen to vundle vim plugin manager. '
  puts 'This will move the old .vim/bundle directory to'
  puts '.vim/bundle.old and replacing all your vim plugins with'
  puts 'the standard set of plugins. You will then be able to '
  puts "manage your vim's plugin configuration by editing the "
  puts 'file .vim/vundles.vim'
  puts '======================================================'

  Dir.glob(File.join('vim', 'bundle', '**')) do |sub_path|
    run_shell_command %(git config -f #{File.join('.git', 'config')} --remove-section submodule.#{sub_path})
    FileUtils.rm_rf(File.join('.git', 'modules', sub_path))
  end
  FileUtils.mv(File.join('vim', 'bundle'), File.join('vim', 'bundle.old'))
end

def number_of_cores
  command = RUBY_PLATFORM.downcase.include?('darwin')? %( sysctl -n hw.ncpu ) : %( nproc )
  cores = run_command command
  cores.to_i
end

def run_bundle_config
  return unless system('which bundle')

  bundler_jobs = number_of_cores - 1
  bright_blue_text 'Configuring Bundlers for parallel gem installation'
  run_shell_command %( bundle config --global jobs #{bundler_jobs} )
  puts
end

def install_prezto
  if File.exists?(File.join(ENV['HOME'], '.zprezto'))
    yellow_text "Prezto already installed. Skipping installation"
  else
    run_shell_command %{ git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" }

    # The prezto runcoms are only going to be installed if zprezto has never been installed
    install_files(Dir.glob(File.join(ENV['HOME'], '.zprezto/runcoms/z*')), :symlink, false)
  end

  yellow_text "Overriding prezto ~/.zpreztorc to enable additional modules..."
  run_shell_command %{ ln -nfs "$HOME/.dotfiles/zsh/prezto-override/zpreztorc" "${ZDOTDIR:-$HOME}/.zpreztorc" }

  yellow_text "Creating directories for your customizations"
  run_shell_command %{ mkdir -p $HOME/.zsh.before }
  run_shell_command %{ mkdir -p $HOME/.zsh.after }
  run_shell_command %{ mkdir -p $HOME/.zsh.prompts }

  if "#{ENV['SHELL']}".include? 'zsh' then
    puts "Zsh is already configured as your shell of choice. Restart your session to load the new settings"
  else
    yellow_text "Setting zsh as your default shell"
    if File.exists?("/usr/local/bin/zsh")
      if File.readlines("/private/etc/shells").grep("/usr/local/bin/zsh").empty?
        yellow_text "Adding zsh to standard shell list"
        run_shell_command %{ echo "/usr/local/bin/zsh" | sudo tee -a /private/etc/shells }
      end
      run_shell_command %{ chsh -s /usr/local/bin/zsh }
    else
      run_shell_command %{ chsh -s /bin/zsh }
    end
  end
end

def update_homebrew
  yellow_text 'Updating Homebrew.'
  run_shell_command %( brew update )
  run_shell_command %( brew tap Homebrew/bundle )
  run_shell_command %{ ln -sf $(pwd)/brew/Brewfile ${HOME}/.Brewfile }
end

def install_homebrew_packages
  update_homebrew
  yellow_text 'Installing Homebrew packages...There may be some ignorable warnings.'
  run_shell_command %( brew bundle --global )
  yellow_text 'Cleaning up after brew.'
  run_shell_command %( brew cleanup )
end

def install_oh_my_zsh
  run_shell_command %{ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" }
end

def install_fonts
  yellow_text 'Installing patched fonts for Powerline/Lightline.'
  run_shell_command %( cp -f $HOME/.dotfiles/fonts/* $HOME/Library/Fonts ) if RUBY_PLATFORM.downcase.include?('darwin')
  run_shell_command %( mkdir -p ~/.fonts && cp ~/.dotfiles/fonts/* ~/.fonts && fc-cache -vf ~/.fonts ) if RUBY_PLATFORM.downcase.include?('linux')
end

def install_iterm_themes
  install_themes_in_iterm
  pick_iterm_theme if plist_exists?
end

def install_themes_in_iterm
  yellow_text 'Installing iTerm2 themes.'
  run_shell_command! %( /usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Bright Lights' dict" ~/Library/Preferences/com.googlecode.iterm2.plist )
  run_shell_command! %( /usr/libexec/PlistBuddy -c "Merge 'iTerm2/Bright Lights.itermcolors' :'Custom Color Presets':'Bright Lights'" ~/Library/Preferences/com.googlecode.iterm2.plist )
  run_shell_command! %( /usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Snow Dark' dict" ~/Library/Preferences/com.googlecode.iterm2.plist )
  run_shell_command! %( /usr/libexec/PlistBuddy -c "Merge 'iTerm2/Snow Dark.itermcolors' :'Custom Color Presets':'Snow Dark'" ~/Library/Preferences/com.googlecode.iterm2.plist )
  run_shell_command! %( /usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Ayu' dict" ~/Library/Preferences/com.googlecode.iterm2.plist )
  run_shell_command! %( /usr/libexec/PlistBuddy -c "Merge 'iTerm2/ayu.itermcolors' :'Custom Color Presets':'Ayu'" ~/Library/Preferences/com.googlecode.iterm2.plist )
end

def plist_exists?
  # If iTerm2 is not installed or has never run, we can't autoinstall the profile since the plist is not there
  unless File.exist?(File.join(ENV['HOME'], '/Library/Preferences/com.googlecode.iterm2.plist'))
    puts 'To make sure your profile is using the installed themes'
    puts 'Change it in Preferences> Profiles> [your profile]> Colors> Load Preset..'
    return false
  end
  true
end

def pick_iterm_theme
  message = 'Which theme would you like to apply to your iTerm2 profile?'
  # color_scheme = ask message, iterm_available_themes
  color_scheme = select(message, iterm_available_themes)

  return if color_scheme == 'None'

  color_scheme_file = File.join('iTerm2', "#{color_scheme}.itermcolors")

  # Ask the user on which profile he wants to install the theme
  profiles = iterm_profile_list
  message = "I've found #{profiles.size} #{profiles.size > 1 ? 'profiles' : 'profile'} on your iTerm2 configuration, which one would you like to apply the Solarized theme to?"
  profiles << 'All'
  selected = select(message, profiles)

  if selected == 'All'
    (profiles.size - 1).times { |idx| apply_theme_to_iterm_profile_idx idx, color_scheme_file }
  else
    apply_theme_to_iterm_profile_idx(profiles.index(selected), color_scheme_file)
  end
end

def iterm_available_themes
  Dir['iTerm2/*.itermcolors'].map { |value| File.basename(value, '.itermcolors') } << 'None'
end

def iterm_profile_list
  profiles = []
  loop do
    profiles << `/usr/libexec/PlistBuddy -c "Print :'New Bookmarks':#{profiles.size}:Name" ~/Library/Preferences/com.googlecode.iterm2.plist 2>/dev/null`
    break unless $?&.exitstatus&.zero?
  end
  profiles.pop
  profiles
end

def select(message, values)
  TTY::Prompt.new.select(message, values)
end

def install_files(files, method = :symlink, relative = true)
  files.each do |f|
    file = f.split('/').last
    source = relative ? "#{ENV['PWD']}/#{f}" : f
    target = "#{ENV['HOME']}/.#{file}"

    bright_blue_text "====================  #{file}  ============================"
    puts "Source: #{source}"
    magenta_text "Target: #{target}"

    if File.exist?(target) && (!File.symlink?(target) || (File.symlink?(target) && File.readlink(target) != source))
      bold_blue_text "[Overwriting] #{target}...leaving original at #{target}.backup..."
      run_shell_command %( mv "$HOME/.#{file}" "$HOME/.#{file}.backup" )
    end

    if method == :symlink
      run_shell_command %( ln -nfs "#{source}" "#{target}" )
    else
      run_shell_command %( cp -f "#{source}" "#{target}" )
    end

    source_config_code = 'for config_file ($HOME/.dotfiles/zsh/*.zsh) source $config_file'
    if file == 'zshrc'
      File.open(target, 'a+') do |zshrc|
        if zshrc.readlines.grep(/#{Regexp.escape(source_config_code)}/).empty?
          zshrc.puts(source_config_code)
        end
      end
    end
    puts
  end
end

def needs_migration_to_vundle?
  File.exist? File.join('vim', 'bundle', 'tpope-vim-pathogen')
end

def list_vim_submodules
  result = %x(git submodule -q foreach 'echo $name"||"\`git remote -v | awk "END{print \\\\\$2}"\`')
    .select { |line| line =~ /^vim.bundle/ }.map { |line| line.split('||') }
  Hash[*result.flatten]
end

def apply_theme_to_iterm_profile_idx(index, color_scheme_path)
  values = []
  16.times { |i| values << "Ansi #{i} Color" }
  values << ['Background Color', 'Bold Color', 'Cursor Color', 'Cursor Text Color', 'Foreground Color', 'Selected Text Color', 'Selection Color']
  values.flatten.each { |entry| run_shell_command %( /usr/libexec/PlistBuddy -c "Delete :'New Bookmarks':#{index}:'#{entry}'" ~/Library/Preferences/com.googlecode.iterm2.plist ) }

  run_shell_command %( /usr/libexec/PlistBuddy -c "Merge '#{color_scheme_path}' :'New Bookmarks':#{index}" ~/Library/Preferences/com.googlecode.iterm2.plist )
  run_shell_command %( defaults read com.googlecode.iterm2 )
end

def run_shell_command(params)
  cmd = TTY::Command.new
  cmd.run(params)
end

def run_shell_command!(params)
  cmd = TTY::Command.new
  cmd.run!(params)
end

def success_msg
  pastel = Pastel.new
  font = TTY::Font.new(:starwars)
  puts pastel.bright_green(font.write('SUCCESS'))
  puts "Please restart your terminal and vim."
end

def yellow_text(msg)
  puts Pastel.new.yellow(msg)
end

def red_text(msg)
  puts Pastel.new.red(msg)
end

def magenta_text(msg)
  puts Pastel.new.magenta(msg)
end

def bold_blue_text(msg)
  puts Pastel.new.bright_blue.bold(msg)
end

def bright_blue_text(msg)
  puts Pastel.new.bright_blue(msg)
end

# def ask(message, values)
#   puts message
#   while true
#     values.each_with_index { |val, idx| puts " #{idx + 1}. #{val}" }
#     selection = STDIN.gets.chomp
#     if (begin
#           Float(selection).nil?
#         rescue => e StandardError
#           true
#         end) || selection.to_i < 0 || selection.to_i > values.size + 1
#       puts "ERROR: Invalid selection.\n\n"
#     else
#       break
#     end
#   end
#   selection = selection.to_i - 1
#   values[selection]
# end
#
# def want_to_install?(section)
#   return true if ENV['ASK'] == 'false'
#
#   puts '************************************** QUESTION *********************************************'
#   HighLine.agree("* Would you like to install configuration files for: #{section}? yes, [n]o")
# end

