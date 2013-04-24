class Snippet < ActiveRecord::Base
  attr_accessible :code, :lang, :title, :description, :user_id

  belong_to id
  has_many :comments
  has_many :snippets
end
