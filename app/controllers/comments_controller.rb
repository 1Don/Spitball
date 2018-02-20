class CommentsController < ApplicationController
	before_action :find_wad, only: [:create, :new, :edit, :update, :destroy, :find_comment, :upvote]
	before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner, :comment_params]
	before_action :comment_owner, only: [:destroy, :edit, :update]

	def create
		@wad = Wad.find_by(params[:wad_id])
		if params[:comment][:parent_id].to_i > 0
		    parent = Comment.find_by_id(params[:comment].delete(:parent_id))
		    @comment = parent.children.build(comment_params)
		    wad_id = parent.id

	  	else
	    	@comment = @wad.comments.build(comment_params)
	  	end
			@comment.user_id = current_user.id
	 	if @comment.save
		    flash[:success] = 'Your comment was successfully added!'
		    redirect_to wad_comments_path (@wad)
	  	else
	  		@error = @comment.errors.full_messages
	    	render 'new'
	    end
	end

	def index
		@wad = Wad.find(params[:wad_id])
		@comments = @wad.comments.all
		@comment = @wad.comments.where(params[:id])
		@replies = @comments.hash_tree
	end


	def new
		@comment = Comment.new(parent_id: params[:parent_id], wad_id: params[:wad_id])
	end
		
	def show
		@comment = @comments.find_by(params[:id])
	end


	def edit
		@comment = Comment.find(params[:id])
	end

	def update
		if @comment.update(params[:comment].permit(:content, :id))
			redirect_to wad_path(@wad)
		else
			render 'edit'
		end
	end

	def destroy
		@wad = Wad.find(params[:wad_id])
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to @wad
	end


private

	def find_wad
		@wad = Wad.find_by(params[:id])
	end

	def find_comment
		@comment = @wad.comments.find_by(params[:id])
	end

	def comment_params
		params.require(:comment).permit(:content, :wad_id, :user_id)
	end


	def comment_owner
		unless current_user.id == @comment.user_id
			flash[:notice] = "Action Restricted"
			redirect_to @wad

		end
	end
end
