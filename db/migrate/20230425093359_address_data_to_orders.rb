class AddressDataToOrders < ActiveRecord::Migration[6.1]
  def change
  add_column :orders, :address_data, :json
  end
end
