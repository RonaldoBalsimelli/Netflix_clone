# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.2.0]
### Added
* Added `rephrase` functionality to get a new version of submitted text with various possible styles or tones applied
* Added `DeepL::Constants` namespace and associated constant values for options possibilities

## [3.1.0]
### Added
* Added `model_type` option to `translate()` to use models with higher
  translation quality (available for some language pairs), or better latency.
  Options are `'quality_optimized'`, `'latency_optimized'`, and  `'prefer_quality_optimized'`
* Added the `model_type_used` field to the `translate()` response, that
  indicates the translation model used when the `model_type` option is
  specified.


## [3.0.2] - 2024-10-02
### Added
* Added doc example and tests for context parameter
### Fixed
* Fix metadata displayed on RubyGems.org for this library.
* Fixed library version sent in the `User-Agent` string.

## [3.0.1] - 2024-09-23
### Fixed
* `document.translate_document` required a filename, this is now optional. The example in the README now works.

## [3.0.0] - 2024-09-20
Beginning with version 3, deepl-rb is officially supported by DeepL, and maintained together with [Daniel Herzog](mailto:info@danielherzog.es) the developer of earlier versions of this library.
The change in major version is only due to the change in maintainership, there is no migration necessary from v2 to v3.
### Added
* Added rubocop-rspec linting for rspec test files
* Added document translation to the ruby CL
* Added possibility to use one HTTP session for multiple calls
* Added platform and ruby version information to the user-agent string that is sent with API calls, along with an opt-out
* Added support for logging of HTTP requests
* Added support for using a proxy and a custom certificate file
* Added a gitlab CI pipeline
### Changed
* HTTP requests to the DeepL API now use `application/json`, rather than `application/www-form-unencoded`
* HTTP requests now automatically retry on transient failures, using exponential backoff
### Deprecated
### Removed
* Removed CircleCI and CodeCov upload
### Fixed
### Security

## [2.5.3] - 2022-09-26
### Fixed
* Make RequestEntityTooLarge error message more clear

[3.2.0]: https://github.com/DeepLcom/deepl-rb/compare/v3.1.0...3.2.0
[3.1.0]: https://github.com/DeepLcom/deepl-rb/compare/v3.0.2...v3.1.0
[3.0.2]: https://github.com/DeepLcom/deepl-rb/compare/v3.0.1...v3.0.2
[3.0.1]: https://github.com/DeepLcom/deepl-rb/compare/v3.0.0...v3.0.1
[3.0.0]: https://github.com/DeepLcom/deepl-rb/compare/v2.5.3...v3.0.0
[2.5.3]: https://github.com/DeepLcom/deepl-rb/compare/v2.5.2...v2.5.3
