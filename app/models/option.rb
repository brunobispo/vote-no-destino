# == Schema Information
#
# Table name: options
#
#  id         :integer          not null, primary key
#  name       :string
#  image_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  survey_id  :integer
#

class Option < ApplicationRecord
  belongs_to :survey
  has_many :choices, foreign_key: :chosen_id

  def score
    choices.sum(:score).to_f / survey.choices.sum(:score)
  end
end
