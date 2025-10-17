require "test_helper"

class SurveyResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @survey = Survey.create!(title: "Customer Feedback", description: "Tell us what you think")
    @question1 = Question.create!(survey: @survey, text: "How satisfied are you?", required: true, text_answer_optional: false)
    @question2 = Question.create!(survey: @survey, text: "Any suggestions?", required: false, text_answer_optional: true)
  end

  test "should create survey_response with valid attributes and nested answers" do
    assert_difference("SurveyResponse.count", 1) do
      assert_difference("Answer.count", 2) do
        post survey_survey_responses_url(@survey), params: {
          survey_response: {
            responder_email_address: "user@example.com",
            feedback: "Great survey!",
            answers_attributes: {
              "0" => { question_id: @question1.id, rating: 5, text: "" },
              "1" => { question_id: @question2.id, rating: 4, text: "More questions please" }
            }
          }
        }
      end
    end
    assert_redirected_to surveys_url
    follow_redirect!
    assert_match "Thank you for completing the survey!", response.body
  end

  test "should not create survey_response without responder_email_address" do
    assert_no_difference("SurveyResponse.count") do
      assert_no_difference("Answer.count") do
        post survey_survey_responses_url(@survey), params: {
          survey_response: {
            responder_email_address: "",
            feedback: "Great survey!",
            answers_attributes: {
              "0" => { question_id: @question1.id, rating: 5 }
            }
          }
        }
      end
    end
    assert_response :unprocessable_entity
    assert_select "li", "Responder email address can't be blank"
  end

  test "should not create survey_response with invalid answer" do
    assert_no_difference("SurveyResponse.count") do
      assert_no_difference("Answer.count") do
        post survey_survey_responses_url(@survey), params: {
          survey_response: {
            responder_email_address: "user@example.com",
            feedback: "Great survey!",
            answers_attributes: {
              "0" => { question_id: @question1.id, rating: nil }
            }
          }
        }
      end
    end
    assert_response :unprocessable_entity
  end
end
