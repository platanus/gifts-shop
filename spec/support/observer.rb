RSpec.configure do |config|
  config.before do
    PowerTypes::Observable.observable_disabled = true
  end
end
