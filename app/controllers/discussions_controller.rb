class DiscussionsController < ApplicationController

	def index
		@discussions = Discussion.all.paginate(page: params[:page], per_page: 20)
	end

	def new 
		@discussion = Discussion.new
	end

	def destroy
	end

	def update
		if discussion.update
			redirect_to @discussion
		else
			flash[]
			render 'edit'
		end
	end

	def create
		if params[:discussion][:parent_id].to_i > 0
		    parent = Discussion.find_by_id(params[:discussion].delete(:parent_id))
		    @discussion = parent.children.build(discussion_params)
		    discussion_id = parent.id

	  	else
	    	@discussion = Discussion.create(discussion_params)
	  	end
			@discussion.user_id = current_user.id
	 	if @discussion.save
		    flash[:success] = 'Your thread was successfully added!'
<<<<<<< HEAD
		    redirect_to discussion_path (@discussion)
=======
		    redirect_to discussion_path (@discussion.parent)
>>>>>>> bd9ffc3797c58417ac0ba03838420129cec64ecd
	  	else
	  		@error = @comment.errors.full_messages
	    	render 'new'
	    end
	end

	def upvote
		@discussion = Discussion.find(params[:id])
	  	@discussion.upvote_by current_user
	  	redirect_to @discussion
	end

	def show
		@discussion = Discussion.find(params[:id])
<<<<<<< HEAD
		@replies = @discussion.hash_tree
=======
		@discussions = @discussion.children.all
		@replies = @discussions.hash_tree
>>>>>>> bd9ffc3797c58417ac0ba03838420129cec64ecd
	end


private

	def discussion_params
		params.require(:discussion).permit(:content)
	end	


end
