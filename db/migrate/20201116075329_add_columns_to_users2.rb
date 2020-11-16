class AddColumnsToUsers2 < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :age , :integer
    add_column :users, :intro, :text
  end
end
