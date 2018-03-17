module DiscussionsHelper
	def discussions_tree_for(discussions)
    discussions.map do |discussions, nested_discussions|
      render(discussions) +
          (nested_discussions.size > 0 ? content_tag(:div, discussions_tree_for(nested_discussions), class: "replies") : nil)
    end.join.html_safe
  end
end
