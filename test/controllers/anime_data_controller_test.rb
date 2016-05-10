require 'test_helper'

class AnimeDataControllerTest < ActionController::TestCase
  setup do
    @anime_datum = anime_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:anime_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create anime_datum" do
    assert_difference('AnimeDatum.count') do
      post :create, anime_datum: { chinese: @anime_datum.chinese, english: @anime_datum.english, japanese: @anime_datum.japanese, month: @anime_datum.month, url: @anime_datum.url, year: @anime_datum.year }
    end

    assert_redirected_to anime_datum_path(assigns(:anime_datum))
  end

  test "should show anime_datum" do
    get :show, id: @anime_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @anime_datum
    assert_response :success
  end

  test "should update anime_datum" do
    patch :update, id: @anime_datum, anime_datum: { chinese: @anime_datum.chinese, english: @anime_datum.english, japanese: @anime_datum.japanese, month: @anime_datum.month, url: @anime_datum.url, year: @anime_datum.year }
    assert_redirected_to anime_datum_path(assigns(:anime_datum))
  end

  test "should destroy anime_datum" do
    assert_difference('AnimeDatum.count', -1) do
      delete :destroy, id: @anime_datum
    end

    assert_redirected_to anime_data_path
  end
end
