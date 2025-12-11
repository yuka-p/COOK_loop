require "test_helper"

class MealPlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @menu = my_menus(:one)
  end

  test "should get index" do
    get meal_plans_url
    assert_response :success
  end

  test "should get new" do
    get new_meal_plan_url
    assert_response :success
  end

  test "should create meal_plan" do
    assert_difference("MealPlan.count") do
      post meal_plans_url, params: {
        meal_plan: {
          my_menu_ids: [ @menu.id ]
        }
      }
    end

    assert_response :redirect
  end

  test "should show meal_plan" do
    meal_plan = @user.meal_plans.create!(my_menu_ids: [ @menu.id ])

    get meal_plan_url(meal_plan)
    assert_response :success
  end
end
