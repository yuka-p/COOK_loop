require "test_helper"

class MasterMenusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)  # fixtures で user を用意
    sign_in @user
  end

  test "should get index" do
    get master_menus_url
    assert_response :success
  end
end
