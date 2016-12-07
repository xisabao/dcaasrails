class Survey < ActiveRecord::Base
  has_many :questions
  has_many :responses
  #has_many :users
  #belongs-to :researcher
end
