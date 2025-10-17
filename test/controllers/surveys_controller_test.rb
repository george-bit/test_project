require "test_helper"

class SurveysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @survey = Survey.create!(title: "Customer Feedback", description: "Tell us what you think")
  end

  test "should get index" do
    get surveys_url
    assert_response :success
    assert_select "h1", "Surveys"
  end

  test "should get new" do
    get new_survey_url
    assert_response :success
    assert_select "h1", "New Survey"
  end

  test "should create survey with valid attributes" do
    assert_difference("Survey.count", 1) do
      post surveys_url, params: { survey: { title: "New Survey", description: "New Description" } }
    end
    assert_redirected_to surveys_url
    follow_redirect!
    assert_match "Survey was successfully created", response.body
  end

  test "should not create survey with invalid attributes" do
    assert_no_difference("Survey.count") do
      post surveys_url, params: { survey: { title: "", description: "" } }
    end
    assert_response :unprocessable_entity
    assert_select "li", "Title can't be blank"
    assert_select "li", "Description can't be blank"
  end

  test "should get show" do
    get survey_url(@survey)
    assert_response :success
    assert_select "h1", @survey.title
  end

  test "should get edit" do
    get edit_survey_url(@survey)
    assert_response :success
    assert_select "h1", "Edit Survey"
  end

  test "should update survey with valid attributes" do
    patch survey_url(@survey), params: { survey: { title: "Updated Title", description: "Updated Description" } }
    assert_redirected_to surveys_url
    follow_redirect!
    assert_match "Survey was successfully updated", response.body
    @survey.reload
    assert_equal "Updated Title", @survey.title
    assert_equal "Updated Description", @survey.description
  end

  test "should not update survey with invalid attributes" do
    patch survey_url(@survey), params: { survey: { title: "", description: "" } }
    assert_response :unprocessable_entity
    assert_select "li", "Title can't be blank"
    assert_select "li", "Description can't be blank"
    @survey.reload
    assert_equal "Customer Feedback", @survey.title
  end
end
