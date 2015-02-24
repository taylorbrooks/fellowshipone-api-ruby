require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
end

task default: :test

namespace :docs do

  desc 'Build the docs for the FellowshipOne API.'
  task :build do
    system('rm -rf doc')
    system('yardoc --no-private --protected lib/**/*.rb')
  end

end
