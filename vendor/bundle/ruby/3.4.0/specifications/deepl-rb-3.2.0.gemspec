# -*- encoding: utf-8 -*-
# stub: deepl-rb 3.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "deepl-rb".freeze
  s.version = "3.2.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/DeepLcom/deepl-rb/issues", "changelog_uri" => "https://github.com/DeepLcom/deepl-rb/blob/main/CHANGELOG.md", "documentation_uri" => "https://github.com/DeepLcom/deepl-rb/blob/main/README.md", "homepage_uri" => "https://github.com/DeepLcom/deepl-rb" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["DeepL SE".freeze]
  s.date = "2025-01-15"
  s.description = "Official Ruby library for the DeepL language translation API (v2). For more information, check this: https://www.deepl.com/docs/api-reference.html".freeze
  s.email = "open-source@deepl.com".freeze
  s.extra_rdoc_files = ["CHANGELOG.md".freeze, "LICENSE.md".freeze, "README.md".freeze, "license_checker.sh".freeze]
  s.files = ["CHANGELOG.md".freeze, "LICENSE.md".freeze, "README.md".freeze, "license_checker.sh".freeze]
  s.homepage = "https://github.com/DeepLcom/deepl-rb".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.5.3".freeze
  s.summary = "Official Ruby library for the DeepL language translation API.".freeze

  s.installed_by_version = "3.6.2".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<juwelier>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<byebug>.freeze, [">= 0".freeze])
end
