class Survey < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :survey_users
  has_many :participants, class_name: "User", through: :survey_users, source: :user
  belongs_to :researcher, class_name: "User", foreign_key: "researcher_id"

  accepts_nested_attributes_for :questions

  validates :name, presence: true
end
