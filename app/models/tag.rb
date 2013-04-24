class Tag < ActiveRecord::Base
  attr_accessible :name, :snippet_id

  belong_to :snippet
end
