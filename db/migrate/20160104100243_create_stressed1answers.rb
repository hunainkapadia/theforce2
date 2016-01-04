class CreateStressed1answers < ActiveRecord::Migration
  def change
    create_table :stressed1answers do |t|
      t.boolean :sanswer

      t.timestamps
    end
  end
end
