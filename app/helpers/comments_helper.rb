module CommentsHelper
	def comments_tree_for(replies, nested = false, id = nil)
	    replies.map do |comment, nested_comments|
				content_tag(:div, id: id, class: "comment mb-1 border-bottom") do
					render(comment) 
				end
	    end.join.html_safe
 	end

	def reply_tree_for(replies, nested = false, id = nil)
	    replies.map do |comment, nested_comments|
				render(comment) +
          (nested_comments.size > 0 ? content_tag(:div, reply_tree_for(nested_comments), class: "replies") : nil)
	    end.join.html_safe
 	end 	
end