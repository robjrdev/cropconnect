class AddUserToRices < ActiveRecord::Migration[7.0]
  def change
    add_reference :rice, :user, null: false, foreign_key: true
  end
end
