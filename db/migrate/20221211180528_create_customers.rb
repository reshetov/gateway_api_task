class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.references :user
      t.string :api_id
      t.string :api_secret

      t.timestamps
    end
  end
end
