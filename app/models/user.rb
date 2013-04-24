# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :name, :password_digest, :password, :password_confirmation

  has_many :snippets
  has_many :comments
  has_many :tags

  validates :name, presence: true, uniqueness:true, format: {
    with: /^[0-9a-zA-Z]+$/,
    message: "は半角英数字で入力してください"
  }
  validates :password, length: { minimum: 8 }
  has_secure_password
end
