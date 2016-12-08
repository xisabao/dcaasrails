class ResponsesController < ApplicationController
  def new
    @survey = Survey.find(params[:survey_id])
    @response = @survey.responses.build
    @survey.questions.each { |q| @response.answers.build(survey_id: @survey.id, question_id: q.id) }

  end
  def create
    @survey = Survey.find(params[:survey_id])
    @response = @survey.responses.build(response_params)
    if @response.save
      flash[:success] = 'Response recorded!'
      redirect_to @survey
    else
      flash[:failure] = 'Oops, something went wrong!'
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
      r.answers.each do |a|
        datum[a.question.qid] = a.str_value
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
end
