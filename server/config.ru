require 'bundler'
Bundler.require

require './models/HeroModel'

require './controllers/HeroController'

run Sinatra::Application

ActiveRecord::Base.establish_connection(
	:adapter => 'postgresql',
	:database => 'hero2'
	)

map('/hero'){run HeroController}