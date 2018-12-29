require "rails_helper"
include HomeHelper

RSpec.feature 'Scheduling', type: :feature do
  scenario 'user visits the form' do
    visit root_path
    expect(page).to have_css 'input[type="datetime-local"][id="datetime_start"]'
    expect(page).to have_css 'select[id="frequency"]'
    expect(page).to have_css 'input[type="datetime-local"][id="datetime_start"]'
    expect(page).to have_css 'input[type="number"][id="items_count"]'
    expect(page).to have_button 'generate'
  end

  scenario 'user generates schedule with default parameters' do
    datetime = DateTime.now
    allow(DateTime).to receive(:now) { datetime }
    visit root_path
    click_button 'generate'
    14.times do
      expect(page).to have_text schedule_item_formatted(datetime)
      datetime += 1.day
    end
  end

  scenario 'user generates schedule with custom parameters' do
    datetime = DateTime.now - 1.day
    visit root_path

    fill_in 'datetime_start', with: datetime
    select 'Weekly', from: 'frequency'
    fill_in 'items_count', with: 3

    click_button 'generate'

    3.times do
      expect(page).to have_text schedule_item_formatted(datetime)
      datetime += 1.week
    end
  end
end