class Snippet < ActiveRecord::Base
  attr_accessible :code, :lang, :title, :description, :user_id, :comments, :tags, :tag_list, :created_at

  acts_as_taggable
  acts_as_taggable_on :tags

  belongs_to :user
  has_many :comments

  validates :title, :code, presence: true
end
