class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.text :comment
      t.integer :review_score, default: 0
    end
  end
end
