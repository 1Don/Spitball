class IndustriesController < ApplicationController
before_action :find_wad, only: [:show, :edit, :update, :destroy, :upvote]

def art
	@wads = Wad.where("category like ?", "%art%").paginate(page: params[:page], per_page: 20)
end

def b2bsaas
	@wads = Wad.where("category like ?", "%b2b saas%").paginate(page: params[:page], per_page: 20)
end

def finance
	@wads = Wad.where("category like ?", "%finance%").paginate(page: params[:page], per_page: 20)
end

def manufacturing
	@wads = Wad.where("category like ?", "%manufacturing%").paginate(page: params[:page], per_page: 20)
end

def smallbusiness
	@wads = Wad.where("category like ?", "%small business%").paginate(page: params[:page], per_page: 20)
end

def consumertech
	@wads = Wad.where("category like ?", "%consumer tech%").paginate(page: params[:page], per_page: 20)
end


def other
	@wads = Wad.where("category like ?", "%other%").paginate(page: params[:page], per_page: 20)
end


private

def find_wad
	@wad = Wad.find(params[:id])
end

end
