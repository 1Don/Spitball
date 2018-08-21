class Flag < ApplicationRecord
  belongs_to :user
  belongs_to :wad
  belongs_to :comment
  belongs_to :discussion
  belongs_to :answer
end
