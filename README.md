# epms\_flutter

A **revamped Flutter application** designed to replace a legacy React Native system, focusing on robust offline capabilities, efficient data handling for large master datasets, and a scalable architecture.

---

## 📚 Table of Contents

- [Features](#features)
- [Architecture & Principles](#architecture--principles)
  - [Clean Architecture (MVVM / BLoC)](#clean-architecture-mvvmbloC)
  - [SOLID Principles](#solid-principles)
  - [DRY (Don't Repeat Yourself)](#dry-dont-repeat-yourself)
  - [Test-Driven Development (TDD)](#test-driven-development-tdd)
- [Folder Structure](#-folder-structure)
- [Dependencies](#-dependencies)
- [Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Code Generation](#code-generation)
  - [Running the Application](#running-the-application)
- [Testing](#-testing)
- [Future Work](#-future-work)

---

## ✅ Features

- **Offline Data Storage:** Utilizes **Hive** for efficient local storage of data, enabling seamless operation even without an internet connection.
- **Data Synchronization:** Designed to store fetched/inserted data offline and upload it to a backend when connectivity is available.
- **NFC Read/Write:** Capability to interact with Near Field Communication (NFC) tags for reading and writing data.
- **Photo Capturing:** Integration with the device camera to capture photos.
- **Navigation:** Smooth and intuitive navigation between different application pages.
- **Large Master Data Handling:** Optimized to manage and process large volumes of master data, addressing performance issues faced by the legacy system.

---

## 🏗️ Architecture & Principles

### Clean Architecture (MVVM/BLoC)

The project adheres to a Clean Architecture approach, leveraging **BLoC** for state management, and is built upon core software development principles to ensure maintainability, scalability, and testability.

- **Domain Layer:** Contains pure business logic, entities, abstract repositories (interfaces), and use cases. It's independent of any framework or data source.
- **Data Layer:** Implements the repository interfaces defined in the domain layer and interacts with data sources (local Hive, remote API). It handles data retrieval, storage, and mapping.
- **Presentation Layer:** Manages the UI and presentation logic. It uses **BLoC** (Business Logic Component) for reactive state management, separating the UI from business rules.

This structure inherently supports the **MVVM (Model-View-ViewModel)** pattern.

### SOLID Principles

- **Single Responsibility Principle (SRP):** Each class or module has one well-defined responsibility.
- **Open/Closed Principle (OCP):** Software entities are open for extension but closed for modification.
- **Liskov Substitution Principle (LSP):** Subtypes must be substitutable for their base types.
- **Interface Segregation Principle (ISP):** Clients should not depend on interfaces they don't use.
- **Dependency Inversion Principle (DIP):** High-level modules should not depend on low-level modules; both depend on abstractions.

### DRY (Don't Repeat Yourself)

- **Reusable Widgets:** Located in `lib/src/common/widgets/`
- **Core Services & Utilities:** Placed in `lib/src/core/services/` and `lib/src/core/utils/`
- **Constants & Styles:** Defined in `lib/src/core/constants/` and `lib/src/common/styles/`

### Test-Driven Development (TDD)

- The project structure is optimized for **TDD**, with layers and interfaces allowing isolated unit tests and easier test writing before implementation.

---

## 📁 Folder Structure


```bash
.
├── lib/                                  # Main application source code
│   ├── src/                              # All internal implementation details of the application
│   │   ├── common/                       # Reusable components and utilities that are shared across different features
│   │   │   ├── widgets/                  # Generic, reusable UI widgets (e.g., custom buttons, text fields, loading indicators)
│   │   │   │   ├── custom_button.dart    # A customizable button widget
│   │   │   │   └── custom_text_field.dart # A customizable text input field
│   │   │   ├── styles/                   # Centralized application-wide UI styles (colors, text themes)
│   │   │   │   ├── app_colors.dart       # Defines all color constants used in the app
│   │   │   │   └── app_text_styles.dart  # Defines all text style constants and the global TextTheme
│   │   │   └── extensions/               # Dart extension methods for common functionalities (e.g., String, DateTime)
│   │   │       └── string_extensions.dart # Utility extensions for String manipulation
│   │   │
│   │   ├── core/                         # Fundamental functionalities and abstractions, independent of specific features
│   │   │   ├── constants/                # Static constants used throughout the app (e.g., API keys, route names, app strings)
│   │   │   ├── error/                    # Custom exception and failure classes for consistent error handling
│   │   │   │   ├── exceptions.dart       # Defines unexpected, unrecoverable errors (e.g., network error, server error)
│   │   │   │   └── failures.dart         # Defines expected, recoverable errors (e.g., no internet, invalid input)
│   │   │   ├── network/                  # Network-related utilities and configurations
│   │   │   │   ├── dio_client.dart       # Configures and provides the Dio HTTP client with interceptors
│   │   │   │   └── network_info.dart     # Checks and provides information about internet connectivity
│   │   │   ├── services/                 # Core application services that encapsulate platform-specific or complex logic
│   │   │   │   ├── local_storage_service.dart # Abstract and concrete implementation for local data storage (using Hive)
│   │   │   │   └── notification_service.dart  # Handles in-app notifications (e.g., Snackbars, dialogs)
│   │   │   ├── utils/                    # General utility functions and helper classes
│   │   │   │   ├── date_formatter.dart   # Utility for consistent date and time formatting
│   │   │   │   └── validators.dart       # Utility for common input validation rules
│   │   │   └── usecases/                 # Base abstract class for all use cases, defining a common contract
│   │   │       └── usecase.dart          # Defines the `UseCase` abstract class and `NoParams`
│   │   │
│   │   ├── features/                     # Contains independent, self-contained modules for distinct application features
│   │   │   ├── feature_name_1/           # Placeholder for a specific feature (e.g., 'authentication', 'nfc_scanner', 'master_data_sync', 'camera_capture')
│   │   │   │   ├── data/                 # Data layer for feature_name_1: handles data retrieval and storage mechanisms
│   │   │   │   │   ├── datasources/      # Defines remote (API) and local (Hive) data sources for the feature
│   │   │   │   │   │   ├── remote/       # Remote data source for fetching data from a server API
│   │   │   │   │   │   │   └── feature_name_1_remote_data_source.dart
│   │   │   │   │   │   └── local/        # Local data source for storing and retrieving data from Hive
│   │   │   │   │   │       └── feature_name_1_local_data_source.dart
│   │   │   │   │   ├── models/           # Data Transfer Objects (DTOs) for serialization/deserialization (e.g., JSON, Hive objects)
│   │   │   │   │   │   └── feature_name_1_model.dart
│   │   │   │   │   └── repositories/     # Concrete implementation of the feature's repository interface
│   │   │   │   │       └── feature_name_1_repository_impl.dart
│   │   │   │   │
│   │   │   │   ├── domain/               # Domain layer for feature_name_1: contains core business logic and rules
│   │   │   │   │   ├── entities/         # Pure Dart objects representing core business data (framework-agnostic)
│   │   │   │   │   │   └── feature_name_1_entity.dart
│   │   │   │   │   ├── repositories/     # Abstract interfaces (contracts) for data operations, defined by the domain
│   │   │   │   │   │   └── feature_name_1_repository.dart
│   │   │   │   │   └── usecases/         # Specific business rules or operations for this feature
│   │   │   │   │       └── get_feature_name_1_data.dart
│   │   │   │   │
│   │   │   │   └── presentation/         # Presentation layer for feature_name_1: handles UI and state management
│   │   │   │       ├── bloc/             # BLoC (Business Logic Component) implementation for the feature's state management
│   │   │   │       │   ├── feature_name_1_bloc.dart    # The BLoC class itself
│   │   │   │       │   ├── feature_name_1_event.dart   # Defines events that the UI dispatches to the BLoC
│   │   │   │       │   └── feature_name_1_state.dart   # Defines states that the BLoC emits to update the UI
│   │   │   │       ├── pages/            # Top-level screens or views for this feature
│   │   │   │       │   └── feature_name_1_page.dart    # The main page/screen for the feature
│   │   │   │       └── widgets/          # Reusable UI components specific to this feature (not generic)
│   │   │   │           └── feature_name_1_display.dart
│   │   │   │
│   │   │   └── feature_name_2/           # Another distinct feature (e.g., 'camera_capture', 'master_data_sync')
│   │   │       └── ... (follows a similar data/domain/presentation structure)
│   │   │
│   │   ├── app_config.dart               # Centralized configuration settings for the entire application
│   │   ├── app_router.dart               # Centralized routing logic for navigating between pages
│   │   └── injector.dart                 # Manages dependency injection using GetIt, registering all services and components
│   │
│   ├── main.dart                         # The absolute entry point of the Flutter application
│   └── app.dart                          # The root widget of the application, setting up global providers, theme, and router
│
├── test/                                 # Contains all tests, mirroring the `lib/src` folder structure
│   ├── src/
│   │   ├── common/                       # Tests for common widgets, styles, and extensions
│   │   │   ├── widgets/
│   │   │   │   └── custom_button_test.dart
│   │   │   ├── styles/
│   │   │   │   └── app_colors_test.dart
│   │   │   └── extensions/
│   │   │       └── string_extensions_test.dart
│   │   │
│   │   ├── core/                         # Tests for core functionalities and services
│   │   │   ├── error/
│   │   │   │   └── failures_test.dart
│   │   │   ├── network/
│   │   │   │   └── network_info_test.dart
│   │   │   ├── services/
│   │   │   │   └── local_storage_service_test.dart
│   │   │   ├── utils/
│   │   │   │   └── date_formatter_test.dart
│   │   │   └── usecases/
│   │   │       └── usecase_test.dart
│   │   │
│   │   ├── features/                     # Tests for each feature, following the data/domain/presentation layers
│   │   │   ├── feature_name_1/
│   │   │   │   ├── data/
│   │   │   │   │   ├── datasources/
│   │   │   │   │   │   ├── remote/
│   │   │   │   │   │   │   └── feature_name_1_remote_data_source_test.dart
│   │   │   │   │   │   └── local/
│   │   │   │   │   │       └── feature_name_1_local_data_source_test.dart
│   │   │   │   │   ├── models/
│   │   │   │   │   │   └── feature_name_1_model_test.dart
│   │   │   │   │   └── repositories/
│   │   │   │   │       └── feature_name_1_repository_impl_test.dart
│   │   │   │   │
│   │   │   │   ├── domain/
│   │   │   │   │   ├── entities/
│   │   │   │   │   │   └── feature_name_1_entity_test.dart
│   │   │   │   │   ├── repositories/
│   │   │   │   │   │   └── feature_name_1_repository_test.dart # Tests for the repository contract (using mocks)
│   │   │   │   │   └── usecases/
│   │   │   │   │       └── get_feature_name_1_data_test.dart
│   │   │   │   │
│   │   │   │   └── presentation/
│   │   │   │       ├── bloc/
│   │   │   │       │   └── feature_name_1_bloc_test.dart
│   │   │   │       ├── pages/
│   │   │   │       │   └── feature_name_1_page_test.dart # Widget tests for the feature's main page
│   │   │   │       └── widgets/
│   │   │   │           └── feature_name_1_display_test.dart # Widget tests for feature-specific reusable UI
│   │   │   │
│   │   │   └── feature_name_2/
│   │   │       └── ... (similar test structure for other features)
│   │   │
│   │   └── app_config_test.dart          # Tests for application configuration
│   │   └── app_router_test.dart          # Tests for routing logic
│   │   └── injector_test.dart            # Tests for dependency injection setup
│   │
│   └── widget_test.dart                  # Default Flutter widget test file (can be removed or repurposed)
│
├── pubspec.yaml                          # Project dependencies and metadata
├── README.md                             # Project documentation
└── ... (other project files like .gitignore, analysis_options.yaml)
```

## 📦 Dependencies


The project uses the following key dependencies, managed via `pubspec.yaml`:

**Core Dependencies:**

* [`flutter_bloc`]([https://pub.dev/packages/flutter_bloc](https://pub.dev/packages/flutter_bloc)): For managing application state using the BLoC pattern, making your UI react to data changes.
* [`provider`]([https://pub.dev/packages/provider](https://pub.dev/packages/provider)): A simple and efficient way to manage and provide data/services to your widgets down the widget tree.
* [`equatable`]([https://pub.dev/packages/equatable](https://pub.dev/packages/equatable)): Helps you easily compare Dart objects (like BLoC states and events) by their values, not just their memory addresses.
* [`hive`]([https://pub.dev/packages/hive](https://pub.dev/packages/hive)), [`hive_flutter`]([https://pub.dev/packages/hive_flutter](https://pub.dev/packages/hive_flutter)): A super fast, lightweight NoSQL database for local data storage, perfect for offline capabilities. `hive_flutter` adds Flutter-specific integrations.
* [`path_provider`]([https://pub.dev/packages/path_provider](https://pub.dev/packages/path_provider)): Provides access to common locations on the device's file system, useful for storing app data.
* [`nfc_manager`]([https://pub.dev/packages/nfc_manager](https://pub.dev/packages/nfc_manager)): Enables your app to interact with NFC (Near Field Communication) tags, allowing you to read and write data.
* [`camera`]([https://pub.dev/packages/camera](https://pub.dev/packages/camera)): The official Flutter plugin for accessing the device's camera, letting you capture photos and videos.
* [`dio`]([https://pub.dev/packages/dio](https://pub.dev/packages/dio)): A powerful HTTP client for making network requests to your backend APIs.
* [`internet_connection_checker_plus`]([https://pub.dev/packages/internet_connection_checker_plus](https://pub.dev/packages/internet_connection_checker_plus)): A reliable way to check if the device currently has an active internet connection.
* [`workmanager`]([https://pub.dev/packages/workmanager](https://pub.dev/packages/workmanager)) (Android): For running tasks in the background on Android, even when your app is closed.
* [`background_fetch`]([https://pub.dev/packages/background_fetch](https://pub.dev/packages/background_fetch)) (iOS): Similar to `workmanager`, but for managing background fetch tasks specifically on iOS.
* [`get_it`]([https://pub.dev/packages/get_it](https://pub.dev/packages/get_it)): A simple service locator that helps manage dependencies in your app, making it easy to access services and objects where needed.
* [`intl`]([https://pub.dev/packages/intl](https://pub.dev/packages/intl)): Provides internationalization (i18n) and localization features, including date and number formatting.
* [`flutter_native_splash`]([https://pub.dev/packages/flutter_native_splash](https://pub.dev/packages/flutter_native_splash)): Helps you create a custom splash screen for your Flutter app, improving the initial loading experience.

**Development Dependencies (for Code Generation):**

* [`hive_generator`]([https://pub.dev/packages/hive_generator](https://pub.dev/packages/hive_generator)): Generates the necessary code (TypeAdapters) for Hive to store and retrieve your custom Dart objects.
* [`json_serializable`]([https://pub.dev/packages/json_serializable](https://pub.dev/packages/json_serializable)): Automatically generates code for converting Dart objects to/from JSON, which is great for API communication.
* [`build_runner`]([https://pub.dev/packages/build_runner](https://pub.dev/packages/build_runner)): The tool that runs code generators like `hive_generator` and `json_serializable` to create the required Dart files.

For the exact versions, please refer to the `pubspec.yaml` file.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (Stable channel)
- Android Studio or VS Code with Flutter extensions
- Physical device or emulator/simulator

### Installation

```bash
git clone [your-repository-url]
cd [your-project-name]
flutter pub get
```

### Code Generation

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Running the Application

```bash
flutter devices
flutter run
```

## 🧪 Testing

Run all tests:

```bash
flutter test
```

Run tests for a specific file:

```bash
flutter test test/src/features/feature_name_1/domain/usecases/get_feature_name_1_data_test.dart
```

Run widget tests:

```bash
flutter test test/src/features/feature_name_1/presentation/pages/feature_name_1_page_test.dart
```

## 🔮 Future Work

- **3divi Face SDK Integration:** The project is designed to facilitate future integration with the 3divi Face SDK for facial recognition capabilities. This will be developed in a later phase.

---

