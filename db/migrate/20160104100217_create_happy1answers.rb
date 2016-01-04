class CreateHappy1answers < ActiveRecord::Migration
  def change
    create_table :happy1answers do |t|
      t.boolean :hanswer

      t.timestamps
    end
  end
end
