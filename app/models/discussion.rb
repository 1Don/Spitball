class Discussion < ApplicationRecord
	 acts_as_votable
     belongs_to :user
     acts_as_tree
end
