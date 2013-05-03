# -*- coding: utf-8 -*-
class SnippetsController < ApplicationController
  skip_before_filter :authorize, only: [:index, :show, :search, :langs, :tags]

  # GET /snippets
  # GET /snippets.json
  def index
    @snippets = Snippet.where(private: false).paginate(page: params[:page], order: 'updated_at desc', per_page: 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @snippets }
    end
  end

  # GET /snippets/1
  # GET /snippets/1.json
  def show
    @snippet = Snippet.find(params[:id])
    @comment = @snippet.comments.build
    @author = User.find(@snippet.user_id)

    if @login_user.nil? ||
        (@snippet.private && (@snippet.user_id != @login_user.id))
      redirect_to snippets_url, alert: "このスニペットは非公開です"
      return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @snippet }
    end
  end

  def search
    @snippets = Snippet.where('title like ? or description like ? or code like ?', "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
      .paginate(page: params[:page], order: 'updated_at desc', per_page: 10)

    respond_to do |format|
      format.html { render action: 'index' }
      format.json { render @snippets }
    end
  end

  def langs
    @snippets = Snippet.where('lang like ?', "%#{params[:lang]}%")
      .paginate(page: params[:page], order: 'updated_at desc', per_page: 10)

    respond_to do |format|
      format.html { render action: 'index' }
      format.json { render @snippets }
    end
  end

  def tags
    tag = params[:tag]
    @snippets = Snippet.tagged_with(tag)
      .paginate(page: params[:page], order: 'updated_at desc', per_page: 10)

    respond_to do |format|
      format.html { render action: 'index' }
      format.json { render @snippets }
    end
  end

  # GET /snippets/new
  # GET /snippets/new.json
  def new
    @snippet = Snippet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @snippet }
    end
  end

  # GET /snippets/1/edit
  def edit
    @snippet = Snippet.find(params[:id])
    check_snippet_author
  end

  # POST /snippets
  # POST /snippets.json
  def create
    @snippet = Snippet.new(params[:snippet])
    @snippet.user_id = @login_user.id

    respond_to do |format|
      if @snippet.save
        format.html { redirect_to @snippet, notice: 'Snippet was successfully created.' }
        format.json { render json: @snippet, status: :created, location: @snippet }
      else
        format.html { render action: "new" }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /snippets/1
  # PUT /snippets/1.json
  def update
    @snippet = Snippet.find(params[:id])
    check_snippet_author

    respond_to do |format|
      if @snippet.update_attributes(params[:snippet])
        format.html { redirect_to @snippet, notice: 'Snippet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snippets/1
  # DELETE /snippets/1.json
  def destroy
    @snippet = Snippet.find(params[:id])
    check_snippet_author
    @snippet.destroy

    respond_to do |format|
      format.html { redirect_to snippets_url }
      format.json { head :no_content }
    end
  end

  private
  # FIXME: multiple redirect is occured
  def check_snippet_author
    unless @snippet.user_id == @login_user.id
      if session[:user_id].nil?
        redirect_to login_url, notice: "ログインしてください"
      else
        redirect_to @snippet, alert: "作成者以外は編集できません"
      end
    end
  end
end
