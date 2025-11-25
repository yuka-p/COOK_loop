require "test_helper"
require "securerandom"

class MyMenusControllerTest < ActionDispatch::IntegrationTest
  setup do
    # テスト用ユーザーを作成（存在する場合は find_or_create_by）
    @user = User.find_or_create_by!(email: "test@example.com") do |user|
      user.password = "password123"
      user.user_name = "TestUser"
    end

    # ジャンルも同様
    @genre = @user.user_genres.find_or_create_by!(name: "主菜")

    # マイメニューはユニークかつ15文字以内に
    unique_title = "テストメニュー#{SecureRandom.hex(2)}" # 最大15文字
    @my_menu = MyMenu.create!(title: unique_title, user: @user, genre: @genre)

    sign_in @user
  end

  test "should get index" do
    get my_menus_path
    assert_response :success
  end

  test "should get show" do
    get my_menu_path(@my_menu)
    assert_response :success
  end

  test "should get new" do
    get new_my_menu_path
    assert_response :success
  end

  test "should get edit" do
    get edit_my_menu_path(@my_menu)
    assert_response :success
  end
end
