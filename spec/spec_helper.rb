# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

# ## CodeClimate coverage report ###############################################

require 'simplecov-gem-adapter'
require 'codeclimate-test-reporter'
require 'coveralls'

CodeClimate::TestReporter.configure do |config|
  config.profile = 'gem'
end
CodeClimate::TestReporter.start

Coveralls.wear!

# ##############################################################################

require 'chameleon/vm'
require 'support/matchers'
require 'support/shared_contexts'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.mock_with :rspec

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
