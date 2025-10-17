class Question < ApplicationRecord
  belongs_to :survey
  has_many :answers, dependent: :destroy

  validates :text, presence: true
  validates :required, inclusion: { in: [ true, false ] }
  validates :text_answer_optional, inclusion: { in: [ true, false ] }
end
