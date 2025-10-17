require "test_helper"

class SurveyResponseTest < ActiveSupport::TestCase
  setup do
    @survey = Survey.create!(title: "Test Survey", description: "Test Description")
    @question = Question.create!(survey: @survey, text: "Test Question", required: true, text_answer_optional: false)
  end

  test "should be valid with valid attributes" do
    survey_response = SurveyResponse.new(survey: @survey, responder_email_address: "test@example.com", feedback: "Great survey")
    assert survey_response.valid?
  end

  test "should be invalid without responder_email_address" do
    survey_response = SurveyResponse.new(survey: @survey, feedback: "Great survey")
    assert_not survey_response.valid?
    assert_includes survey_response.errors[:responder_email_address], "can't be blank"
  end

  test "should be valid without feedback" do
    survey_response = SurveyResponse.new(survey: @survey, responder_email_address: "test@example.com")
    assert survey_response.valid?
  end

  test "should belong to a survey" do
    survey_response = SurveyResponse.new(responder_email_address: "test@example.com", feedback: "Great survey")
    assert_not survey_response.valid?
    assert_includes survey_response.errors[:survey], "must exist"
  end

  test "should have many answers" do
    survey_response = SurveyResponse.create!(survey: @survey, responder_email_address: "test@example.com")
    answer1 = Answer.create!(survey_response: survey_response, question: @question, rating: 4)
    answer2 = Answer.create!(survey_response: survey_response, question: @question, rating: 5)

    assert_equal 2, survey_response.answers.count
    assert_includes survey_response.answers, answer1
    assert_includes survey_response.answers, answer2
  end

  test "should destroy associated answers when survey_response is destroyed" do
    survey_response = SurveyResponse.create!(survey: @survey, responder_email_address: "test@example.com")
    answer1 = Answer.create!(survey_response: survey_response, question: @question, rating: 4)
    answer2 = Answer.create!(survey_response: survey_response, question: @question, rating: 5)

    assert_difference("Answer.count", -2) do
      survey_response.destroy
    end
  end

  test "should accept nested attributes for answers" do
    survey_response = SurveyResponse.new(
      survey: @survey,
      responder_email_address: "test@example.com",
      feedback: "Good",
      answers_attributes: [
        { question_id: @question.id, rating: 4, text: "Nice" }
      ]
    )

    assert survey_response.save
    assert_equal 1, survey_response.answers.count
    assert_equal 4, survey_response.answers.first.rating
  end
end
