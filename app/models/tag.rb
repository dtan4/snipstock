class Tag < ActiveRecord::Base
  attr_accessible :name, :snippet_id

  has_and_belongs_to_many :snippet
end
