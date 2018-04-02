RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.after :each do
    Warden.test_reset!
  end
end