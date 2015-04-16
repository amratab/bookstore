require "rubygems"

require "bundler/setup"

require "sinatra"

require "haml"

require 'active_record'

require 'mysql2'

require "./app"

set :run, false

set :raise_errors, true

run Sinatra::Application

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => "user",
  :password => "password",
  :database => "bookstoredb"
)

use Rack::Session::Cookie , :secret => "82e042cd6fde2bf1764f777236db799e"
use Rack::Session::Pool, :expire_after => 2592000

 enable :sessions