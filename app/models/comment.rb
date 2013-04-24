class Comment < ActiveRecord::Base
  attr_accessible :description, :snippet_id, :user_id

  belong_to :snippet
  belong_to :user
end
