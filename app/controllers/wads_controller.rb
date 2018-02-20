class WadsController < ApplicationController
before_action :find_wad, only: [:show, :edit, :update, :destroy, :upvote]

	def index
		@wads = Wad.all.paginate(page: params[:page], per_page: 20)
	end

	def show
		@wad = Wad.find(params[:id])
		@comments = Comment.where(wad_id: @wad).order("created_at DESC")
		@comment = Comment.find_by(params[:id])
		@replies = @wad.comments.hash_tree
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
		@wad.destroy
		redirect_to root_path
	end


	private

	def wad_params
		params.require(:wad).permit(:problem_state, :short_form, :long_form, :category)
	end	

	def find_wad
		@wad = Wad.where(params[:id])
	end


end

