# this gets appended to the task defined by echoe
desc "release to github"
task :git_release=>[:clean, :manifest, 'build:gemspec'] do
  puts "committing all changes"
  `git commit -am "releasing"`
  puts "pushing to github"
  `git push`
end
