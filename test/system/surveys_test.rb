require "application_system_test_case"

class SurveysTest < ApplicationSystemTestCase
  setup do
    @survey = Survey.create!(title: "Customer Feedback", description: "Tell us what you think")
  end

  test "visiting the index" do
    visit surveys_url
    assert_selector "h1", text: "Surveys"
    assert_text "Customer Feedback"
    assert_text "Tell us what you think"
  end

  test "creating a new survey" do
    visit surveys_url
    click_on "New Survey"

    assert_selector "h1", text: "New Survey"

    fill_in "Title", with: "Product Survey"
    fill_in "Description", with: "Help us improve our product"
    click_on "Create Survey"

    assert_text "Survey was successfully created"
    assert_text "Product Survey"
    assert_text "Help us improve our product"
  end

  test "creating a survey with invalid data shows errors" do
    visit new_survey_url

    fill_in "Title", with: ""
    fill_in "Description", with: ""
    click_on "Create Survey"

    assert_text "Title can't be blank"
    assert_text "Description can't be blank"
  end

  test "editing an existing survey" do
    visit surveys_url
    click_on "Edit"

    assert_selector "h1", text: "Edit Survey"

    fill_in "Title", with: "Updated Customer Feedback"
    fill_in "Description", with: "We value your updated feedback"
    click_on "Update Survey"

    assert_text "Survey was successfully updated"
    assert_text "Updated Customer Feedback"
    assert_text "We value your updated feedback"
  end

  test "editing a survey with invalid data shows errors" do
    visit edit_survey_url(@survey)

    fill_in "Title", with: ""
    fill_in "Description", with: ""
    click_on "Update Survey"

    assert_text "Title can't be blank"
    assert_text "Description can't be blank"
  end

  test "canceling edit returns to index" do
    visit edit_survey_url(@survey)
    click_on "Cancel"

    assert_current_path surveys_path
    assert_selector "h1", text: "Surveys"
  end
end
