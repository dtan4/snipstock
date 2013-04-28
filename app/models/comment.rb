class Comment < ActiveRecord::Base
  attr_accessible :description, :snippet_id, :user_id

  belongs_to :snippet
  belongs_to :user

  validates :description, presence: true
end
