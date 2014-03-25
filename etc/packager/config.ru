#config.ru
require 'rubygems'
require 'sinatra'
require 'rack'
set :root, Pathname(__FILE__).dirname
require './packager.rb'
set :environment, :production
set :run, false
run Sinatra::Application