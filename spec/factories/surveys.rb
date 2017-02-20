# == Schema Information
#
# Table name: surveys
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :survey do
    transient do
      options_count 0
    end

    after(:create) do |survey, evaluator|
      create_list(:option, evaluator.options_count, survey: survey)
    end
  end
end
