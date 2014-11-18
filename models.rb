require 'data_mapper'

if ENV['RACK_ENV'] != "production"
	require 'dotenv'
	Dotenv.load('.env')
	DataMapper::Logger.new(STDOUT, :debug)
	DataMapper.setup(:default, "sqlite:itinerary.db")
end

if ENV['RACK_ENV'] == "production"
	DataMapper.setup(:default, ENV['DATABASE_URL'])
end

class Itinerary
	include DataMapper::Resource

property :id, Serial
property :title, Text
property :start_date, Date
property :end_date, Date
property :notes, Text
property :created_at, DateTime
has n, :events, { :child_key => [:itinerary_id]}

end

class Event
	include DataMapper::Resource

	property :id, Serial
	property :title, Text
	property :notes, Text
	property :date, Date
	property :start_time, Time
	property :end_time, Time

	belongs_to :itinerary

end

DataMapper.finalize()
DataMapper.auto_upgrade!()