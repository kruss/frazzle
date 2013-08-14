require "rubygems/package_task"

spec = Gem::Specification.load("gemspec")
Gem::PackageTask.new(spec){ |pkg| }

desc "Install the gem"
task :install => [:gem] do
    sh("gem install pkg/#{spec.name}-#{spec.version}.gem")
end

desc "Uninstall the gem"
task :uninstall => [:clobber_package] do
    sh("gem uninstall #{spec.name}")
end