module AnswersHelper
	def answers_tree_for(replies, nested = false, id = nil)
	    replies.map do |answer, nested_answers|
				content_tag(:div, id: id, class: "answer #{nested ? 'collapse' : 'list-group-item'}") do
					render(answer) 
				end
	    end.join.html_safe
 	end

	def reply_tree_for(replies, nested = false, id = nil)
	    replies.map do |answer, nested_answers|
				render(answer) +
          (nested_answers.size > 0 ? content_tag(:div, reply_tree_for(nested_answers), class: "replies") : nil)
	    end.join.html_safe
 	end 	

#Finds discussion for Discussions controller for routes without /answers/:id
	def find_discussion
		@discussion = Discussion.find(params[:id])
	end

#Finds discussions for answers controller for routes with /answers/:id
	def find_answers_discussion
		@discussion = Discussion.find(params[:discussion_id])
	end

#Finds answer for either controller
	def find_answer
		@discussion = Discussion.find(params[:discussion_id])
		@answer = @discussion.answers.find(params[:id])
	end

#Finds the user for linking to their profile
	def find_discussion_owner
		find_answers_discussion
		@owner = @discussion.user
	end
end

