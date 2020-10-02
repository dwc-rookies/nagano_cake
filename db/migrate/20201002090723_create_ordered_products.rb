class CreateOrderedProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :ordered_products do |t|
      t.integer :order_id, null: false
      t.integer :product_id, null: false
      t.integer :quantity, null: false
      t.integer :purchase_money, null: false
      t.integer :production_status, null: false, default: 0
      t.timestamps
    end
  end
end
