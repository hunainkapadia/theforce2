#require 'date'

class HappinesstrackersController < ApplicationController
def index
  @time = Time.now.strftime("%Y-%m-%d")
  @time1 = Time.now
  @todaysdate = Time.new

  #Only show answers if the total number of responses for each 
  #question is more than 5.
  #Get the count for the number of responses for each answer option for today
  @happyanswercount = Happy1answer.where('hanswer = ? and created_at > ?', true, Date.today).count
  @Nothappyanswercount =  Happy1answer.where('hanswer = ? and created_at > ?', false, Date.today).count
  @stressedanswercount = Stressed1answer.where('sanswer = ? and created_at > ?', true, Date.today).count
  @Notstressedanswercount = Stressed1answer.where('sanswer = ? and created_at > ?', false, Date.today).count
  @HappinessTotalForTheDay = @happyanswercount + @Nothappyanswercount
  @StressedTotalForTheDay = @stressedanswercount + @Notstressedanswercount

  #Total counts and run simple if's and throw back to view
  #TZ: Happiness and stress under same if condition since they are required question;
  #TZ: both will be above >= 5 and if not then switching to another view with a message
  if @HappinessTotalForTheDay  >= 5
    @happyanswers = (@happyanswercount.to_f / @HappinessTotalForTheDay) * 100
    @Nothappyanswers = (@Nothappyanswercount.to_f / @HappinessTotalForTheDay) * 100
    @stressedanswers = (@stressedanswercount.to_f / @StressedTotalForTheDay) * 100
    @Notstressedanswers = (@Notstressedanswercount.to_f / @StressedTotalForTheDay) * 100 

    #Determine color of the stressed bar depending on the percentage response
    if @stressedanswers >= 50
      @progress_color = 'progress-bar-danger'
    elsif @stressedanswers >= 30
      @progress_color = 'progress-bar-warning'
    else
      @progress_color = 'progress-bar-success'
    end

    #Determining the image for the smiley face based on happy answers %
    if @happyanswers == 100
      @smiley_main = '100.png'
    elsif @happyanswers >= 85
      @smiley_main = '100-85.png'
    elsif @happyanswers >= 70
      @smiley_main = '85-70.png'
    elsif @happyanswers >= 55
      @smiley_main = '70-55.png'
    elsif @happyanswers >= 40
      @smiley_main = '55-40.png'
    else
      @smiley_main = '40-0.png'
    end         

  else
    #Display the "not enough" template
    render :action => 'notenough'
  end

  #Show open question for today, esle show "Whats up?"
  openquestions = OpenQuestions.where(createdfordate: Date.today)
  if openquestions.empty?
    @openquestion = get_default_question
  else
    @openquestion = openquestions[0].openquestion
  end
  #Do not display empty answers
  @openanswers = Oanswer.where("created_at > ? AND answer <> ''", Date.today)
  @linegraph = line_graph_prep
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

  if !params[:myusers].nil?
    @user = Myuser.new(user_params)
    @user.save
  end

   redirect_to happinesstrackers_admin_path
  end

  def update
    render plain: params[:closedquestion].inspect
    redirect_to home_index_path
	end

  def destroy
    puts "My Jame"
    puts :id
    redirect_to happinesstrackers_admin_path
  end
  
  def admin
    @closedquestions = ClosedQuestions.where(is_visible: true)
    @openquestions = OpenQuestions.order('createdfordate DESC').all
    @users = Myuser.all
  end

  def survey
  @time = Time.now.strftime("%Y-%m-%d")
  @closedquestions = ClosedQuestions.where(is_visible: true)
  @openquestions = OpenQuestions.where(createdfordate: Date.today)
  if @openquestions.empty?
    @openquestion = get_default_question
  else
    @openquestion = @openquestions[0].openquestion
  end
  end

  def thankyou
    @customerans = Happy1answer.new(params.require(:closedanswer).permit(:hanswer))
    @customerans.save
    @customerans = Stressed1answer.new(params.require(:closedanswer).permit(:sanswer))
    @customerans.save
    @customerans = Oanswer.new(params.require(:closedanswer).permit(:answer, :questionid))
    @customerans.save
    #render plain: params[:closedanswer]
    #redirect_to happinesstrackers_thankyou_path
  end

  private
  def line_graph_prep
  if Rails.env.development?
    trueanswersperday = Happy1answer.where("hanswer = ? AND created_at > date('now', '-30 day')", true).group("DATE(created_at)").count
    totalanswersperday = Happy1answer.where("created_at > date('now', '-30 day')").group("DATE(created_at)").count
  elsif Rails.env.production?
    trueanswersperday = Happy1answer.where("hanswer = ? AND created_at > now()::date - 30", true).group("DATE(created_at)").count
    totalanswersperday = Happy1answer.where("created_at > now()::date - 30").group("DATE(created_at)").count
  end
    linegraph = Hash.new  
    trueanswersperday.each do |key, val|
      percent = val.to_f/totalanswersperday[key]
      linegraph[key] = percent
    end
    puts linegraph
    return linegraph
  end
  def get_default_question
    question = "Do you have any feedback for us?"
  end

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

  def user_params
    params.require(:myusers).permit(:name, :email)
  end
end
