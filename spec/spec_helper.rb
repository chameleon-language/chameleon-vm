require 'simplecov-gem-profile'
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.configure { |config| config.profile = 'gem' }
CodeClimate::TestReporter.start

require 'chameleon/vm'
require 'support/matchers'
require 'support/shared_contexts'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.mock_with :rspec

  config.order = 'random'
end
