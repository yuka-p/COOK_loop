class MyMenusController < ApplicationController
  before_action :authenticate_user!
  before_action :set_my_menu, only: [ :show, :destroy ]

  def index
    @my_menus = current_user.my_menus.order(created_at: :desc)
    @genre = params[:genre]
    @sort = params[:sort]

    @my_menus =
    current_user.my_menus
                .by_genre(@genre)
                .sorted(@sort)
  end

  def show
    @my_menu = MyMenu.find(params[:id])
  end

  def new
    @my_menu = MyMenu.new
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

  def update
    @my_menu = MyMenu.find(params[:id])
    if @my_menu.update(my_menu_params)
      redirect_to @my_menu, notice: "マイメニューを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @my_menu.destroy
    redirect_to my_menus_path, notice: "メニューを削除しました"
  end

  def import_from_master
    menu_ids = params[:menu_ids] || []
    if menu_ids.empty?
      redirect_to master_menus_path, alert: "1つ以上選択してください"
      return
    end

    menus = MasterMenu.where(id: menu_ids)

    # 確認モーダル用の partial を返す
    if params[:confirm] != "true"
      render turbo_stream: turbo_stream.replace(
        "modal",
        partial: "my_menus/modal_confirm",
        locals: { menus: menus }
      )
      return
    end

    # 登録処理
    menus.each do |menu|
      current_user.my_menus.create(
        title: menu.title,
        genre: menu.genre,
        master_menu_id: menu.id
      )
    end

    redirect_to my_menus_path, notice: "マイメニューに登録しました"
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
