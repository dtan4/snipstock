# -*- coding: utf-8 -*-
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_name(params[:name])

    # user.authenticate is included in bcrypt_ruby
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      redirect_to login_url, alert: "無効なユーザ、パスワードです"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "ログアウトしました"
  end
end
