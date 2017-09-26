class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.belongs_to :user
      t.belongs_to :review
      t.boolean :vote_score
      t.timestamps 
    end
  end
end
