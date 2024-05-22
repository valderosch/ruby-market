class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.integer :polls_count, default: 0
      t.integer :accuracy, default: 0
      t.timestamps
    end
  end
end
