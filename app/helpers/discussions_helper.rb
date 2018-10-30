module DiscussionsHelper
	def discussions_tree_for(discussions)
    	discussions.map do |discussions, nested_discussions|
	      render(discussions) +
	          (nested_discussions.size > 0 ? content_tag(:div, discussions_tree_for(nested_discussions), class: "replies") : nil)
	    end.join.html_safe
  	end


  	def discussions_bar
	  	[
	      {
	        link: "/testing",
	        name: "Prototyping and Testing"
	      },

	      {
	        link: "/teambuilding",
	        name: "Teambuilding"
	      },

	      {
	        link: "/fundraising",
	        name: "Fundraising"
	      },

	      {
	        link: "/marketing",
	        name: "Marketing"
	      },
	      
	      {
	        link: "/legal",
	        name: "Legal"
	      },
	      {
	        link: "/industry",
	        name: "Industry Related"
	      },
	      {
	        link: "/other",
	        name: "Other"
	      }
	    ]

  	end



end
