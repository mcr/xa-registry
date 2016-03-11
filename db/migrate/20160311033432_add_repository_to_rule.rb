class AddRepositoryToRule < ActiveRecord::Migration
  def change
    add_reference :rules, :repository, index: true, foreign_key: true
  end
end
