# == Schema Information
#
# Table name: answers
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Answer < ApplicationRecord
  has_many :choices
  belongs_to :user

  accepts_nested_attributes_for :choices, :user
end
