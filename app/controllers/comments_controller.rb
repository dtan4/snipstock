# -*- coding: utf-8 -*-
class CommentsController < ApplicationController
  before_filter :load_snippet
  skip_before_filter :authorize, only: [:index, :show]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = @snippet.comments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = @snippet.comments.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = @snippet.comments.find(params[:id])
    check_comment_author
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @snippet.comments.build(params[:comment])
    @comment.user_id = @login_user.id

    respond_to do |format|
      if @comment.save
        format.js
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = @snippet.comments.find(params[:id])
    check_comment_author

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to [@snippet, @comment], notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = @snippet.comments.find(params[:id])
    check_comment_author

    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

  private
  def load_snippet
    @snippet = Snippet.find(params[:snippet_id])
  end

  def check_comment_author
    unless @comment.user_id == @login_user.id
      if session[:user_id].nil?
        redirect_to login_url, notice: "ログインしてください"
      else
        redirect_to @snippet, alert: "作成者以外は編集できません"
      end
    end
  end
end
