require 'simplecov-gem-profile'
require 'coveralls'
Coveralls.wear! 'gem' if ENV['COVERALLS_REPO_TOKEN']
SimpleCov.start 'gem' if ENV['COVERAGE']

require 'chameleon/vm'
require 'support/matchers'
require 'support/shared_contexts'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.mock_with :rspec

  config.order = 'random'
end
