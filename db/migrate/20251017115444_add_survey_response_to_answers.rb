class AddSurveyResponseToAnswers < ActiveRecord::Migration[8.0]
  def change
    add_reference :answers, :survey_response, null: false, foreign_key: true
  end
end
