require 'rails_helper'

feature 'Answer the survey', type: :feature, js: true do
  scenario 'shows options to choose' do
    create(:option, name: 'São Paulo')
    create(:option, name: 'Rio de Janeiro')
    visit new_answer_path
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('Rio de Janeiro')
  end

  scenario 'asks to choose between each combination' do
    create(:option, name: 'São Paulo')
    create(:option, name: 'Rio de Janeiro')
    create(:option, name: 'Dublin')

    visit new_answer_path

    9.times do
      case page.text
        when /Rio de Janeiro/ then choose 'Rio de Janeiro'
        when /São Paulo/ then choose 'São Paulo'
        when /Dublin/ then choose 'Dublin'
        when /Barcelona/ then choose 'Barcelona'
        when /Lisboa/ then choose 'Lisboa'
      end
      break if page.text.include? t('show_result')
    end

    expect(page).to have_content(t 'show_result')
  end

  scenario 'save answer and user' do
    finish_the_answering
    fill_in User.human_attribute_name('name'), with: 'Bruno'
    fill_in User.human_attribute_name('email'), with: 'me@brunobispo.com'

    expect{
      click_on t('show_result')
      expect(page).to have_content(t 'registration_successful')
    }.to change{ Answer.count }.by(1).and(change{ User.count }.by(1))
  end

  def finish_the_answering
    create(:option, name: 'São Paulo')
    create(:option, name: 'Rio de Janeiro')
    visit new_answer_path
    choose 'São Paulo'
  end
end