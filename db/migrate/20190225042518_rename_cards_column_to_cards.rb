class RenameCardsColumnToCards < ActiveRecord::Migration[5.2]
  def change
    rename_column :cards, :cards, :card_set
  end
end
