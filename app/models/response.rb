class Response < ActiveRecord::Base
  belongs_to :survey
  has_many :answers, dependent: :destroy
  #belongs_to :user

  def self.to_csv(survey_id, options = {})
    responses = Response.where(survey_id: survey_id)
    CSV.generate(options) do |csv|
      csv << ["Timestamp"] + Survey.find(survey_id).questions.map { |q| "Q" + q.qid.to_s }
      responses.each do |r|
        datum = []
        datum[0] = r.created_at
        r.answers.each do |a|
          datum[a.question.qid] = a.str_value
        end
        csv << datum
      end
    end
  end

  accepts_nested_attributes_for :answers
end
