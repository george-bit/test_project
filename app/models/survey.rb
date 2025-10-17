class Survey < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :survey_responses, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
end
