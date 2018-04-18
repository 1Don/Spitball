class DiscussionsController < ApplicationController

	def index
		unless current_user != nil
			@discussions = Discussion.all.paginate(page: params[:page], per_page: 20)
		end
		redirect_to root_path
	end

	def new 
		unless current_user != nil
			@discussion = Discussion.new
		end
		redirect_to root_path
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

		    if @discussion.parent_id == nil

		    	redirect_to discussion_path (@discussion)
			else 
				redirect_to discussion_path (@discussion.parent)
			end


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
		@all_discussions = Discussion.all
		@discussion = Discussion.find(params[:id])
		@discussions = @discussion.children.all
		@replies = @discussions.hash_tree
	end


private

	def discussion_params
		params.require(:discussion).permit(:content)
	end	


end
