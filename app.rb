set :haml, :format => :html5

get "/" do

  haml :index

end

get '/hello/:name' do
  @name = params[:name]
  @values = {
    1 => "cake",
    2 => "cookies"
  }
  haml :index
end