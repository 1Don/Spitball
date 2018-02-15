class CommentsController < ApplicationController
#	before_action :find_wad, only: [:create, :new, :edit, :update, :destroy, :find_comment]
#	before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner]
	before_action :comment_owner, only: [:destroy, :edit, :update]

	def index
		@wad = Wad.find(params[:wad_id])
		@comments = Comment.where(wad_id: @wad).order("created_at DESC")
#		@comments.hash_tree
	end

	def new
	   @wad = Wad.find(params[:wad_id])
	   @comment = Comment.new(parent_id: params[:parent_id], wad_id: params[:wad_id])
	end

	def create
	 @wad = Wad.find(params[:wad_id])
	  if params[:comment][:parent_id].to_i > 0
	    parent = Comment.find_by_id(params[:comment].delete(:parent_id))
	    @comment = parent.children.build(comment_params)
	    wad_id = parent.id
	  else
	    @comment = @wad.comments.create(comment_params)
	  end
	
		@comment.user_id = current_user.id
	  if @comment.save
			flash[:sucess] = "Thanks for posting!"
			redirect_to wad_path(@wad)
	  else
	  		@error = @comment.errors.full_messages
			flash[:error] = "Failed submission: #{@error}.Please try again."			
			render 'index'
	  end
	end

	def edit
		@wad = Wad.find(params[:wad_id])
		@comment = Comment.find(params[:id])
	end

	def update
		@wad = Wad.find(params[:wad_id])
		@comment = Comment.find(params[:id])
		if @comment.update(comment_params)
			redirect_to wad_path(@wad)
		else 
			render 'edit'
		end
	end 
	
	def destroy
		@wad = Wad.find(params[:wad_id])
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to wad_comments_path(@wad)
	end


	def upvote 
	  @comment = Comment.find(params[:id])
	  @wad = @comment.wad
	  @comment.upvote_by current_user
	  redirect_to wad_comments_path(@wad)
	end  

	def downvote
	  @comment = Comment.find(params[:id])
	  @wad = @comment.wad
	  @comment.downvote_by current_user
	  redirect_to wad_comments_path(@wad)
	end

private

	def comment_params
		params.require(:comment).permit(:content, :wad_id, :parent_id)
	end
	
	def find_wad
		@wad = Wad.where(params[:id])
	end
	
	def find_comment
		@comment = @wad.comments.find_by(params[:wad_id])	
	end

	def comment_owner
		@comment = Comment.find(params[:id])
		unless current_user.id == @comment.user_id
			flash[:notice] = "Action Restricted"
			redirect_to @wad

		end
	end
end