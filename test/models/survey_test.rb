require "test_helper"

class SurveyTest < ActiveSupport::TestCase
  test "should be valid with title and description" do
    survey = Survey.new(title: "Customer Feedback", description: "Please provide your feedback")
    assert survey.valid?
  end

  test "should be invalid without title" do
    survey = Survey.new(description: "Please provide your feedback")
    assert_not survey.valid?
    assert_includes survey.errors[:title], "can't be blank"
  end

  test "should be invalid without description" do
    survey = Survey.new(title: "Customer Feedback")
    assert_not survey.valid?
    assert_includes survey.errors[:description], "can't be blank"
  end

  test "should be invalid without title and description" do
    survey = Survey.new
    assert_not survey.valid?
    assert_includes survey.errors[:title], "can't be blank"
    assert_includes survey.errors[:description], "can't be blank"
  end

  test "should have many questions" do
    survey = Survey.create!(title: "Customer Feedback", description: "Please provide your feedback")
    question1 = Question.create!(survey: survey, text: "Question 1", required: true, text_answer_optional: false)
    question2 = Question.create!(survey: survey, text: "Question 2", required: false, text_answer_optional: true)

    assert_equal 2, survey.questions.count
    assert_includes survey.questions, question1
    assert_includes survey.questions, question2
  end

  test "should destroy associated questions when survey is destroyed" do
    survey = Survey.create!(title: "Customer Feedback", description: "Please provide your feedback")
    question1 = Question.create!(survey: survey, text: "Question 1", required: true, text_answer_optional: false)
    question2 = Question.create!(survey: survey, text: "Question 2", required: false, text_answer_optional: true)

    assert_difference("Question.count", -2) do
      survey.destroy
    end
  end
end
