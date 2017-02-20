class AddScoreToChoice < ActiveRecord::Migration[5.0]
  def change
    add_column :choices, :score, :integer
  end
end
