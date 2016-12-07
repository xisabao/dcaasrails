class Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :survey
  #belongs_to :user
end
