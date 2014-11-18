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

get "/" do
	show_params
	#@itinerary - current user itinerary if it exists. how do I do this?
	@events = @itinerary.events if @itinerary
	erb :'home', :locals => {:itinerary => @itinerary, :events => @events}
end


post(	"/itineraries") do
	show_params
	itinerary_attrs = params[:itinerary]
	@itinerary = Itinerary.new(itinerary_attrs)
	@itinerary.save

	if request.xhr?
		itinerary_html = partial :'partials/itinerary', :locals => {:itinerary => @itinerary}
		itinerary_html += partial :'partials/itinerary_edit', :locals => {:itinerary => @itinerary}
		itinerary_html

  else
    redirect "/"
  end
end


get("/itineraries/:id") do
	show_params
	@itinerary = itinerary.get(params[:id])
end

post("/events") do
	show_params
	event_attrs = params[:event]
	event_attrs.merge!({:itinerary => @itinerary})
	@event = Event.new(event_attrs)
	@event.save

	if request.xhr?
		event_html = partial :'partials/event', :locals => {:event => @event }
		event_html += partial :'partials/event_edit', :locals => {:event => @event }
		event_html
	else redirect "/"
	end
end

puts("/events/:id") do
end

delete("/events/:id") do
end

















