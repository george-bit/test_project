class SurveyResponse < ApplicationRecord
  belongs_to :survey
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers

  validates :responder_email_address, presence: true
end
