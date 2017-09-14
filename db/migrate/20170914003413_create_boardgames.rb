class CreateBoardgames < ActiveRecord::Migration[5.1]
  def change
    create_table :boardgames do |t|
      t.text :title
      t.text :genre
      t.text :publisher
      t.text :player_count
      t.integer :duration
      t.decimal  :msrp, precision: 6, scale: 2
    end
  end
end
