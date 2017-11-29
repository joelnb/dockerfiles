#! /usr/bin/env ruby

require 'rubygems'
require 'gollum/app'

env_gollum_dir = ENV['GOLLUM_DIR']
puts env_gollum_dir
gollum_path = File.expand_path('/wiki')
wiki_options = { universal_toc: false, css: true }
Precious::App.set(:gollum_path, gollum_path)
Precious::App.set(:default_markup, :github_markdown)
Precious::App.set(:wiki_options, wiki_options)
run Precious::App
