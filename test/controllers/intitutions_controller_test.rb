require 'test_helper'

class IntitutionsControllerTest < ActionController::TestCase
  setup do
    @intitution = intitutions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:intitutions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create intitution" do
    assert_difference('Intitution.count') do
      post :create, intitution: { razon: @intitution.razon }
    end

    assert_redirected_to intitution_path(assigns(:intitution))
  end

  test "should show intitution" do
    get :show, id: @intitution
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @intitution
    assert_response :success
  end

  test "should update intitution" do
    patch :update, id: @intitution, intitution: { razon: @intitution.razon }
    assert_redirected_to intitution_path(assigns(:intitution))
  end

  test "should destroy intitution" do
    assert_difference('Intitution.count', -1) do
      delete :destroy, id: @intitution
    end

    assert_redirected_to intitutions_path
  end
end
