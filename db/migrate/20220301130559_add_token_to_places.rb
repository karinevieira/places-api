class AddTokenToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :token, :string, null: false
    add_index :places, :token
  end
end
