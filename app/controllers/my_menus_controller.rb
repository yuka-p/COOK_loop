class MyMenusController < ApplicationController
  def index
    @my_menus = MyMenu.all
  end

  def show
    @my_menu = MyMenu.find(params[:id])
  end

  def new
    @my_menu = MyMenu.new
  end

  def edit
    @my_menu = MyMenu.find(params[:id])
  end

  # create, update, destroy も必要に応じて追加
end
