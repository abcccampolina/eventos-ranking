require 'test_helper'
require 'generators/rails/stimulus_scaffold/stimulus_scaffold_generator'

class Rails::StimulusScaffoldGeneratorTest < Rails::Generators::TestCase
  tests Rails::StimulusScaffoldGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
