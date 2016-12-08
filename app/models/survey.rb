class Survey < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :answers, dependent: :destroy
  #has_many :users
  #belongs-to :researcher

  accepts_nested_attributes_for :questions
end
