module CommentsHelper
	def comments_tree_for(replies, nested = false)
	    replies.map do |comment, nested_comments|
				content_tag(:div, class: "comment #{'list-group-item' unless nested}") do
					render(comment) +
					(nested_comments.size > 0 ? comments_tree_for(nested_comments, true) : nil)
				end
	    end.join.html_safe
  end
end
