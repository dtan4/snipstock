class Snippet < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :tags

  belongs_to :user
  has_many :comments

  validates :title, :code, presence: true
  validates :lang, presence: true

  before_destroy :delete_all_related_comments

  private
  def delete_all_related_comments
    comments = Comment.where('snippet_id = ?', self.id)

    comments.each do |comment|
      comment.destroy
    end
  end
end
