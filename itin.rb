require 'sinatra'
require 'sinatra/partial'
require 'better_errors'

require_relative 'config/dotenv'
require_relative 'models'

set :partial_template_engine, :erb

configure :development do
	use BetterErrors::Middleware
	BetterErrors.application_root  = File.expand_path('..', __FILE__)

get "/" do

	erb :'itin/home'
end