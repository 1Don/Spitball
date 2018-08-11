class DiscussionsController < ApplicationController
	layout 'discussion', only: [:index, :fundraising, :teambuilding, :mentorship, :marketing, :entityformation, :unicorns, :random, :other]

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
	  	@discussion.user.update_attributes(points: @discussion.user.points + 10)  
	  	
	  	if @discussion.get_upvotes.size % 5 == 0
				@discussion.user.update_attributes(points: @discussion.user.points + 100)
		end
	end

	def downvote
		@discussion = Discussion.find(params[:id])
	  	@discussion.downvote_by current_user
	  	current_user.update_attributes(points: current_user.points - 5)
	  	@discussion.user.update_attributes(points: @discussion.user.points - 10)  
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

#Question types
	def fundraising
		@discussions = Discussion.where("category like ?", "%Fundraising%").paginate(page: params[:page], per_page: 20)
	end

	def teambuilding
		@discussions = Discussion.where("category like ?", "%Building A Team%").paginate(page: params[:page], per_page: 20)
	end

	def mentorship
		@discussions = Discussion.where("category like ?", "%How To Find A Mentor%").paginate(page: params[:page], per_page: 20)
	end

	def marketing
		@discussions = Discussion.where("category like ?", "%Marketing%").paginate(page: params[:page], per_page: 20)
	end

	def entityformation
		@discussions = Discussion.where("category like ?", "%Legal Registration%").paginate(page: params[:page], per_page: 20)
	end

	def unicorns
		@discussions = Discussion.where("category like ?", "%How Did That Other Company Do It%").paginate(page: params[:page], per_page: 20)
	end


	def random
		@discussions = Discussion.where("category like ?", "%Random%").paginate(page: params[:page], per_page: 20)
	end

	def other
		@discussions = Discussion.where("category like ?", "%Other%").paginate(page: params[:page], per_page: 20)
	end


private

	def discussion_params
		params.require(:discussion).permit(:content, :category)
	end


end
