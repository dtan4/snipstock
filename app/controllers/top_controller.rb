class TopController < ApplicationController
  def index
    @snippet = Snippet.new
  end
end
