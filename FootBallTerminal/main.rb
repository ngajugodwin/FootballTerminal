#!/usr/bin/env ruby
require 'rubygems'
require 'pry'
require 'rainbow'
require 'terminal-table'
require 'yaml'
require 'http'
require 'erb'
require './lib/myfootball'

MyFootball.new.show_info
