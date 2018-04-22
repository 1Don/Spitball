class IndustriesController < ApplicationController
before_action :find_wad, only: [:show, :edit, :update, :destroy, :upvote]
layout 'wad'

def index
	redirect_to wads_path
end

def art
	@wads = Wad.where("category like ?", "%art%").paginate(page: params[:page], per_page: 20)
	render 'industries'
end

def b2bsaas
	@wads = Wad.where("category like ?", "%b2b saas%").paginate(page: params[:page], per_page: 20)
	render 'industries'
end

def finance
	@wads = Wad.where("category like ?", "%finance%").paginate(page: params[:page], per_page: 20)
	render 'industries'
end

def manufacturing
	@wads = Wad.where("category like ?", "%manufacturing%").paginate(page: params[:page], per_page: 20)
	render 'industries'
end

def smallbusiness
	@wads = Wad.where("category like ?", "%small business%").paginate(page: params[:page], per_page: 20)
	render 'industries'
end

def consumertech
	@wads = Wad.where("category like ?", "%consumer tech%").paginate(page: params[:page], per_page: 20)
	render 'industries'
end


def other
	@wads = Wad.where("category like ?", "%other%").paginate(page: params[:page], per_page: 20)
	render 'industries'
end


private

def find_wad
	@wad = Wad.find(params[:id])
end

end
