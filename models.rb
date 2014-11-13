require 'data_mapper'

if ENV['RACK_ENV'] != "production"
	require 'dotenv'
	Dotenv.load('.env')
	DataMapper::Logger.new(STDOUT, :debug)
	DataMapper.setup(:default, "sqlite:itin.db")
end

if ENV['RACK_ENV'] == "production"
	DataMapper.setup(:default, ENV['DATABASE_URL'])
end

class Itin
	include DataMapper::Resource

property :id, Serial
property :title, Text
property :notes, Text
property :created_at, DateTime
has n, :events

end

class Event
	include DataMapper::Resource

	property :id, Serial
	property :description, Text
	property :start_time, Time
	property :start_date, Date
	property :end_time, Time
	property :end_date, Date

	belongs_to :itin

end

DataMapper.finalize()
DataMapper.auto_upgrade!()