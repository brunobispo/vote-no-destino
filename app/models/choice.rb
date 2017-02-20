# == Schema Information
#
# Table name: choices
#
#  id         :integer          not null, primary key
#  chosen_id  :integer
#  answer_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  score      :integer
#

class Choice < ApplicationRecord
  belongs_to :chosen, class_name: 'Option'
  belongs_to :answer, optional: true
  has_one :survey, through: :answer

  before_save do
    self.score = survey.options.count - answer.choices.count - 1
  end
end
