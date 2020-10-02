class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.integer :postage, null: false
      t.integer :charge, null: false
      t.integer :pay, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.string :postcode, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
