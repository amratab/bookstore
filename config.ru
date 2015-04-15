require "rubygems"

require "bundler/setup"

require "sinatra"

require "haml"

require 'active_record'

require "./app"

set :run, false

set :raise_errors, true

run Sinatra::Application

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "host",
  :username => "user",
  :password => "password",
  :database => "bookstoredb"
)