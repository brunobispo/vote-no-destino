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

FactoryGirl.define do
  factory :answer do
    survey
    user
  end
end
