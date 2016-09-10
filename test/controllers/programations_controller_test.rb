require 'test_helper'

class ProgramationsControllerTest < ActionController::TestCase
  setup do
    @programation = programations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:programations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create programation" do
    assert_difference('Programation.count') do
      post :create, programation: { Course_id: @programation.Course_id, Institution_id: @programation.Institution_id, costo: @programation.costo, descripcion: @programation.descripcion, duracion: @programation.duracion, horas: @programation.horas, objetivos: @programation.objetivos, plan: @programation.plan }
    end

    assert_redirected_to programation_path(assigns(:programation))
  end

  test "should show programation" do
    get :show, id: @programation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @programation
    assert_response :success
  end

  test "should update programation" do
    patch :update, id: @programation, programation: { Course_id: @programation.Course_id, Institution_id: @programation.Institution_id, costo: @programation.costo, descripcion: @programation.descripcion, duracion: @programation.duracion, horas: @programation.horas, objetivos: @programation.objetivos, plan: @programation.plan }
    assert_redirected_to programation_path(assigns(:programation))
  end

  test "should destroy programation" do
    assert_difference('Programation.count', -1) do
      delete :destroy, id: @programation
    end

    assert_redirected_to programations_path
  end
end
