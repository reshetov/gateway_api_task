class CreateConnections < ActiveRecord::Migration[6.1]
  def change
    create_table :connections do |t|
      t.string :uuid, index: true
      t.references :customer
      t.string :connection_id, index: true, null: false
      t.string :connection_secret
      t.datetime :expires_at
      t.string :attempt_id
      t.string :token
      t.string :access_token
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
