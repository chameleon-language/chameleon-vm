require 'bundler/gem_tasks'

desc 'Open an irb session preloaded with this library'
task :console do
  sh 'irb -rubygems -I lib -r chameleon/vm.rb'
end

if ENV['RACK_ENV'] == 'test'
  require 'rainbow'
  require 'rspec/core/rake_task'
  require 'rubocop/rake_task'
  require 'rubycritic'

  namespace :ci do
    desc 'Run specs'
    RSpec::Core::RakeTask.new(:specs) do |t|
      t.verbose = false
      t.rspec_opts = ['--format documentation',
                      '-t ~@skip-ci',
                      '--failure-exit-code 1']
    end

    desc 'Run rubocop'
    RuboCop::RakeTask.new(:rubocop) do |t|
      t.fail_on_error = true
      t.verbose = false
      t.formatters = ['RuboCop::Formatter::SimpleTextFormatter']
      t.options = ['-D']
    end

    desc 'Run rubycritic'
    task :rubycritic do
      @rubycritic = ::Rubycritic::Orchestrator.new
      analysed_files = @rubycritic.critique ['lib']
      analysed_files.each do |file|
        color = case file.rating.to_s
                when 'A' then :green
                when 'B' then :yellow
                else :red
                end
        puts Rainbow("\s\s#{file.rating} | #{file.path}").send(color)
      end
      fail 'something smells' if analysed_files.map { |file| file.rating.to_s }.max > 'B'
    end

    desc 'Run things for ci'
    task :build do
      puts Rainbow('Running rubocop').blue
      Rake::Task['ci:rubocop'].invoke

      puts

      puts Rainbow('Running rspec').blue
      Rake::Task['ci:specs'].invoke

      puts

      puts Rainbow('Running rubycritic').blue
      Rake::Task['ci:rubycritic'].invoke
    end
  end
end
