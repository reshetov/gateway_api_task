class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.references :connection
      t.string :api_id
      t.string :name
      t.integer :nature
      t.decimal :balance, precision: 12, scale: 3
      t.string :currency_code
      t.timestamps
    end
  end
end
