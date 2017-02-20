require 'rails_helper'

feature 'Answer the survey', type: :feature, js: true do
  scenario 'shows options to choose' do
    survey = create(:survey)
    create(:option, name: 'São Paulo', survey: survey)
    create(:option, name: 'Rio de Janeiro', survey: survey)
    visit new_answer_path
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('Rio de Janeiro')
  end

  scenario 'asks to choose between each combination' do
    survey = create(:survey)
    create(:option, name: 'São Paulo', survey: survey)
    create(:option, name: 'Rio de Janeiro', survey: survey)
    create(:option, name: 'Dublin', survey: survey)

    visit new_answer_path

    9.times do
      case page.text
        when /Rio de Janeiro/ then choose 'Rio de Janeiro'
        when /São Paulo/ then choose 'São Paulo'
        when /Dublin/ then choose 'Dublin'
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

  scenario 'show results' do
    survey = create(:survey)
    create(:option, name: 'São Paulo', survey: survey)
    create(:option, name: 'Rio de Janeiro', survey: survey)
    create(:option, name: 'Dublin', survey: survey)
    create(:option, name: 'Barcelona', survey: survey)
    create(:option, name: 'Lisboa', survey: survey)

    # previous answers
    answer = create(:answer, survey: survey)
    answer.choices.create(chosen: survey.options[2]) # Dublin
    answer.choices.create(chosen: survey.options[0]) # São Paulo
    answer.choices.create(chosen: survey.options[3]) # Barcelona
    answer.choices.create(chosen: survey.options[4]) # Lisboa
    answer.choices.create(chosen: survey.options[1]) # Rio de Janeiro

    visit new_answer_path

    25.times do
      case page.text
        when /Rio de Janeiro/ then choose 'Rio de Janeiro'
        when /Dublin/ then choose 'Dublin'
        when /Barcelona/ then choose 'Barcelona'
        when /Lisboa/ then choose 'Lisboa'
        when /São Paulo/ then choose 'São Paulo'
      end
      break if page.text.include? t('show_result')
    end

    fill_the_form

    expect(page).to have_content(t 'your_ranking')
    expect(page.text).to match(/Rio de Janeiro.*Dublin.*Barcelona.*Lisboa.*São Paulo/)
    
    expect(page).to have_content(t 'general_ranking')
    wait_for_ajax { expect(page.text).to match(/Dublin.*Barcelona.*Rio de Janeiro.*São Paulo.*Lisboa/) }
  end

  def finish_the_answering
    survey = create(:survey)
    create(:option, name: 'São Paulo', survey: survey)
    create(:option, name: 'Rio de Janeiro', survey: survey)
    visit new_answer_path
    choose 'São Paulo'
  end

  def fill_the_form
    fill_in User.human_attribute_name('name'), with: 'Bruno'
    fill_in User.human_attribute_name('email'), with: 'me@brunobispo.com'
    click_on t('show_result')
  end
end