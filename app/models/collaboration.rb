class Collaboration < ApplicationRecord
	belongs_to :wad
	belongs_to :user
	has_many :buckets
end
