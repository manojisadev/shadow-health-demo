require 'rails_helper'

feature 'User Login' do
  let(:user) { FactoryBot.create(:user) }

  scenario 'Allow user to login if credentials are correct' do
    visit new_user_session_path

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'

    expect(page.current_path).to eq(root_path)
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'Deny acces if credentials are incorrect' do
    visit new_user_session_path

    fill_in 'user[email]', with: 'InvalidUser'
    fill_in 'user[password]', with: 'InvalidPassword'
    click_button 'Log in'

    expect(page.current_path).to eq(new_user_session_path)
    expect(page).to have_content('Invalid Email or password.')
  end
end