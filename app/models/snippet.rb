class Snippet < ActiveRecord::Base
  attr_accessible :code, :lang, :title, :description, :user_id, :comments

  belongs_to :user

  has_many :comments

  validates :title, :code, presence: true
end
