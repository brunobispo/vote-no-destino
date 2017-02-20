# == Schema Information
#
# Table name: answers
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  survey_id  :integer
#

class Answer < ApplicationRecord
  belongs_to :survey
  has_many :choices, -> { order(id: :asc) }
  belongs_to :user

  accepts_nested_attributes_for :choices, :user
end
