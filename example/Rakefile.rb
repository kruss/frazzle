gems = [ "pizza", "pizza-stone-oven", "pizza-electric-oven" ]

desc "Setup the example"
task :setup do
  gems.each do |gem|
    cd "#{gem}" do
      sh("rake install")
    end
  end
end

desc "Teardown the example"
task :teardown do
  gems.each do |gem|
    cd "#{gem}" do
      sh("rake uninstall")
    end
  end
end

desc "Run the example"
task :run => [:setup] do
  sh("pizza")
  Rake::Task["teardown"].invoke
end

desc "Run the example as test"
task :test => [:setup, :run, :teardown]

task :default => [:test]
