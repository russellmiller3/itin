require 'sinatra'
require 'sinatra/partial'
require 'better_errors'

require_relative 'models'

set :partial_template_engine, :erb

configure :development do
	use BetterErrors::Middleware
	BetterErrors.application_root  = File.expand_path('..', __FILE__)
end

def show_params
  p params
end

helpers do
	def itin
		@itin ||= Itin.last
	end
end

get "/" do
	@events = itin.events if itin
	erb :'home', :locals => {:itin => itin}
end

post("/itins") do
	itin_attrs = params[:itin]

	itin = Itin.new(itin_attrs)
	itin.save

	if request.xhr?
		serverResponse = partial :'partials/itin', :locals => {:itin => itin}
  else
    redirect "/"
  end
end


get("/itins/:id") do
	show_params
	@itin = Itin.get(params[:id])
end

post("/events") do
end

puts("/events/:id") do
end

delete("/events/:id") do
end




