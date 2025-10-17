class CreateSurveyResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :survey_responses do |t|
      t.references :survey, null: false, foreign_key: true
      t.text :feedback
      t.string :responder_email_address

      t.timestamps
    end
  end
end
