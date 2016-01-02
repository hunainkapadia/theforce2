class FixName < ActiveRecord::Migration
  def change
  	rename_column :open_questions, :question, :openquestion
  	rename_column :closed_questions, :question, :closedquestion
  end
end
