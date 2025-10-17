class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.references :survey, null: false, foreign_key: true
      t.integer :rating
      t.text :text
      t.boolean :required

      t.timestamps
    end
  end
end
