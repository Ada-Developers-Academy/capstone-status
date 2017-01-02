class AddCohort < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :cohort, :string
  end
end
