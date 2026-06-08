# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Pivot from Travis CI to GitHub Actions for continuous integration. ([#30](https://github.com/DatabaseCleaner/database_cleaner-sequel/pull/30))

## [2.0.2] - 2022-03-08

### Fixed

- Allow empty options for the truncation strategy. ([#26](https://github.com/DatabaseCleaner/database_cleaner-sequel/pull/26))

## [2.0.1] - 2022-03-01

### Fixed

- `Truncation.new` now takes a `Hash` as an argument instead of named parameters, to maintain Ruby 3 compatibility with `database_cleaner`'s calling convention. ([#20](https://github.com/DatabaseCleaner/database_cleaner-sequel/pull/20))
- Rename the `:connection` configuration option to `:db` in the README.

## [2.0.0] - 2021-01-31

### Added

- Add a `docker-compose.yml` for test database setup. ([#11](https://github.com/DatabaseCleaner/database_cleaner-sequel/pull/11))
- Use auto savepoints for transactions.

### Changed

- Split `database_cleaner-sequel` out of the main `database_cleaner` repository into its own gem.
- Update to the new adapter API from `database_cleaner` core.
- Requiring this gem must now explicitly configure `DatabaseCleaner` to use it, since autodetection has been removed.
- Drop support for Ruby 2.4, which reached end of life on 2020-03-31.
- Drop support for the `mysql` (mysql1) adapter.
- Upgrade dependencies and drop support for older Rubies.

## [2.0.0.beta] - 2020-05-30

### Changed

- Begin development on the standalone `2.0.0` line of the gem.

[Unreleased]: https://github.com/DatabaseCleaner/database_cleaner-sequel/compare/v2.0.2...HEAD
[2.0.2]: https://github.com/DatabaseCleaner/database_cleaner-sequel/compare/v2.0.1...v2.0.2
[2.0.1]: https://github.com/DatabaseCleaner/database_cleaner-sequel/compare/v2.0.0...v2.0.1
[2.0.0]: https://github.com/DatabaseCleaner/database_cleaner-sequel/compare/v2.0.0.beta...v2.0.0
[2.0.0.beta]: https://github.com/DatabaseCleaner/database_cleaner-sequel/releases/tag/v2.0.0.beta
