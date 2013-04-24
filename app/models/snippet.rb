class Snippet < ActiveRecord::Base
  attr_accessible :code, :lang, :title, :description, :user_id

  belongs_to :user

  has_many :comments
  has_many :tags

  validates :title, :code, presence: true
end
