class WadsController < ApplicationController
	layout 'wad', only: [:index, :popwads, :b2b, :consumertech, :media, :social, :product, :innovate, :events, :local]
	before_action :find_wad, only: [:show, :edit, :update, :destroy, :upvote]


	def index
		@comment = Comment.new
	 	@wads = Wad.all.paginate(page: params[:page], per_page: 20).order('created_at DESC')
    end

    def popwads
		@wads = Wad.all.paginate(page: params[:page], per_page: 20)
		@rankedwads = Wad.order(cached_votes_total: :desc)
	end

	def show
		redirect_to wad_comments_path(@wad)
	end

	def new
		@wad = Wad.new
	end

	def create
		@wad = current_user.wads.build(wad_params)
		if @wad.save
    		current_user.update_attributes(points: current_user.points + 50)
   			 redirect_to @wad    
		else
			flash[:error] = 'Error try again'
			render 'new'
		end
	end


	def edit
	end

	def update
			if @wad.update
				redirect_to @wad
			else
				flash[]
				render 'edit'
			end
	end

	def destroy	
			if current_user == @wad.user
				@wad.destroy
				current_user.update_attributes(points: current_user.points - 50)
				redirect_to wads_path
			else
				flash[:error] = "YOU CANNOT DELETE OTHERS' WADS"
			end
	end


	def upvote 
		@wad = Wad.find(params[:id])
		@wad.upvote_by current_user
		current_user.update_attributes(points: current_user.points + 5)  
		@wad.user.update_attributes(points: @wad.user.points + 10)
		unless current_user.voted_for? @wad  
			Notification.create(recipient: @wad.user, actor: current_user, action: "liked", notifiable: @wad)
		end	

		if @wad.get_upvotes.size % 5 == 0
				@wad.user.update_attributes(points: @wad.user.points + 50)

		end
	end

	def unvote
		@wad = Wad.find(params[:id])
		@wad.upvote_by current_user
	end		

	def report
	end

#category views
	def consumertech
		@wads = Wad.where("category like ?", "%Consumer Tech%").paginate(page: params[:page], per_page: 20)
	end

	def b2b
		@wads = Wad.where("category like ?", "%B2B Tech%").paginate(page: params[:page], per_page: 20)
	end

	def media
		@wads = Wad.where("category like ?", "%Media and Entertainment%").paginate(page: params[:page], per_page: 20)
	end

	def social
		@wads = Wad.where("category like ?", "%Social Entrepreneurship%").paginate(page: params[:page], per_page: 20)
	end

	def local
		@wads = Wad.where("category like ?", "%Location Specific%").paginate(page: params[:page], per_page: 20)
	end

	def product
		@wads = Wad.where("category like ?", "%Consumer Products%").paginate(page: params[:page], per_page: 20)
	end


	def innovate
		@wads = Wad.where("category like ?", "%Avant-garde%").paginate(page: params[:page], per_page: 20)
	end

	def events
		@wads = Wad.where("category like ?", "%Events%").paginate(page: params[:page], per_page: 20)
	end

private

	def wad_params
		params.require(:wad).permit(:problem_state, :long_form, :category, :image, :tags)
	end


end
