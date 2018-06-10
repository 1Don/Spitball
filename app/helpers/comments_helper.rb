module CommentsHelper
	def comments_tree_for(replies, nested = false, id = nil)
	    replies.map do |comment, nested_comments|
				content_tag(:div, id: id, class: "comment #{nested ? 'collapse' : 'list-group-item'}") do
					render(comment) 
				end
	    end.join.html_safe
 	end
end