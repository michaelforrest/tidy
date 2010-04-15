# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tidyflash}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Forrest"]
  s.date = %q{2010-04-15}
  s.description = %q{Tidy Flash - an ActionScript framework for people who love Ruby}
  s.email = %q{mf@grimaceworks.com}
  s.executables = ["test_project.axml", "tidyflash"]
  s.extra_rdoc_files = ["README", "bin/test_project.axml", "bin/tidyflash", "lib/script/bwlimit.rb", "lib/script/generate", "lib/script/server", "lib/script/server.rb", "lib/tasks/assets.rb", "lib/tasks/demo_config.rb", "lib/tasks/deploy.rb", "lib/tidy/axml.rb", "lib/tidy/compile.rb", "lib/tidy/generate.rb", "lib/tidy/template.rb", "lib/tidy/template_binding.rb", "lib/tidy/templates/air.axml.erb", "lib/tidy/templates/demo_config.as.erb", "lib/tidy_project.rb"]
  s.files = ["Manifest", "README", "Rakefile", "bin/test_project.axml", "bin/tidyflash", "lib/script/bwlimit.rb", "lib/script/generate", "lib/script/server", "lib/script/server.rb", "lib/tasks/assets.rb", "lib/tasks/demo_config.rb", "lib/tasks/deploy.rb", "lib/tidy/axml.rb", "lib/tidy/compile.rb", "lib/tidy/generate.rb", "lib/tidy/template.rb", "lib/tidy/template_binding.rb", "lib/tidy/templates/air.axml.erb", "lib/tidy/templates/demo_config.as.erb", "lib/tidy_project.rb", "templates/project/project.rb", "templates/project/rakefile.rb", "templates/project/script/fcsh/rakefile.rb", "templates/project/src/app/helpers/Colours.as", "templates/project/src/app/helpers/Debug.as", "templates/project/src/app/helpers/Typography.as", "templates/project/src/app/models/App.as", "templates/project/src/app/models/FlashVars.as", "templates/project/src/app/views/MainView.as", "templates/project/src/app/views/PreloaderView.as", "templates/scaffold/bin/xml/__model.xml", "templates/scaffold/scaffold.rb", "templates/scaffold/src/models/__Model.as", "templates/scaffold/src/views/__model/__ModelDetailView.as", "templates/scaffold/src/views/__model/__ModelListItemView.as", "templates/scaffold/src/views/__model/__ModelListView.as", "templates/swfobject/bin/index.html", "templates/swfobject/bin/js/swfobject.js", "templates/swfobject/swfobject.rb", "test/test_tidy_project.rb", "tidyflash.gemspec"]
  s.homepage = %q{http://github.com/michaelforrest/tidy}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Tidyflash", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{tidyflash}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Tidy Flash - an ActionScript framework for people who love Ruby}
  s.test_files = ["test/test_tidy_project.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
