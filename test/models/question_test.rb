require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  setup do
    @survey = Survey.create!(title: "Test Survey", description: "Test Description")
  end

  test "should be valid with valid attributes" do
    question = Question.new(survey: @survey, text: "How satisfied are you?", required: true, text_answer_optional: false)
    assert question.valid?
  end

  test "should be invalid without text" do
    question = Question.new(survey: @survey, required: true, text_answer_optional: false)
    assert_not question.valid?
    assert_includes question.errors[:text], "can't be blank"
  end

  test "should be invalid without required field" do
    question = Question.new(survey: @survey, text: "How satisfied are you?", text_answer_optional: false)
    assert_not question.valid?
    assert_includes question.errors[:required], "is not included in the list"
  end

  test "should be valid with required as false" do
    question = Question.new(survey: @survey, text: "Optional question", required: false, text_answer_optional: true)
    assert question.valid?
  end

  test "should be invalid without text_answer_optional field" do
    question = Question.new(survey: @survey, text: "How satisfied are you?", required: true)
    assert_not question.valid?
    assert_includes question.errors[:text_answer_optional], "is not included in the list"
  end

  test "should be valid with text_answer_optional as true" do
    question = Question.new(survey: @survey, text: "Test question", required: true, text_answer_optional: true)
    assert question.valid?
  end

  test "should be valid with text_answer_optional as false" do
    question = Question.new(survey: @survey, text: "Test question", required: true, text_answer_optional: false)
    assert question.valid?
  end

  test "should belong to a survey" do
    question = Question.new(text: "How satisfied are you?", required: true, text_answer_optional: false)
    assert_not question.valid?
    assert_includes question.errors[:survey], "must exist"
  end
end
