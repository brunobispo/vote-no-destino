# == Schema Information
#
# Table name: surveys
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Survey < ApplicationRecord
  has_many :options
  has_many :answers
  has_many :choices, through: :answers
end
