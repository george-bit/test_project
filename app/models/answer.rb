class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :survey_response

  validates :rating, presence: true, inclusion: { in: 1..5 }
end
