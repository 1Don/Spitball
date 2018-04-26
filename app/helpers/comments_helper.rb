module CommentsHelper
	def comments_tree_for(replies, nested = false, id = nil)

    replies.map do |comment, nested_comments|
			content_tag(:div, id: id, class: "comment #{nested ? 'collapse' : 'list-group-item'}") do
				render(comment) +
				(nested_comments.size > 0 ? render('comments/show_replies', collapse_id: "comment_#{comment.id}") + comments_tree_for(nested_comments, true, "comment_#{comment.id}") : nil)
			end
    end.join.html_safe
  end
end
