class CreateRice < ActiveRecord::Migration[7.0]
  def change
    create_table :rice do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.decimal :bidding_price

      t.timestamps
    end
  end
end
