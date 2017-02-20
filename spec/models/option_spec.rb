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

require 'rails_helper'

RSpec.describe Option, type: :model do
  it 'calculates its own score' do
    survey = create(:survey, options_count: 3)
    
    answer1 = create(:answer, survey: survey)
    answer1.choices.create(chosen: survey.options[2])
    answer1.choices.create(chosen: survey.options[1])
    answer1.choices.create(chosen: survey.options[0])

    answer2 = create(:answer, survey: survey)
    answer2.choices.create(chosen: survey.options[1])
    answer2.choices.create(chosen: survey.options[2])
    answer2.choices.create(chosen: survey.options[0])

    expect(survey.options[0].score).to be 0.0
    expect(survey.options[1].score).to be 3.0/6
    expect(survey.options[2].score).to be 3.0/6
  end
end
