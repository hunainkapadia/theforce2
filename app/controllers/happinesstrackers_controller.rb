class HappinesstrackersController < ApplicationController
def index
  end

  def show
	 @happinesstracker = Happinesstracker.find(params[:id])
  end

  def new
    @happinesstracker = Happinesstracker.new
  end

  def edit
  end

  def create	
   @happinesstracker = Happinesstracker.new(happinesstracker_params)
 
   @happinesstracker.save
   redirect_to @happinesstracker
  end

  def update
	@happinesstracker = Happinesstracker.find(params[:id])
	
	if params[:answer] == "true"
	@answer = Answer.new(happinesstracker_id: @happinesstracker.id, answer: true)
	@answer.save
	else
	@answer = Answer.new(happinesstracker_id: @happinesstracker.id, answer: false)
	@answer.save
    end
	
    redirect_to @happinesstracker	
  end

  def destroy
  end
  
  private
  def happinesstracker_params
    params.require(:happinesstracker).permit(:question)
  end
end
