class AddPublicIdToAll < ActiveRecord::Migration
  def change
    change_table :repositories do |t|
      t.string :public_id
    end
    change_table :rules do |t|
      t.string :public_id
    end
  end
end
