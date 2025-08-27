# Flutter Clean Architecture TDD Template

<img src="https://media.licdn.com/dms/image/v2/D4E12AQENhLUzGNhhiQ/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1666189223785?e=2147483647&v=beta&t=8SPzOhNdkwyv3gkL0IGCVqC0qnsVY0EKFbneOu1Kqtc" alt="TDD & Clean Architecture Image" width="100%" height="200">

A robust and scalable starter template for Flutter applications. This project is meticulously crafted to follow Clean Architecture principles and a Test-Driven Development (TDD) approach, providing a solid foundation for your next Flutter project.

This template includes a sample "Tasks" feature to demonstrate the architecture in a practical context.

## Features

- **Clean Architecture:** The project is divided into three distinct layers (Data, Domain, Presentation) for separation of concerns, making the code easier to maintain, scale, and test.
- **Test-Driven Development (TDD):** A full suite of tests is included for all layers of the application, from data sources and repositories to use cases and state management.
- **BLoC for State Management:** Utilizes `flutter_bloc` (specifically Cubit) for predictable and efficient state management.
- **Dependency Injection:** Implements `get_it` as a service locator for managing dependencies and decoupling components.
- **Error Handling:** Uses the `dartz` package for functional error handling, ensuring robust and predictable failure management.

## Project Structure

The project follows a feature-first approach, with a clear separation of layers within each feature.

```
lib
├── core/                  # Core utilities, errors, services, and base classes
│   ├── errors/
│   ├── services/
│   ├── usecases/
│   └── utils/
├── features/              # Application features
│   └── tasks/             # Example "Tasks" feature
│       ├── data/          # Data layer: models, data sources, repository implementation
│       ├── domain/        # Domain layer: entities, use cases, repository contracts
│       └── presentation/  # Presentation layer: cubits (state), screens, and widgets
└── main.dart              # App entry point
test/
├── features/              # Tests organized by feature
│   └── tasks/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── fixtures/              # Mock data for testing
```

## Getting Started

To get started with this template, follow these steps:

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/MahmoudALBndkji/Flutter-Clean-Architecture-TDD-Template.git
    ```

2.  **Navigate to the project directory:**

    ```bash
    cd flutter-clean-architecture-tdd-template
    ```

3.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

4.  **Run the application:**
    ```bash
    flutter run
    ```

## Testing

This project is set up for TDD. To run the complete suite of tests, use the following command:

```bash
flutter test
```

## Core Libraries

- [**flutter_bloc**](https://pub.dev/packages/flutter_bloc): For predictable state management.
- [**get_it**](https://pub.dev/packages/get_it): A simple service locator for dependency injection.
- [**dartz**](https://pub.dev/packages/dartz): Provides functional programming constructs for robust error handling.
- [**http**](https://pub.dev/packages/http): For making network requests to APIs.
- [**equatable**](https://pub.dev/packages/equatable): Simplifies equality comparisons in models and entities.
- [**mocktail**](https://pub.dev/packages/mocktail): A powerful mocking library for creating test doubles.
- [**bloc_test**](https://pub.dev/packages/bloc_test): A utility for easily testing BLoCs and Cubits.
