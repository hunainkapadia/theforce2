#require 'date'

class HappinesstrackersController < ApplicationController
def index
  #date = getdate()

  #Only show answers if the total number of responses for each 
  #question is more than 5.

  #Get the count for the number of responses for each answer option
  @happyanswercount = Happy1answer.where(hanswer: true).count
  @Nothappyanswercount =  Happy1answer.where(hanswer: false).count
  @stressedanswercount = Stressed1answer.where(sanswer: true).count
  @Notstressedanswercount = Stressed1answer.where(sanswer: false).count
  
  #Total counts and run simple if's and throw back to view
  if (@happyanswercount + @Nothappyanswercount)  > 5
    @happyanswers = @happyanswercount
    @Nothappyanswers = @Nothappyanswercount
  else
    @happyanswers = 'Not enough answers. Minimum total answers have to be atleast 5.'
    @Nothappyanswers = 'Not enough answers.  Minimum total answers have to be atleast 5.'
  end
  
  if (@stressedanswercount + @Notstressedanswercount)  > 5
    @stressedanswers = @stressedanswercount
    @Notstressedanswers = @Notstressedanswercount
  else
    @stressedanswers = 'Not enough answers. Minimum total answers have to be atleast 5.'
    @Notstressedanswers = 'Not enough answers.  Minimum total answers have to be atleast 5.'
  end

  #Show open question for today, esle show "Whats up?"
  @openquestion = OpenQuestions.where(id: 3)
  @openanswers = Oanswer.where(questionid: 3)
 
  end

  def show
	 @happinesstracker = Happinesstracker.find(params[:id])
  end

  def new
    #@happinesstracker = Happinesstracker.new
  end

  def edit
  end

  def create	
  if !params[:openquestion].nil?
    @openquestion = OpenQuestions.new(open_question_params)
    @openquestion.save
  end

  if !params[:closedquestion].nil?
    @closedquestion = ClosedQuestions.new(closed_question_params)
    @closedquestion.save
  end

  if !params[:cquestion].nil?
    @closedquestion = Cquestions.new(c_question_params)
    @closedquestion.save
  end

   redirect_to happinesstrackers_admin_path
  end

  def update
    render plain: params[:closedquestion].inspect
    redirect_to home_index_path
	end

  def destroy
  end
  
  def admin
    @closedquestions = ClosedQuestions.where(is_visible: true)
    @openquestions = OpenQuestions.all
  end

  def survey
  @closedquestions = ClosedQuestions.where(is_visible: true)
  @openquestions = OpenQuestions.all
  end

  def thankyou
    #answer = params[:hanswer]
    @customerans = Happy1answer.new(params.require(:closedanswer).permit(:hanswer))
    @customerans.save
    @customerans = Stressed1answer.new(params.require(:closedanswer).permit(:sanswer))
    @customerans.save
    @customerans = Oanswer.new(params.require(:closedanswer).permit(:answer, :questionid))
    @customerans.save
    render plain: params[:closedanswer]
    #redirect_to happinesstrackers_thankyou_path
  end

  private
    def closedquestion_answer_params
    params.require(:closedanswer).permit(:ans)
  end

  def happinesstracker_params
    params.require(:happinesstracker).permit(:question)
  end
  
  def closed_question_params
    params.require(:closedquestion).permit(:closedquestion, :is_visible)
  end

  def open_question_params
    params.require(:openquestion).permit(:openquestion, :createdby, :createdfordate)
  end

   def c_question_params
    params.require(:cquestion).permit(:question, :is_visible)
  end

end
