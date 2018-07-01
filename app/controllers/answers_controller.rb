class AnswersController < ApplicationController
	layout 'wad', only: [:index]
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
  		unless @answer.user == @discussion.user
			Notification.create(recipient: @discussion.user, actor: current_user, action: "commented", notifiable: @discussion)
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
		if @answer.update(params[:answer].permit(:content, :id))
			redirect_to discussion_path(@discussion)
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
		unless current_user != nil
			@answer = Answer.find(params[:discussion_id])
			@discussion = @comment.discussion
			@answer.upvote_by current_user
			redirect_to discussion_path(@discussion)
		end
		redirect_to action: "index"

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


