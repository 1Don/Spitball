class CommentsController < ApplicationController
	layout 'wad', only: [:index]
	before_action :find_comments_wad, only: [:index, :create, :new, :edit, :update, :destroy, :find_comment]
	before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner, :comment_params]
	before_action :comment_owner, only: [:destroy, :edit, :update]
	before_action :find_wad_owner, only: [:index]

	def create
		if params[:comment][:parent_id].to_i > 0
	    parent = Comment.find_by_id(params[:comment].delete(:parent_id))
	    @comment = parent.children.build(comment_params)
	    wad_id = parent.id

  	else
    	@comment = @wad.comments.build(comment_params)
  	end

		@comment.user_id = current_user.id

	 	unless @comment.save
  		@error = @comment.errors.full_messages
    	render 'new'
    end
	end

	def index
		@comments = @wad.comments.all
		@comment = @wad.comments.where(params[:id])
		@replies = @comments.hash_tree
	end


	def new
		if current_user != nil
			@comment = Comment.new(parent_id: params[:parent_id], wad_id: params[:wad_id])
		end
		redirect_to root_path
	end

	def show
		@comment = @comments.find_by(params[:id])
	end


	def edit
		if current_user != nil
			@comment = Comment.find(params[:id])
		end
		redirect_to root_path
	end

	def update
		unless current_user == @comment.user
			if @comment.update(params[:comment].permit(:content, :id))
				redirect_to wad_path(@wad)
			else
				render 'edit'
			end
		end
		redirect_to wad_path(@wad)
	end

	def destroy
		unless current_user == @comment.user
			@comment.destroy
			redirect_to @wad
		end
		redirect_to @wad
	end

	def upvote
		unless current_user != nil
			@comment = Comment.find(params[:wad_id])
			@wad = @comment.wad
			@comment.upvote_by current_user
			redirect_to wad_path(@wad)
		end
		redirect_to @wad

	end


private

	def comment_params
		params.require(:comment).permit(:content, :wad_id, :user_id, :parent_id)
	end


	def comment_owner
		unless current_user.id == @comment.user_id
			flash[:notice] = "Action Restricted"
			redirect_to @wad
		end
	end

end
