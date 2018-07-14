class DiscussionsController < ApplicationController
	layout 'discussion', only: [:index]

	def index
			@discussions = Discussion.all.paginate(page: params[:page], per_page: 20)
	end

	def show
			@all_discussions = Discussion.all
			@discussion = Discussion.find(params[:id])
	end

	def new
			@discussion = Discussion.new
	end

	def destroy
		@discussion = Discussion.find(params[:id])
		if current_user == @discussion.user
				@discussion.destroy
				current_user.update_attributes(points: current_user.points - 50)
				redirect_to discussions_path
			end
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
			@discussion = current_user.discussions.build(discussion_params)
		if @discussion.save
    		current_user.update_attributes(points: current_user.points + 50)
   			 redirect_to discussion_answers_path(@discussion)
		else
			flash[:error] = 'Error try again'
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
		@answer = Answer.find(params[:answer_id])
		@discussion = Discussion.find(params[:id])
		if current_user == @discussion.user
			@discussion.toggle!(:resolved)
			if @discussion.resolved ==  true
				@answer.update(solution: true)
			else
				@answer.update(solution: false)
			end
		end
	end


private

	def discussion_params
		params.require(:discussion).permit(:content)
	end


end
