# this gets appended to the task defined by echoe
desc "release to github"
task :git_release=>[:clean, :manifest, 'build:gemspec'] do
  puts "pushing to github"
  `git add .`
  `git commit -am "releasing"`
  `git push`
end
