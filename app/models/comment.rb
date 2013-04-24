class Comment < ActiveRecord::Base
  attr_accessible :description, :snippet_id, :user_id
end
