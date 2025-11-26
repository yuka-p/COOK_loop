class MyMenusController < ApplicationController
  before_action :authenticate_user!
  before_action :set_my_menu, only: [ :show, :destroy ]

  def index
    @my_menus = current_user.my_menus.order(created_at: :desc)
  end

  def show
    @my_menu = MyMenu.find(params[:id])
  end

  def new
    @my_menu = MyMenu.new
    @user_genres = current_user.user_genres.order(:position)
    @master_menus = MasterMenu.all
  end

  def create
    @my_menu = current_user.my_menus.new(my_menu_params)

    if @my_menu.save
      redirect_to my_menus_path, notice: "メニューを登録しました"
    else
      @user_genres = current_user.user_genres.order(:position)
      @master_menus = MasterMenu.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @my_menu = MyMenu.find(params[:id])
  end

  def destroy
    @my_menu.destroy
    redirect_to my_menus_path, notice: "削除しました"
  end

  private

  def set_my_menu
    @my_menu = current_user.my_menus.find(params[:id])
  end

  def my_menu_params
    params.require(:my_menu).permit(
      :title,
      :genre_id,
      :master_menu_id,
      :ingredients,
      :note,
      :reference_url,
      :last_cooked_at
    )
  end
end
