class WadsController < ApplicationController
	layout 'wad', only: [:index, :popwads]

	before_action :find_wad, only: [:show, :edit, :update, :destroy, :upvote]


	def index
		 	@wads = Wad.all.paginate(page: params[:page], per_page: 20)
		 	@rankedwads = Wad.order(cached_votes_total: :desc)
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
			@wad.user.update_attributes(points: @wad.user.points + 15)  
			redirect_to @wad
			
	end

	def report
	end


#Search Bar functionality
	def search
		@wads = Wad.all
		if params[:search]
			@wads = Wad.search(params[:search]).order("created_at DESC")
			@discussions = Discussion.all
			@discussion = Discussion.find_by(params[:id])
		else
			@wads = Wad.all.order("created_at DESC")
		end
	end



	private

	def wad_params
		params.require(:wad).permit(:problem_state, :long_form, :category, :image, :tags)
	end


end
