class AddNextRefreshToConnection < ActiveRecord::Migration[6.1]
  def change
    add_column :connections, :next_refresh, :datetime
  end
end
