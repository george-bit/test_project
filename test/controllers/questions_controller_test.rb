require "test_helper"

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @survey = Survey.create!(title: "Customer Feedback", description: "Tell us what you think")
    @question = Question.create!(survey: @survey, text: "How satisfied are you?", required: true, text_answer_optional: false)
  end

  test "should get new" do
    get new_survey_question_url(@survey)
    assert_response :success
    assert_select "h1", "Add Question to #{@survey.title}"
  end

  test "should create question with valid attributes" do
    assert_difference("Question.count", 1) do
      post survey_questions_url(@survey), params: {
        question: { text: "What can we improve?", required: false, text_answer_optional: true }
      }
    end
    assert_redirected_to edit_survey_url(@survey)
    follow_redirect!
    assert_match "Question was successfully created", response.body
  end

  test "should not create question with invalid attributes" do
    assert_no_difference("Question.count") do
      post survey_questions_url(@survey), params: {
        question: { text: "", required: true, text_answer_optional: false }
      }
    end
    assert_response :unprocessable_entity
    assert_select "li", "Text can't be blank"
  end

  test "should get edit" do
    get edit_survey_question_url(@survey, @question)
    assert_response :success
    assert_select "h1", "Edit Question"
  end

  test "should update question with valid attributes" do
    patch survey_question_url(@survey, @question), params: {
      question: { text: "How would you rate us?", required: false, text_answer_optional: true }
    }
    assert_redirected_to edit_survey_url(@survey)
    follow_redirect!
    assert_match "Question was successfully updated", response.body
    @question.reload
    assert_equal "How would you rate us?", @question.text
    assert_equal false, @question.required
    assert_equal true, @question.text_answer_optional
  end

  test "should not update question with invalid attributes" do
    patch survey_question_url(@survey, @question), params: {
      question: { text: "", required: true, text_answer_optional: false }
    }
    assert_response :unprocessable_entity
    assert_select "li", "Text can't be blank"
    @question.reload
    assert_equal "How satisfied are you?", @question.text
  end
end
