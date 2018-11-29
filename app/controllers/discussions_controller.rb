class DiscussionsController < ApplicationController
	layout 'discussion', only: [:index, :testing, :fundraising, :marketing, :teambuilding, :legal, :industry, :other]
	before_action :require_login
	before_action :set_new_discusion, only: [:index, :testing, :fundraising, :marketing, :teambuilding, :legal, :industry, :other]
	before_action :all_discussions

	def index
			@discussions = Discussion.all.order('created_at DESC')
	end

	def create_answer
		@discussion = Discussion.find(params[:discussion_id])
		@answer = current_user.answers.create(content: params[:content], discussion_id: @discussion.id)
		@answer.save
		unless @discussion.user == current_user
			Notification.create(recipient: @discussion.user, actor: current_user, action: "answered", notifiable: @discussion)
		end
	end

	def show
			redirect_to discussions_path
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

	def flag
		unless current_user.flags.find_by(discussion_id: params[:id])
			flag = current_user.flags.build(discussion_id: params[:id])
			flag.save
			AdminMailer.flag_notice(wad_path(Discussion.find(params[:id]))).deliver_now
		end
	end

#Question types
	def fundraising
		@discussions = Discussion.where("category like ?", "%Fundraising%").paginate(page: params[:page], per_page: 20)
	end

	def testing
		@discussions = Discussion.where("category like ?", "%Prototyping and Testing%").paginate(page: params[:page], per_page: 20)
	end

	def marketing
		@discussions = Discussion.where("category like ?", "%Marketing%").paginate(page: params[:page], per_page: 20)
	end

	def teambuilding
		@discussions = Discussion.where("category like ?", "%Teambuilding%").paginate(page: params[:page], per_page: 20)
	end

	def legal
		@discussions = Discussion.where("category like ?", "%Legal%").paginate(page: params[:page], per_page: 20)
	end

	def industry
		@discussions = Discussion.where("category like ?", "%Industry Related%").paginate(page: params[:page], per_page: 20)
	end


	def other
		@discussions = Discussion.where("category like ?", "%Other%").paginate(page: params[:page], per_page: 20)
	end


private

	def discussion_params
		params.require(:discussion).permit(:content, :category, :title)
	end


	def set_new_discusion
		@discussion = Discussion.new
	end

	def all_discussions
		@all_discussions = Discussion.all
	end


end
