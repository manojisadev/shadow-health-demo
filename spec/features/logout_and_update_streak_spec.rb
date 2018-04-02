require 'rails_helper'

feature 'User logout' do
  context 'user with streak 1, score 8, session streak 2' do
    let!(:user) {FactoryBot.create(:user, email: 'testuser@example.com', score: 8, streak: 1)}
    scenario 'Allow user to login if credentials are correct' do
      page.set_rack_session(streak_count: 2)

      visit new_user_session_path

      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'

      expect(page.current_path).to eq(root_path)
      expect(page).to have_content('Signed in successfully.')

      click_link 'Sign out'

      expect(page.current_path).to eq(root_path)

      expect(page).to have_content('Signed out successfully.')

      user.reload

      expect(user.score).to eq(8)
      expect(user.streak).to eq(2)
    end
  end
end