class Tag < ActiveRecord::Base
  attr_accessible :name, :snippet_id

  belongs_to :snippet
end
