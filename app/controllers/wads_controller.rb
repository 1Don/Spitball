class WadsController < ApplicationController
	layout 'wad', only: [:index]

	before_action :find_wad, only: [:show, :edit, :update, :destroy, :upvote]


	def index
		if current_user != nil
		 	@wads = Wad.all.paginate(page: params[:page], per_page: 20)
		 else
		 	redirect_to root_path
		 end
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
			redirect_to @wad
		else
			flash[:error] = 'Error try again'
			render 'new'
		end
	end
	def edit
		if current_user != nil
		end
		redirect_to root_path
	end
	def update
		if current_user != nil
			if @wad.update
				redirect_to @wad
			else
				flash[]
				render 'edit'
			end
		end
	end
	def destroy
		if current_user != nil
			if current_user == @wad.user
				@wad.destroy
				redirect_to wads_path
			else
				flash[:error] = "YOU CANNOT DELETE OTHERS' WADS"
			end
		end
	end

#Voting Functionality
	def upvote 
		if current_user != nil
			@wad = Wad.find(params[:id])
			@wad.upvote_by current_user
			redirect_to @wad
		 end
		else
			redirect_to root_path
	end

	def report
	end

#Search Bar functionality
	def search
		@wads = Wad.all
		if params[:search]
			@wads = Wad.search(params[:search]).order("created_at DESC")
		else
			@wads = Wad.all.order("created_at DESC")
		end
	end



	private

	def wad_params
		params.require(:wad).permit(:problem_state, :short_form, :long_form, :category, :image)
	end


end
