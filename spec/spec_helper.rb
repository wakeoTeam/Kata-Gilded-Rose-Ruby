require 'simplecov'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!
  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.order = :random
  Kernel.srand config.seed
end

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/bin/'
  # add_filter '/vendor/'
  #
  add_group 'Lib', 'lib'
  # add_group 'Models', 'app/models'
  # add_group 'Helpers', 'app/helpers'
  # add_group 'Mailers', 'app/mailers'
end
# OPTIONAL
# This outputs the report to your public folder
# You will want to add this to .gitignore
SimpleCov.coverage_dir 'public/coverage'

