class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :created_surveys, class_name: "Survey", foreign_key: "researcher_id", dependent: :destroy
  has_many :assigned_surveys, through: :survey_users, source: :survey
  has_many :survey_users
  has_many :responses
  has_many :answers

  enum role: {participant: 0, researcher: 1, admin: 2}
end
