# frozen_string_literal: true

require 'rake'
require 'English'
require 'fileutils'
require File.join(File.dirname(__FILE__), 'bin', 'dotfiles', 'vundle')

desc 'Hook our dotfiles into system-standard positions.'
task :install do
  puts
  puts 'Bringing in the thunder.'
  puts '======================================================'
  puts

  install_homebrew_and_all_packages if RUBY_PLATFORM.downcase.include?('darwin') && want_to_install?('brew & brewfile')

  # install_oh_my_zsh if want_to_install?('oh my zsh')
  # install_files(Dir.glob('{zshrc}')) if want_to_install?('zshrc')
  install_prezto if want_to_install?('prezto')

  install_files(Dir.glob('git/*')) if want_to_install?('git configs (color, aliases)')
  install_files(Dir.glob('irb/*')) if want_to_install?('irb/pry configs (more colorful)')
  install_files(Dir.glob('ruby/*')) if want_to_install?('rubygems config (faster/no docs)')
  install_files(Dir.glob('ctags/*')) if want_to_install?('ctags config (better js/ruby support)')
  install_files(Dir.glob('tmux/*')) if want_to_install?('tmux config')
  install_files(Dir.glob('javascript/*')) if want_to_install?('eslintrc')
  if want_to_install?('vim configuration (highly recommended)')
    install_files(Dir.glob('{vim,vimrc}'))
    Rake::Task['install_vundle'].execute
  end

  install_fonts if want_to_install?('fonts')

  install_iterm_theme if RUBY_PLATFORM.downcase.include?('darwin') if want_to_install?('iterm theme')

  run_bundle_config if want_to_install?('configure bundler')

  success_msg('installed')
end

desc 'Updates the installation'
task :update do
  Rake::Task['vundle_migration'].execute if needs_migration_to_vundle?
  Rake::Task['install'].execute
end

desc 'Performs migration from pathogen to vundle'
task :vundle_migration do
  puts 'Migrating from pathogen to vundle vim plugin manager. '
  puts 'This will move the old .vim/bundle directory to'
  puts '.vim/bundle.old and replacing all your vim plugins with'
  puts 'the standard set of plugins. You will then be able to '
  puts "manage your vim's plugin configuration by editing the "
  puts 'file .vim/vundles.vim'
  puts '======================================================'

  Dir.glob(File.join('vim', 'bundle', '**')) do |sub_path|
    run %(git config -f #{File.join('.git', 'config')} --remove-section submodule.#{sub_path})
    FileUtils.rm_rf(File.join('.git', 'modules', sub_path))
  end
  FileUtils.mv(File.join('vim', 'bundle'), File.join('vim', 'bundle.old'))
end

desc 'Runs Vundle installer in a clean vim environment'
task :install_vundle do
  puts 'Installing and updating vundles.'
  puts '======================================================'
  puts

  vundle_path = File.join('vim', 'bundle', 'vundle')
  if File.exist?(vundle_path)
    run %( cd $HOME/.dotfiles/#{vundle_path} && git pull )
  else
    run %( cd $HOME/.dotfiles && git clone https://github.com/gmarik/vundle.git #{vundle_path} )
  end

  Vundle.update_vundle
end

task default: 'install'

private

def run(cmd)
  puts "[Running] #{cmd}"
  `#{cmd}` unless ENV['DEBUG']
end

def number_of_cores
  cores = if RUBY_PLATFORM.downcase.include?('darwin')
            run %( sysctl -n hw.ncpu )
          else
            run %( nproc )
          end
  puts
  cores.to_i
end

def run_bundle_config
  return unless system('which bundle')

  bundler_jobs = number_of_cores - 1
  puts 'Configuring Bundlers for parallel gem installation'
  run %( bundle config --global jobs #{bundler_jobs} )
  puts
end

def install_prezto
  puts
  puts "Installing Prezto (ZSH Enhancements)..."
  puts '======================================================'

  if File.exists?(File.join(ENV['HOME'], '.zprezto'))
    puts "Prezto already installed. Skipping installation"
  else
    run %{ git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" }

    # The prezto runcoms are only going to be installed if zprezto has never been installed
    install_files_absolute(Dir.glob(File.join(ENV['HOME'], '.zprezto/runcoms/z*')), :symlink)
  end

  puts
  puts "Overriding prezto ~/.zpreztorc to enable additional modules..."
  run %{ ln -nfs "$HOME/.dotfiles/zsh/prezto-override/zpreztorc" "${ZDOTDIR:-$HOME}/.zpreztorc" }

  puts
  puts "Creating directories for your customizations"
  run %{ mkdir -p $HOME/.zsh.before }
  run %{ mkdir -p $HOME/.zsh.after }
  run %{ mkdir -p $HOME/.zsh.prompts }

  if "#{ENV['SHELL']}".include? 'zsh' then
    puts "Zsh is already configured as your shell of choice. Restart your session to load the new settings"
  else
    puts "Setting zsh as your default shell"
    if File.exists?("/usr/local/bin/zsh")
      if File.readlines("/private/etc/shells").grep("/usr/local/bin/zsh").empty?
        puts "Adding zsh to standard shell list"
        run %{ echo "/usr/local/bin/zsh" | sudo tee -a /private/etc/shells }
      end
      run %{ chsh -s /usr/local/bin/zsh }
    else
      run %{ chsh -s /bin/zsh }
    end
  end
end

def install_homebrew_and_all_packages
  install_homebrew_if_not_already_installed
  update_homebrew
  install_homebrew_packages
end

def install_homebrew_if_not_already_installed
  run %(which brew)
  return if $?&.success?

  if $?.nil?
    puts 'Hummmm... Seems like `which brew` failed.'
    return
  end

  puts 'Installing Homebrew, if not already installed'
  run %{ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" }
end

def update_homebrew
  puts 'Updating Homebrew.'
  run %( brew update )
  run %( brew tap Homebrew/bundle )
  run %{ ln -sf $(pwd)/brew/Brewfile ${HOME}/.Brewfile }
end

def install_homebrew_packages
  puts 'Installing Homebrew packages...There may be some ignorable warnings.'
  run %( brew bundle --global )
  puts 'Cleaning up after brew.'
  run %( brew cleanup )
end

def install_oh_my_zsh
  run %{ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" }
end

def install_fonts
  puts 'Installing patched fonts for Powerline/Lightline.'
  run %( cp -f $HOME/.dotfiles/fonts/* $HOME/Library/Fonts ) if RUBY_PLATFORM.downcase.include?('darwin')
  run %( mkdir -p ~/.fonts && cp ~/.dotfiles/fonts/* ~/.fonts && fc-cache -vf ~/.fonts ) if RUBY_PLATFORM.downcase.include?('linux')
  puts
end

def install_iterm_theme
  install_themes_in_iterm
  pick_iterm_theme if ensure_plist_exists
end

def install_themes_in_iterm
  puts 'Installing iTerm2 themes.'
  run %( /usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Bright Lights' dict" ~/Library/Preferences/com.googlecode.iterm2.plist )
  run %( /usr/libexec/PlistBuddy -c "Merge 'iTerm2/Bright Lights.itermcolors' :'Custom Color Presets':'Bright Lights'" ~/Library/Preferences/com.googlecode.iterm2.plist )
  run %( /usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Snow Dark' dict" ~/Library/Preferences/com.googlecode.iterm2.plist )
  run %( /usr/libexec/PlistBuddy -c "Merge 'iTerm2/Snow Dark.itermcolors' :'Custom Color Presets':'Snow Dark'" ~/Library/Preferences/com.googlecode.iterm2.plist )
  run %( /usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Ayu' dict" ~/Library/Preferences/com.googlecode.iterm2.plist )
  run %( /usr/libexec/PlistBuddy -c "Merge 'iTerm2/ayu.itermcolors' :'Custom Color Presets':'Ayu'" ~/Library/Preferences/com.googlecode.iterm2.plist )
end

def ensure_plist_exists
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
  color_scheme = ask message, iterm_available_themes

  return if color_scheme == 'None'

  color_scheme_file = File.join('iTerm2', "#{color_scheme}.itermcolors")

  # Ask the user on which profile he wants to install the theme
  profiles = iterm_profile_list
  message = "I've found #{profiles.size} #{profiles.size > 1 ? 'profiles' : 'profile'} on your iTerm2 configuration, which one would you like to apply the Solarized theme to?"
  profiles << 'All'
  selected = ask message, profiles

  if selected == 'All'
    (profiles.size - 1).times { |idx| apply_theme_to_iterm_profile_idx idx, color_scheme_file }
  else
    apply_theme_to_iterm_profile_idx profiles.index(selected), color_scheme_file
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

def ask(message, values)
  puts message
  while true
    values.each_with_index { |val, idx| puts " #{idx + 1}. #{val}" }
    selection = STDIN.gets.chomp
    if (begin
        Float(selection).nil?
    rescue StandardError
      true
    end) || selection.to_i < 0 || selection.to_i > values.size + 1
    puts "ERROR: Invalid selection.\n\n"
  else
    break
  end
end
selection = selection.to_i - 1
values[selection]
end

def want_to_install?(section)
  return true if ENV['ASK'] == 'false'

  puts '************************************** QUESTION *********************************************'
  puts "* Would you like to install configuration files for: #{section}? yes, [n]o"
  STDIN.gets.chomp == 'y'
end

def install_files_absolute(files, method = :symlink)
  files.each do |f|
    file = f.split('/').last
    source = f
    target = "#{ENV['HOME']}/.#{file}"

    puts "======================#{file}=============================="
    puts "Source: #{source}"
    puts "Target: #{target}"

    if File.exist?(target) && (!File.symlink?(target) || (File.symlink?(target) && File.readlink(target) != source))
      puts "[Overwriting] #{target}...leaving original at #{target}.backup..."
      run %( mv "$HOME/.#{file}" "$HOME/.#{file}.backup" )
    end

    if method == :symlink
      run %( ln -nfs "#{source}" "#{target}" )
    else
      run %( cp -f "#{source}" "#{target}" )
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

def install_files(files, method = :symlink)
  files.each do |f|
    file = f.split('/').last
    source = "#{ENV['PWD']}/#{f}"
    target = "#{ENV['HOME']}/.#{file}"

    puts "======================#{file}=============================="
    puts "Source: #{source}"
    puts "Target: #{target}"

    if File.exist?(target) && (!File.symlink?(target) || (File.symlink?(target) && File.readlink(target) != source))
      puts "[Overwriting] #{target}...leaving original at #{target}.backup..."
      run %( mv "$HOME/.#{file}" "$HOME/.#{file}.backup" )
    end

    if method == :symlink
      run %( ln -nfs "#{source}" "#{target}" )
    else
      run %( cp -f "#{source}" "#{target}" )
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
  values.flatten.each { |entry| run %( /usr/libexec/PlistBuddy -c "Delete :'New Bookmarks':#{index}:'#{entry}'" ~/Library/Preferences/com.googlecode.iterm2.plist ) }

  run %( /usr/libexec/PlistBuddy -c "Merge '#{color_scheme_path}' :'New Bookmarks':#{index}" ~/Library/Preferences/com.googlecode.iterm2.plist )
  run %( defaults read com.googlecode.iterm2 )
end

def success_msg(action)
  puts "#{action}. Please restart your terminal and vim."
end
