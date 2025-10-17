class SurveysController < ApplicationController
  before_action :set_survey, only: [ :show, :edit, :update ]

  def index
    @surveys = Survey.all
  end

  def show
    @questions = @survey.questions
    @survey_response = @survey.survey_responses.build
    @questions.each do |question|
      @survey_response.answers.build(question: question)
    end
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)

    if @survey.save
      redirect_to surveys_path, notice: "Survey was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @survey.update(survey_params)
      redirect_to surveys_path, notice: "Survey was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
  end

  def survey_params
    params.require(:survey).permit(:title, :description)
  end
end
