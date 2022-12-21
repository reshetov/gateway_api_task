class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :account
      t.string :api_id
      t.boolean :duplicated
      t.integer :mode
      t.integer :status
      t.date :made_on
      t.decimal :amount, precision: 12, scale: 3
      t.string :currency_code
      t.string :description
      t.string :category
      t.timestamps
    end
  end
end
