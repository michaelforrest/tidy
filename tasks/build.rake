namespace :build do
  desc "Does build_gemspec (doesn't show up in rake -T normally)"
  task :gemspec => :build_gemspec 
end