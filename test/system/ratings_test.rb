require "application_system_test_case"

class RatingsTest < ApplicationSystemTestCase
  setup do
    @rating = ratings(:one)
  end

  test "visiting the index" do
    visit ratings_url
    assert_selector "h1", text: "Ratings"
  end

  test "should create rating" do
    visit ratings_url
    click_on "New rating"

    fill_in "Age", with: @rating.age
    fill_in "Dryness", with: @rating.dryness
    fill_in "Pureness", with: @rating.pureness
    fill_in "Rice", with: @rating.rice_id
    fill_in "Whiteness", with: @rating.whiteness
    click_on "Create Rating"

    assert_text "Rating was successfully created"
    click_on "Back"
  end

  test "should update Rating" do
    visit rating_url(@rating)
    click_on "Edit this rating", match: :first

    fill_in "Age", with: @rating.age
    fill_in "Dryness", with: @rating.dryness
    fill_in "Pureness", with: @rating.pureness
    fill_in "Rice", with: @rating.rice_id
    fill_in "Whiteness", with: @rating.whiteness
    click_on "Update Rating"

    assert_text "Rating was successfully updated"
    click_on "Back"
  end

  test "should destroy Rating" do
    visit rating_url(@rating)
    click_on "Destroy this rating", match: :first

    assert_text "Rating was successfully destroyed"
  end
end
