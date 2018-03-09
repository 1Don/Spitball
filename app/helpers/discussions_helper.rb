module DiscussionsHelper
	def discussions_tree_for(discussions)
    discussions.map do |discussion, nested_discussions|
      render(discussion) +
          (nested_discussions.size > 0 ? content_tag(:div, discussions_tree_for(nested_discussions), class: "replies") : nil)
    end.join.html_safe
  end
end
