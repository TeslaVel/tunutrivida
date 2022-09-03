class PaymentBillingItems < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_billing_items do |t|
      t.references :payment, null: false, foreign_key: true, index: true
      t.references :billing_item, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
