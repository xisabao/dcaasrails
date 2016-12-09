class Answer < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question
  belongs_to :response
  belongs_to :user
end
