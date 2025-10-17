class SurveyResponsesController < ApplicationController
  before_action :set_survey

  def create
    @survey_response = @survey.survey_responses.build(survey_response_params)

    if @survey_response.save
      redirect_to surveys_path, notice: "Thank you for completing the survey!"
    else
      @questions = @survey.questions
      render "surveys/show", status: :unprocessable_entity
    end
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def survey_response_params
    params.require(:survey_response).permit(:responder_email_address, :feedback, answers_attributes: [ :question_id, :rating, :text ])
  end
end
