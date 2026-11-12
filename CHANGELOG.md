# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- **Project Structure (Official Flutter Architecture)**:
  - Reorganized `lib/` into `lib/ui/`, `lib/domain/`, `lib/data/`, `lib/routing/`, `lib/config/`, and `lib/utils/`.
  - Moved feature screens and widgets into `lib/ui/features/<feature>/{view_models,views}/` and core UI helpers into `lib/ui/core/`.
  - Consolidated all domain entities and models under `lib/domain/models/`.
  - Organized API/local services under `lib/data/services/`, API request/response DTOs under `lib/data/models/`, and repositories under `lib/data/repositories/`.
  - Moved routing configuration to `lib/routing/` (`router.dart`, `routes.dart`, fixing the `rounting` directory typo).
  - Moved app constants, configuration, and dependency injection (`injector.dart`, `injector.config.dart`) to `lib/config/`.
  - Moved shared utilities (`result.dart`, `failures.dart`, `generic_response_data.dart`) to `lib/utils/`.
- **State Management & MVVM Standardization**:
  - Standardized all features on MVVM (`ChangeNotifier` / `flutter_it` `Command` + `Result<T>`).
  - Migrated `registered_user` feature from `bloc_signals_flutter` + `fpdart` `Either` + single-method UseCases to `ChangeNotifier` ViewModels (`RegisteredUserListViewModel`, `RegisteredUserCreateViewModel`, `RegisteredUserUpdateViewModel`, `RegisteredUserLogsViewModel`, `RegisteredUserNotCheckOutViewModel`, `RegisteredUserCheckOutViewModel`).
  - Extracted direct `ApiService`, `IdCardServiceRepository`, `PrinterManager`, and `Dio` calls out of UI widgets (`EntranceScreen`, `ExitScreen`, `VisitorDetailScreen`, `ReportScreen`, `SettingScreen`, `UserScreen`, `GateLogViewmodel`, `LastGateViewmodel`, `LivePlayerViewmodel`, `VisitorViewmodel`) into dedicated ViewModels (`EntranceViewModel`, `ExitViewModel`, `VisitorDetailViewModel`, `ReportViewModel`, `SettingViewModel`, `UserViewModel`) and Repositories (`CameraRepository`, `GateLogRepository`, `ReportRepository`, `UserRepository`, `VisitorRepository`).
- **Data Layer Unification**:
  - Standardized all repository methods to return `Result<T>` (`Ok` / `Error`).
  - Removed redundant pass-through `DataSource` and `UseCase` classes in `card_reader` and `registered_user`.
  - Encapsulated thermal USB printing logic inside `PrinterRepository.printBytes`.

### Fixed

- Resolved all analyzer errors and lint warnings under `very_good_analysis`.
- Fixed constructor parameter definitions and Freezed generated parameter modifiers for Dart 3.14 compatibility.
- Updated unit tests to `test/ui/features/registered_user/view_models/registered_user_list_viewmodel_test.dart`.

### Removed

- Legacy `lib/features/`, `lib/shared/`, and `test/features/` directories.
- Removed `freezed` and `freezed_annotation` (converted all models to `@JsonSerializable()` classes with standard `copyWith` methods), as well as `bloc_signals_flutter` and `fpdart`.

## [1.0.1+2] - 2026-11-13

### Changed

- Upgraded dependencies and applied lint rules across codebase for Flutter 3.50.0 / Dart 3.14.
- Migrated to Flutter Swift Package Manager and updated `file_picker` usage across screens.
- Implemented authentication repository and member management view models.
