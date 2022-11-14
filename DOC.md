# Pokedex

## Requirements

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- A virtual or physical device to test

## Run app

Kindly run the following commands in the terminal:

```bash
flutter pub get
```

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

** Side note
Application was only properly tested on the iPhone 14 PRO as at 14th, November 2022.

Recommended device

- iPhone 14 PRO or similar specs

## Run Tests

Kindly run this command in the terminal:

```bash
flutter test --coverage
```

## Dependencies

State management

- flutter_bloc

API calls

- Dio

Connectivity

- connectivity_plus

State rebuild

- flutter_hooks
- hooks_riverpod

Json serialization

- freezed_annotation
- json_annotation

Dependency injection

- injectable
- get_it

Data persistence

- shared_preferences

Value equality

- equatable

Tests

- bloc_test
- mocktail
- flutter_test

Code generation

- auto_route_generator:
- build_runner:
- freezed:
- json_serializable:
- injectable_generator:
