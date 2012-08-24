class SearchController < ApplicationController
  def search
    @results = Video.search(params[:query], :per_page => 10000)
  end

  def add_advanced
    @users = User.all
    @categories = Category.roots
  end
end
