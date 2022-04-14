class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :post, null: false, foreign_key: true
      t.integer :user_id
      t.boolean :value
      t.timestamps
    end
    add_index :votes, %i[post_id user_id]
  end
end
