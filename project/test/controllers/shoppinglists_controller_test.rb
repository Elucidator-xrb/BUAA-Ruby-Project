require "test_helper"

class ShoppinglistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shoppinglist = shoppinglists(:one)
  end

  test "should get index" do
    get shoppinglists_url
    assert_response :success
  end

  test "should get new" do
    get new_shoppinglist_url
    assert_response :success
  end

  test "should create shoppinglist" do
    assert_difference("Shoppinglist.count") do
      post shoppinglists_url, params: { shoppinglist: { mtype: @shoppinglist.mtype, total: @shoppinglist.total } }
    end

    assert_redirected_to shoppinglist_url(Shoppinglist.last)
  end

  test "should show shoppinglist" do
    get shoppinglist_url(@shoppinglist)
    assert_response :success
  end

  test "should get edit" do
    get edit_shoppinglist_url(@shoppinglist)
    assert_response :success
  end

  test "should update shoppinglist" do
    patch shoppinglist_url(@shoppinglist), params: { shoppinglist: { mtype: @shoppinglist.mtype, total: @shoppinglist.total } }
    assert_redirected_to shoppinglist_url(@shoppinglist)
  end

  test "should destroy shoppinglist" do
    assert_difference("Shoppinglist.count", -1) do
      delete shoppinglist_url(@shoppinglist)
    end

    assert_redirected_to shoppinglists_url
  end
end
