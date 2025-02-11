# RSSFeedProject

## Overview
This iOS SwiftUI project implements Clean Architecture principles, providing a robust structure for building scalable and maintainable applications. The project follows the MVVM (Model-View-ViewModel) pattern for state management, ensuring a clear separation of concerns and simplifying testing and management of application logic.

## Key Features
- **Clean Architecture**: Organized layers of code that separate presentation, domain, and data, making the app easier to maintain and extend.
- **MVVM Pattern**: Promotes a clear separation between the UI and business logic, enhancing testability and maintainability.
- **Localization Support**: Supports multiple languages, allowing users to interact in their preferred language. Easily add new languages and manage translations.
- **Dependency Injection**: Utilizes the Factory library for efficient dependency management. This setup simplifies testing, increases flexibility, and adheres to the Single Responsibility Principle by decoupling object creation from business logic.
- **Dark Mode**: The app supports light and dark mode according to user choosing
- **Tests**: The app has some tests that are used for mock testing the Data layer
- **Alerts**: The app uses AlertKit library for calling predefined SwiftUI alerts without viewmodifiers
