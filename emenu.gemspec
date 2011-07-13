# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{emenu}
  s.version = "0.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Kresimir Bojcic}]
  s.date = %q{2011-07-13}
  s.description = %q{Enterprise class menus with simple ruby based configuration, easy to make, easy to maintain}
  s.email = %q{kresimir.bojcic@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "emenu.gemspec",
    "lib/emenu.rb",
    "lib/emenu/menu.rb",
    "lib/emenu/menu_config.rb",
    "lib/emenu/string.rb",
    "lib/generators/emenu/USAGE",
    "lib/generators/emenu/install_generator.rb",
    "lib/generators/emenu/templates/default_menus/emenus.rb",
    "lib/generators/emenu/templates/images/menu.png",
    "lib/generators/emenu/templates/images/menu_arrow.png",
    "lib/generators/emenu/templates/images/menu_border.png",
    "lib/generators/emenu/templates/images/menu_l.png",
    "lib/generators/emenu/templates/images/menu_l_selected.png",
    "lib/generators/emenu/templates/images/menu_minus.png",
    "lib/generators/emenu/templates/images/menu_plus.png",
    "lib/generators/emenu/templates/images/menu_r.png",
    "lib/generators/emenu/templates/images/menu_r_selected.png",
    "lib/generators/emenu/templates/images/menu_selected.png",
    "lib/generators/emenu/templates/javascripts/emenu.js",
    "lib/generators/emenu/templates/javascripts/jquery-1.4.2.min.js",
    "lib/generators/emenu/templates/stylesheets/emenu.css",
    "lib/generators/emenu/templates/stylesheets/reset.css",
    "spec/menu_config_spec.rb",
    "spec/menu_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/drKreso/emenu}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Enterprise class menus}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<haml>, ["~> 3.1.1"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0.3"])
      s.add_runtime_dependency(%q<actionpack>, ["~> 3.0.3"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 2.3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<haml>, ["~> 3.1.1"])
      s.add_dependency(%q<activesupport>, ["~> 3.0.3"])
      s.add_dependency(%q<actionpack>, ["~> 3.0.3"])
      s.add_dependency(%q<rspec-rails>, ["~> 2.3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<haml>, ["~> 3.1.1"])
    s.add_dependency(%q<activesupport>, ["~> 3.0.3"])
    s.add_dependency(%q<actionpack>, ["~> 3.0.3"])
    s.add_dependency(%q<rspec-rails>, ["~> 2.3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

