# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tidyflash}
  s.version = "0.9.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Michael Forrest}]
  s.date = %q{2011-09-23}
  s.description = %q{Tidy Flash - an ActionScript framework for people who love Ruby}
  s.email = %q{mf@grimaceworks.com}
  s.executables = [%q{tidyflash}, %q{tidyflash-server}]
  s.extra_rdoc_files = [%q{README}, %q{bin/tidyflash}, %q{bin/tidyflash-server}, %q{lib/tidy/air_packager.rb}, %q{lib/tidy/axml.rb}, %q{lib/tidy/bwlimit.rb}, %q{lib/tidy/compile.rb}, %q{lib/tidy/demo_config.rb}, %q{lib/tidy/generate.rb}, %q{lib/tidy/server.rb}, %q{lib/tidy/template.rb}, %q{lib/tidy/template_binding.rb}, %q{lib/tidy/templates/demo_config.as.erb}, %q{lib/tidy/version.rb}, %q{lib/tidy_project.rb}]
  s.files = [%q{Assets/TidyHome.ai}, %q{Gemfile}, %q{Gemfile.lock}, %q{Manifest}, %q{README}, %q{Rakefile}, %q{bin/tidyflash}, %q{bin/tidyflash-server}, %q{lib/tidy/air_packager.rb}, %q{lib/tidy/axml.rb}, %q{lib/tidy/bwlimit.rb}, %q{lib/tidy/compile.rb}, %q{lib/tidy/demo_config.rb}, %q{lib/tidy/generate.rb}, %q{lib/tidy/server.rb}, %q{lib/tidy/template.rb}, %q{lib/tidy/template_binding.rb}, %q{lib/tidy/templates/demo_config.as.erb}, %q{lib/tidy/version.rb}, %q{lib/tidy_project.rb}, %q{templates/eclipsify/eclipsify.rb}, %q{templates/project/Gemfile}, %q{templates/project/Rakefile}, %q{templates/project/config/templates/air.axml.erb}, %q{templates/project/project.rb}, %q{templates/project/script/fcsh/rakefile.rb}, %q{templates/project/src/app/helpers/Colours.as}, %q{templates/project/src/app/helpers/Debug.as}, %q{templates/project/src/app/helpers/Style.as}, %q{templates/project/src/app/helpers/Typography.as}, %q{templates/project/src/app/models/App.as}, %q{templates/project/src/app/models/FlashVars.as}, %q{templates/project/src/app/views/MainView.as}, %q{templates/project/src/app/views/PreloaderView.as}, %q{templates/project/src/app/views/ViewBase.as}, %q{templates/project/src/library/fonts/Fonts.as}, %q{templates/project/src/library/images/README.txt}, %q{templates/project/tasks/deploy.rake}, %q{templates/project/tasks/library.rake}, %q{templates/scaffold/bin/xml/__model.xml}, %q{templates/scaffold/scaffold.rb}, %q{templates/scaffold/src/models/__Model.as}, %q{templates/scaffold/src/views/__model/__ModelDetailView.as}, %q{templates/scaffold/src/views/__model/__ModelListItemView.as}, %q{templates/scaffold/src/views/__model/__ModelListView.as}, %q{templates/web/bin/index.html}, %q{templates/web/bin/js/swfobject.js}, %q{templates/web/web.rb}, %q{test/test_tidy_project.rb}, %q{tools/TidyHarness/bin/tidy_harness.axml}, %q{tools/TidyHarness/bin/tidy_harness.swf}, %q{tools/TidyHarness/config/templates/air.axml.erb}, %q{tools/TidyHarness/rakefile.rb}, %q{tools/TidyHarness/script/fcsh/rakefile.rb}, %q{tools/TidyHarness/src/app/helpers/Colours.as}, %q{tools/TidyHarness/src/app/helpers/Debug.as}, %q{tools/TidyHarness/src/app/helpers/Style.as}, %q{tools/TidyHarness/src/app/helpers/Typography.as}, %q{tools/TidyHarness/src/app/models/App.as}, %q{tools/TidyHarness/src/app/models/FlashVars.as}, %q{tools/TidyHarness/src/app/views/MainView.as}, %q{tools/TidyHarness/src/app/views/PreloaderView.as}, %q{tools/TidyHarness/src/app/views/ViewBase.as}, %q{tools/TidyHarness/src/assets/fonts/Fonts.as}, %q{tools/TidyHarness/tasks/assets.rb}, %q{tools/TidyHarness/tasks/deploy.rb}, %q{tidyflash.gemspec}]
  s.homepage = %q{http://github.com/michaelforrest/tidy}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Tidyflash}, %q{--main}, %q{README}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{tidyflash}
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Tidy Flash - an ActionScript framework for people who love Ruby}
  s.test_files = [%q{test/test_tidy_project.rb}]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
