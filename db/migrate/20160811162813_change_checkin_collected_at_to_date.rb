class ChangeCheckinCollectedAtToDate < ActiveRecord::Migration[5.0]
  def up
    change_column :checkins, :collected_at, :date
  end

  def down
    change_column :checkins, :collected_at, :datetime
  end
end
