class AddTextAnswerOptionalToQuestions < ActiveRecord::Migration[8.0]
  def change
    add_column :questions, :text_answer_optional, :boolean
  end
end
