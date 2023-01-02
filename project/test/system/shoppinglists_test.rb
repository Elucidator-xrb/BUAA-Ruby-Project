require "application_system_test_case"

class ShoppinglistsTest < ApplicationSystemTestCase
  setup do
    @shoppinglist = shoppinglists(:one)
  end

  test "visiting the index" do
    visit shoppinglists_url
    assert_selector "h1", text: "Shoppinglists"
  end

  test "should create shoppinglist" do
    visit shoppinglists_url
    click_on "New shoppinglist"

    fill_in "Mtype", with: @shoppinglist.mtype
    fill_in "Total", with: @shoppinglist.total
    click_on "Create Shoppinglist"

    assert_text "Shoppinglist was successfully created"
    click_on "Back"
  end

  test "should update Shoppinglist" do
    visit shoppinglist_url(@shoppinglist)
    click_on "Edit this shoppinglist", match: :first

    fill_in "Mtype", with: @shoppinglist.mtype
    fill_in "Total", with: @shoppinglist.total
    click_on "Update Shoppinglist"

    assert_text "Shoppinglist was successfully updated"
    click_on "Back"
  end

  test "should destroy Shoppinglist" do
    visit shoppinglist_url(@shoppinglist)
    click_on "Destroy this shoppinglist", match: :first

    assert_text "Shoppinglist was successfully destroyed"
  end
end
