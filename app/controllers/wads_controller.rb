class WadsController < ApplicationController
#	before_action :find_wad
	before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner]
	before_action :comment_owner, only: [:destroy, :edit, :update]
	
	def index
		find_wad
		@wads = Wad.all.paginate(page: params[:page], per_page: 20)
	end

	def show
		@wad = Wad.find(params[:id])
		redirect_to wad_comments_path(@wad)
	    @comments = Comment.where(wad_id: @wad).order("created_at DESC")
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
			redirect_to 'root'
		else
			flash[]
			render 'edit'
		end
	end

	def destroy
		@wad.destroy
		redirect_to root_path
	end

	def upvote
	  @wad = Wad.find(params[:id])
	  @wad.upvote_by current_user
	  redirect_to wad_comments_path(@wad)
	end  

	def downvote
	  @wad = Wad.find(params[:id])
	  @wad.downvote_by current_user
	  redirect_to wad_comments_path(@wad)
	end


	private

	def wad_params
		params.require(:wad).permit(:problem_statement, :short_form, :long_form, :category)
	end	

	def find_wad
		@wad = Wad.find_by(params[:wad_id])
	end


end