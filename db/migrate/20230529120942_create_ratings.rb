class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.decimal :age
      t.decimal :whiteness
      t.decimal :dryness
      t.decimal :pureness
      t.references :rice, null: false, foreign_key: true
      t.timestamps
    end
  end
end