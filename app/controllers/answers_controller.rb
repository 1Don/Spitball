class AnswersController < ApplicationController
	layout 'discussion', only: [:index]
	before_action :find_answers_discussion, only: [:index, :create, :new, :edit, :update, :destroy, :find_comment]
	before_action :find_answer, only: [:destroy, :edit, :update, :comment_owner, :comment_params]
	before_action :answer_owner, only: [:destroy, :edit, :update]

	def create
		if params[:answer][:parent_id].to_i > 0
	    	parent = Answer.find_by_id(params[:answer].delete(:parent_id))
	    	@answer = parent.children.build(answer_params)
	    	discussion_id = parent.id
  		else
    		@answer = @discussion.answers.build(answer_params)
  		end
  		unless current_user == @discussion.user
			Notification.create(recipient: @discussion.user, actor: current_user, action: "answered", notifiable: @discussion)
		end
			@answer.user_id = current_user.id
   			current_user.update_attributes(points: current_user.points + 20)
	 	unless @answer.save
  			@error = @answer.errors.full_messages
    		render 'new'
    	end
	end

	def index
		@discussion = Discussion.find(params[:discussion_id])
		@answers = @discussion.answers.all
		@answer = Answer.new(parent_id: params[:parent_id], discussion_id: params[:discussion_id])
		@answers.each do |ans|
			if ans.solution
				@solution = ans
			else
				@solution = nil
			end 
		end 
		@replies = @answers.hash_tree
	end


	def new
		@answer = Answer.new(parent_id: params[:parent_id], discussion_id: params[:discussion_id])
	end

	def show
		@answer = @answers.find_by(params[:id])
	end


	def edit
		if current_user != nil
			@answer = Answer.find(params[:id])
		end
		redirect_to root_path
	end

	def update
		if current_user == @discussion.user
			if @answer.solution == false || @answer.solution == nil
				@answer.update(solution: true)
			elsif @answer.solution == true
				@answer.update(solution: false)
			end
		else
			render 'edit'
		end
	end

	def destroy
		if current_user == @answer.user
			@answer.destroy
			current_user.update_attributes(points: current_user.points - 20)
		end
	end

	def upvote
		unless current_user.nil?
			@answer = Answer.find(params[:answer_id])
			@discussion = @answer.discussion
			@answer.upvote_by current_user
			current_user.update_attributes(points: current_user.points + 5)
	  		@answer.user.update_attributes(points: @answer.user.points + 10) 
	  		if @answer.get_upvotes.size % 5 == 0
				@comment.user.update_attributes(points: @answer.user.points + 100)
			end 
		end
	end
	def downvote
		unless current_user.nil?
			@answer = Answer.find(params[:answer_id])
			@discussion = @answer.discussion
			@answer.downvote_by current_user
			current_user.update_attributes(points: current_user.points - 5)
	  		@answer.user.update_attributes(points: @answer.user.points - 10) 
		end
	end
	def solved
		@discussion = Discussion.find(params[:discussion_id])
		@discussion.toggle!(:resolved)
	end



private

	def answer_params
		params.require(:answer).permit(:content, :discussion_id, :user_id, :parent_id)
	end


	def answer_owner
		unless current_user.id == @answer.user_id
			flash[:notice] = "Action Restricted"
			redirect_to @discussion
		end
	end

end


