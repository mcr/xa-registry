class AddDocIdToRule < ActiveRecord::Migration
  def change
    add_column :rules, :doc_id, :string
  end
end
