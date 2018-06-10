class DiscussionsController < ApplicationController
	layout 'wad', only: [:index, :show]

	def index
			@discussions = Discussion.all.paginate(page: params[:page], per_page: 20)
	end

	def show
			@all_discussions = Discussion.all
			@discussion = Discussion.find(params[:id])
			@discussions = @discussion.children.all
			@replies = @discussions.hash_tree
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
	 		current_user.update_attributes(points: current_user.points + 50)
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
	  	current_user.update_attributes(points: current_user.points + 5)
	  	@discussion.user.update_attributes(points: @discussion.user.points + 15)  
	  	redirect_to @discussion
	end


	def solved
		@discussion = Discussion.find(params[:id])
		@discussion.toggle!(:resolved)
	end


private

	def discussion_params
		params.require(:discussion).permit(:content)
	end


end
