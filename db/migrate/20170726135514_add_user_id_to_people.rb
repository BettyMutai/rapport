class AddUserIdToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column(:people,:user_id,:integer)
  end
end
