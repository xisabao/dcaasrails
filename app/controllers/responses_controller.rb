class ResponsesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_participant, only: [:new, :create]
  before_action :correct_researcher, only: [:index]
  def new
    @survey = Survey.find(params[:survey_id])
    @response = @survey.responses.build
    @survey.questions.each { |q| @response.answers.build(survey_id: @survey.id, question_id: q.id) }

  end
  def create
    @survey = Survey.find(params[:survey_id])
    @response = @survey.responses.build(response_params)
    @response.user = current_user
    if @response.save
      flash[:notice] = 'Response recorded!'
      redirect_to @survey
    else
      flash[:alert] = "Oops, something went wrong!"
      render :new
    end
  end
  def index
    @survey = Survey.find(params[:survey_id])
    @responses = @survey.responses
    @data = []
    @responses.each do |r|
      datum = []
      datum[0] = r.created_at
      datum[1] = r.user.name
      r.answers.each do |a|
        datum[a.question.qid + 1] = a.str_value
      end
      @data << datum
    end
    respond_to do |format|
      format.html
      format.csv { send_data @responses.to_csv(@survey.id) }
    end
  end
  private
  def response_params
    params.require(:response).permit(:answers_attributes => [:question_id, :survey_id, :num_value, :str_value, :bool_value])
  end
  def correct_participant
    @survey = current_user.assigned_surveys.find_by(id: params[:survey_id])
    redirect_to :index if @survey.nil? || current_user.researcher?
  end
  def correct_researcher
    @survey = current_user.created_surveys.find_by(id: params[:survey_id])
    redirect_to :index if @survey.nil? || current_user.participant?
  end
end
