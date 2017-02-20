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

require 'rails_helper'

RSpec.describe Choice, type: :model do
  it 'sets its own score' do
    answer = create(:answer, survey: create(:survey, options_count: 2))
    answer.choices.create(chosen: answer.survey.options[0])
    answer.choices.create(chosen: answer.survey.options[1])
    expect(answer.choices[0].score).to be 1
    expect(answer.choices[1].score).to be 0
    
    answer2 = create(:answer, survey: create(:survey, options_count: 2))
    answer2.choices.create(chosen: answer2.survey.options[0])
    answer2.choices.create(chosen: answer2.survey.options[1])
    expect(answer2.choices[0].score).to be 1
    expect(answer2.choices[1].score).to be 0
  end
end
