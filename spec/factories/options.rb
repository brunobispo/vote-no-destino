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

FactoryGirl.define do
  factory :option do
    name Faker::Name.name
    survey
  end
end
