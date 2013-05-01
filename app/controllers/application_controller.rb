# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  before_filter :authorize, :current_user

  protect_from_forgery

  def authorize
    if session[:user_id].nil?
      redirect_to login_url, notice: "ログインしてください"
    end
  end

  def current_user
    @login_user =
      if session[:user_id].nil?
        nil
      else
        User.find_by_id(session[:user_id])
      end
  end
end
