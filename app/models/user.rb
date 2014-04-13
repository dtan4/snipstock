# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  has_many :snippets
  has_many :comments

  validates :name, presence: true, uniqueness:true, format: {
    with: /\A[0-9a-zA-Z]+\z/,
    message: "は半角英数字で入力してください"
  }
  validates :password, length: { minimum: 8 }
  has_secure_password

  before_destroy :delete_all_related
  after_destroy :ensure_a_user_remains

  private
  def ensure_a_user_remains
    raise "Cannot delete the last user." if User.count.zero?
  end

  def delete_all_related
    snippets = Snippet.where('user_id = ?', self.id)

    snippets.each do |snippet|
      snippet.destroy
    end

    comments = Comment.where('user_id = ?', self.id)
    binding.pry

    comments.each do |comment|
      comment.destroy
    end
  end
end
