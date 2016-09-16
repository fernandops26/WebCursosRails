require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  setup do
    @person = people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create person" do
    assert_difference('Person.count') do
      post :create, person: { ape_mat: @person.ape_mat, ape_pat: @person.ape_pat, celular: @person.celular, celular_op: @person.celular_op, direccion: @person.direccion, district_id: @person.district_id, dni: @person.dni, email: @person.email, f_nacimiento: @person.f_nacimiento, grado_acad: @person.grado_acad, nombres: @person.nombres, profesion: @person.profesion, sexo: @person.sexo, user_id: @person.user_id }
    end

    assert_redirected_to person_path(assigns(:person))
  end

  test "should show person" do
    get :show, id: @person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @person
    assert_response :success
  end

  test "should update person" do
    patch :update, id: @person, person: { ape_mat: @person.ape_mat, ape_pat: @person.ape_pat, celular: @person.celular, celular_op: @person.celular_op, direccion: @person.direccion, district_id: @person.district_id, dni: @person.dni, email: @person.email, f_nacimiento: @person.f_nacimiento, grado_acad: @person.grado_acad, nombres: @person.nombres, profesion: @person.profesion, sexo: @person.sexo, user_id: @person.user_id }
    assert_redirected_to person_path(assigns(:person))
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete :destroy, id: @person
    end

    assert_redirected_to people_path
  end
end
