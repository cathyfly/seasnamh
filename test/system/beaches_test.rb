require "application_system_test_case"

class BeachesTest < ApplicationSystemTestCase
  setup do
    @beach = beaches(:one)
  end

  test "visiting the index" do
    visit beaches_url
    assert_selector "h1", text: "Beaches"
  end

  test "creating a Beach" do
    visit beaches_url
    click_on "New Beach"

    fill_in "Description", with: @beach.description
    fill_in "Lat", with: @beach.lat
    fill_in "Location", with: @beach.location
    fill_in "Long", with: @beach.long
    fill_in "Rating", with: @beach.rating
    fill_in "Tide dependency", with: @beach.tide_dependency
    fill_in "Title", with: @beach.title
    fill_in "Warnings", with: @beach.warnings
    fill_in "Water quality", with: @beach.water_quality
    fill_in "Water quality date", with: @beach.water_quality_date
    click_on "Create Beach"

    assert_text "Beach was successfully created"
    click_on "Back"
  end

  test "updating a Beach" do
    visit beaches_url
    click_on "Edit", match: :first

    fill_in "Description", with: @beach.description
    fill_in "Lat", with: @beach.lat
    fill_in "Location", with: @beach.location
    fill_in "Long", with: @beach.long
    fill_in "Rating", with: @beach.rating
    fill_in "Tide dependency", with: @beach.tide_dependency
    fill_in "Title", with: @beach.title
    fill_in "Warnings", with: @beach.warnings
    fill_in "Water quality", with: @beach.water_quality
    fill_in "Water quality date", with: @beach.water_quality_date
    click_on "Update Beach"

    assert_text "Beach was successfully updated"
    click_on "Back"
  end

  test "destroying a Beach" do
    visit beaches_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Beach was successfully destroyed"
  end
end
