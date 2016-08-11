class AddIndexToCheckinsCollectedAt < ActiveRecord::Migration[5.0]
  def change
    add_index :checkins, :collected_at
  end
end
