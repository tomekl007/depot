class CreatePaymentTypes < ActiveRecord::Migration
  def change
    create_table :payment_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :payment_types
  end
end
