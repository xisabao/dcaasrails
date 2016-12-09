class SurveysController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_researcher, only: [:new, :create]
  before_action :correct_participant_or_researcher, only: [:show]

  def index
    if current_user.researcher?
      @surveys = current_user.created_surveys
    elsif current_user.participant?
      @surveys = current_user.assigned_surveys
    elsif current_user.admin?
      @surveys = Survey.all
    end
  end
  def show
    @survey = Survey.find(params[:id])
  end
  def new
    @survey = Survey.new
    3.times { @survey.questions.build }
    @participants = User.where(role: :participant)
  end
  def create
    @survey = current_user.created_surveys.build(survey_params)
    if @survey.save
      flash[:notice] = 'Survey created!'
      redirect_to survey_path(@survey)
   else
      flash[:alert] = 'Oops, something went wrong!'
      @participants = User.where(role: :participant)
      render :new
   end
  end
  private
  def survey_params
    params.require(:survey).permit(:name, :description, participant_ids: [], :questions_attributes => [:qid, :text, :details, :input_type, :options])
  end
  def correct_researcher
    redirect_to action: :index if current_user.participant?
  end
  def correct_participant_or_researcher
    if current_user.participant?
      @survey = current_user.assigned_surveys.find_by(id: params[:id])
      redirect_to action: :index if @survey.nil?
    end
  end
end

