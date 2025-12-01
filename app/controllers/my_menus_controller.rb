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

  def select_from_master
    @master_menus = MasterMenu.all.order(:genre)
  end

  def import_from_master
    selected_ids = params[:menu_ids]

    if selected_ids.blank?
      redirect_to select_from_master_my_menus_path, alert: "メニューを選択してください"
      return
    end

    master_menus = MasterMenu.where(id: selected_ids)

    master_menus.each do |m|
      current_user.my_menus.create!(
        title: m.title,
        genre: m.genre,       # enum 対応
        ingredients: m.ingredients,
        master_menu_id: m.id
      )
    end

    redirect_to my_menus_path, notice: "マイメニューに登録しました！"
  end

  private

  def set_my_menu
    @my_menu = current_user.my_menus.find(params[:id])
  end

  def my_menu_params
    params.require(:my_menu).permit(
      :title,
      :genre,
      :master_menu_id,
      :ingredients,
      :note,
      :reference_url,
      :last_cooked_at
    )
  end
end
