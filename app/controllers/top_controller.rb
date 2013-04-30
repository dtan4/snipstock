class TopController < ApplicationController
  skip_before_filter :authorize

  def index
    @snippet = Snippet.new
  end
end
