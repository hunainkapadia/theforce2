class CreateC1answers < ActiveRecord::Migration
  def change
    create_table :c1answers do |t|
      t.boolean :answer
      t.integer :questionnbr

      t.timestamps
    end
  end
end
