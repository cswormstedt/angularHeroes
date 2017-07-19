require 'SecureRandom'

class HeroController < Sinatra::Base

	options "*" do
    response.headers["Allow"] = "HEAD,GET,POST,PUT,PATCH,DELETE,OPTIONS"

    # Needed for AngularJS
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
    response['Access-Control-Allow-Origin'] = '*'

    "cool"
  end

	get '/' do
		response['Access-Control-Allow-Origin']= '*'
		content_type :json
        heroes = Hero.all.sort_by {|hero| hero.id}
		heroes.to_json
	end

	get '/:id' do
		response['Access-Control-Allow-Origin'] = '*'
    	content_type :json
    	id = params[:id]
    	hero = Hero.find(id)
    	hero.to_json
	end

	post '/' do
		response['Access-Control-Allow-Origin'] = '*'
    	content_type :json
    	hero_props = JSON.parse(request.body.read)
    	puts hero_props
    	hero = Hero.new(hero_props)
    	hero.save
    	hero.to_json
	end

	patch '/:id' do
		response['Access-Control-Allow-Origin'] = '*'
    	content_type :json
    	id = params[:id]
    	hero = Hero.find(id)
    	hero_props = JSON.parse(request.body.read)
    	hero.update_attributes(hero_props)
    	hero.save
        heroes = Hero.all.sort_by {|hero| hero.id}
        heroes.to_json

	end

	delete '/:id' do
		response['Access-Control-Allow-Origin'] = '*'
    	content_type :json
    	id = params[:id]
    	hero = Hero.find(id)
    	hero.destroy
    	heroes = Hero.all.sort_by {|hero| hero.id}
        heroes.to_json
	end


end