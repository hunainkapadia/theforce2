class CreateC2answers < ActiveRecord::Migration
  def change
    create_table :c2answers do |t|
      t.boolean :answer
      t.references :closedquestion, index: true

      t.timestamps
    end
  end
end
