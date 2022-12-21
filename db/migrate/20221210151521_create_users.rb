class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :firstname, index: true
      t.string :lastname, index: true

      t.timestamps
    end
  end
end
