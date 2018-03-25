class PagesController < ApplicationController
  def home
  end

  def ranking
    @users = User.page(params[:page]).order('score desc')
  end
end
