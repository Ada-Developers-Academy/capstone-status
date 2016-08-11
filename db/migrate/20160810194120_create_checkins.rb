class CreateCheckins < ActiveRecord::Migration[5.0]
  def change
    create_table :checkins do |t|
      t.belongs_to :student
      t.text :yesterday
      t.text :today
      t.text :blockers
      t.datetime :collected_at
      t.timestamps
    end
  end
end
