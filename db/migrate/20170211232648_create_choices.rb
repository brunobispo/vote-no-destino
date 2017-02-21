class CreateChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :choices do |t|
      t.references :chosen, references: :options
      t.references :answer, foreign_key: true
      t.foreign_key :options, column: :chosen_id
      
      t.timestamps
    end
  end
end
