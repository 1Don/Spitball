User.create!([{name: 'iThompkins', 
			   email: 'isaiah_thompkins@brown.edu', 
			   password: 'foobar', 
			   password_confirmation: 'foobar', 
			   first_name:'Isaiah', 
			   last_name: 'Thompkins',
			   photo_file_name: nil, 
			   photo_content_type: nil, 
			   photo_file_size: nil},

			   {name: 'Nick Morgan', 
			   email: 'nickmorgansc@gmail.com', 
			   password: 'foobar', 
			   password_confirmation: 'foobar', 
			   first_name:'Nick', 
			   last_name: 'Morgan'			   
			   photo_file_name: nil, 
			   photo_content_type: nil, 
			   photo_file_size: nil}])

User.find_by_name("iThompkins").wads.build([{category: "Social Entreprenuerhip", 
											tags: "News, Politics, IMDb", 
											problem_statement: "We need an IMDb for journalists", 
											long_form: "A platform that gives users an opportunity to vet"\
														" and rate current news articles. When users, just as they'd"\
														" cross-reference IMDb before watching a movie, users could"\
														" use the platform to discern fake news from useful news."},

=begin
											{category: "", 
											tags: "", 
											problem_statement: "", 
											long_form: ""}])
=end
