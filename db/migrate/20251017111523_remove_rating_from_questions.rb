class RemoveRatingFromQuestions < ActiveRecord::Migration[8.0]
  def change
    remove_column :questions, :rating, :integer
  end
end
