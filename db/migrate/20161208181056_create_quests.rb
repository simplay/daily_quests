class CreateQuests < ActiveRecord::Migration[5.0]
  def change
    create_table :quests do |t|
      t.string :title
      t.string :description
      t.datetime :due
      t.boolean :finished
      t.timestamps
    end
  end
end
