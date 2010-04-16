namespace :lib
  desc 'Update the Flash libraries from github'
  task :update do
    Dir.chdir("~/.tidy/tidy-as3") do
      `git pull`
    end
  end
end