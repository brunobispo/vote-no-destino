class AddSurveyIdToOption < ActiveRecord::Migration[5.0]
  def change
    add_reference :options, :survey, foreign_key: true
  end
end
