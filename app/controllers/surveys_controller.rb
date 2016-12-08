class SurveysController < ApplicationController
  def index
    @surveys = Survey.all
  end
  def show
    @survey = Survey.find(params[:id])
  end
  def new
    @survey = Survey.new
    3.times { @survey.questions.build }
  end
  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      flash[:success] = 'Survey created!'
      redirect_to survey_path(@survey)
   else
      flash[:failure] = 'Oops, something went wrong!'
      render :new
   end
  end
  private
  def survey_params
    params.require(:survey).permit(:name, :description, :questions_attributes => [:qid, :text, :details, :input_type, :options])
  end
end

