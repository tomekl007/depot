class AddShipDateColumnToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :ship_date, :date
  end
  def down
    remove_column :orders,:ship_date
  end
end
