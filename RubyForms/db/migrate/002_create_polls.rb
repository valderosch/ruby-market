class CreatePolls < ActiveRecord::Migration[7.1]
  def change
    create_table :polls do |t|
      t.references :user, foreign_key: true
      t.string :question
      t.string :answer
      t.timestamps
    end
  end
end
