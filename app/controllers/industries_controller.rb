class IndustriesController < ApplicationController
before_action :find_wad, only: [:show, :edit, :update, :destroy, :upvote]
layout 'wad'

def index
	redirect_to wads_path
end

def tech
	@wads = Wad.where("category like ?", "%Consumer tech%").paginate(page: params[:page], per_page: 20)
	render 'industries'
end

def b2b
	@wads = Wad.where("category like ?", "%B2b tech%").paginate(page: params[:page], per_page: 20)
	render 'industries'
end

def media
	@wads = Wad.where("category like ?", "%Media and Entertainment%").paginate(page: params[:page], per_page: 20)
	render 'industries'
end

def social
	@wads = Wad.where("category like ?", "%Social Entrepreneurship%").paginate(page: params[:page], per_page: 20)
	render 'industries'
end

def local
	@wads = Wad.where("category like ?", "%Location Specific%").paginate(page: params[:page], per_page: 20)
	render 'industries'
end

def product
	@wads = Wad.where("category like ?", "%Consumer products%").paginate(page: params[:page], per_page: 20)
	render 'industries'
end


def innovate
	@wads = Wad.where("category like ?", "%Avant-Garde%").paginate(page: params[:page], per_page: 20)
	render 'industries'
end

def events
	@wads = Wad.where("category like ?", "%Events%").paginate(page: params[:page], per_page: 20)
	render 'industries'
end



private

def find_wad
	@wad = Wad.find(params[:id])
end

end
