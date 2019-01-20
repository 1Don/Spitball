class Collaboration < ApplicationRecord
	belongs_to :wad
	belongs_to :user
end
