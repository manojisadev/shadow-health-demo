require 'rails_helper'

feature 'Ranking Check' do
  #Use let! to avoid lazy loading
  let!(:user) { FactoryBot.create(:user, score: 8) }
  let!(:user_two) { FactoryBot.create(:user, email: 'user2@example.com', score: 6) }

  scenario 'User logins in checks ranking page' do
    login_as(user, :scope => :user)
    visit root_path
    click_link 'Ranking'

    expect(page.current_path).to eq(ranking_path)
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.score)


    expect(page).to have_content(user_two.email)
    expect(page).to have_content(user_two.score)
  end
end