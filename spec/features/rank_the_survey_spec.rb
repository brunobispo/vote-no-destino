require 'rails_helper'

feature 'Rank the survey', type: :feature, js: true do
  scenario 'shows options to choose' do
    create(:option, name: 'São Paulo')
    create(:option, name: 'Rio de Janeiro')
    create(:option, name: 'Curitiba')
    visit new_answer_path

    if page.find('São Paulo') && page.find('Curitiba')
      click_on 'São Paulo'
    end

    if page.find('São Paulo') && page.find('Rio de Janeiro')
      click_on 'Rio de Janeiro'
    end

    if page.find('Curitiba') && page.find('Rio de Janeiro')
      click_on 'Curitiba'
    end

    form_up_user_data

    expect(page.text).to match(/Curitiba.*São Paulo.*Rio de Janeiro/)
  end

  def form_up_user_data
    fill_in t('name'), with: 'Bruno'
    fill_in t('email'), with: 'me@brunobispo.com'
    click_on t('show_results')
  end
end