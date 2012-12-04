#!/usr/bin/env ruby
# encoding: utf-8

require 'pathname'
require 'fileutils'

HOME = Pathname(ENV['HOME'])
PWD  = Pathname.pwd

HOME_FILES = %w{.zshrc .Xresources .xinitrc .vimrc .vim .tmux.conf .gtkrc-2.0 .gitignore .gitconfig .i3 }

# create files in home directory
HOME_FILES.each do |file|
  home_file = Pathname(HOME + file)
  pwd_file  = Pathname(PWD + file)

  if home_file.exist?
    puts "#{home_file} exists.
  else
    puts "Created symlink #{home_file} → #{pwd_file}"
    File.symlink(pwd_file, home_file)
  end
end

# create folders and empty files in home directory
['.zsh'].each do |directory|
  directory = HOME + directory

  unless directory.exist?
    directory.mkpath
    puts "Created directory #{directory}"
  end
end

['.portknocking'].each do |file|
  file = HOME + file

  unless file.exist?
    FileUtils.touch(file)
    puts "Touched file #{file}"
  end
end
