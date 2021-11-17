class AddColumnToCoin < ActiveRecord::Migration[5.2]
  def change
    add_column :coins, :active, :boolean, default: 1
  end
end
