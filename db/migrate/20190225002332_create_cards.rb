class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :cards
      t.string :hand

      t.timestamps
    end
  end
end
