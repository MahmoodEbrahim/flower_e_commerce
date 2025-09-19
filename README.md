# 🌸 Flower E-Commerce App

A beautiful and intuitive mobile application for browsing, ordering, and managing flower deliveries, built with Flutter for a seamless cross-platform experience.

[![Version](https://img.shields.io/badge/version-1.0.0-blue)](https://github.com/MahmoodEbrahim/flower_e_commerce)
[![License](https://img.shields.io/badge/license-Unlicensed-lightgrey)](https://github.com/MahmoodEbrahim/flower_e_commerce/blob/main/LICENSE)
[![Stars](https://img.shields.io/github/stars/MahmoodEbrahim/flower_e_commerce?style=social)](https://github.com/MahmoodEbrahim/flower_e_commerce/stargazers)
[![Forks](https://img.shields.io/github/forks/MahmoodEbrahim/flower_e_commerce?style=social)](https://github.com/MahmoodEbrahim/flower_e_commerce/network/members)

![flower-e-commerce-preview](/preview_example.png)


## ✨ Features

*   **📱 Cross-Platform Compatibility:** Enjoy a consistent and fluid user experience across Android, iOS, Linux, and macOS, thanks to Flutter.
*   **🛒 Intuitive Product Catalog:** Browse a wide selection of flowers with high-quality images, detailed descriptions, and easy navigation.
*   **💳 Secure Checkout Process:** A streamlined and secure checkout flow supporting various payment methods for a hassle-free purchasing experience.
*   **📦 Order Tracking & History:** Keep track of your current orders and review past purchases with detailed order history.
*   **💖 Wishlist Functionality:** Save your favorite flower arrangements to a wishlist for future purchases or gift ideas.


## 🚀 Installation Guide

To get a local copy up and running, follow these simple steps. This project uses Flutter, so ensure you have the Flutter SDK installed.

### Prerequisites

*   **Flutter SDK:** [Install Flutter](https://flutter.dev/docs/get-started/install) for your operating system.
*   **Git:** [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) to clone the repository.

### Manual Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/MahmoodEbrahim/flower_e_commerce.git
    cd flower_e_commerce
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the application:**
    *   For Android:
        ```bash
        flutter run
        ```
    *   For iOS:
        ```bash
        flutter run
        ```
    *   For Web:
        ```bash
        flutter run -d chrome
        ```
    *   For Desktop (Linux, macOS, Windows):
        ```bash
        flutter run -d <device_name>
        ```
        (e.g., `flutter run -d macos` or `flutter run -d linux`)

### Environment Configuration

No specific environment variables are required for basic setup. However, for features like payment gateways or backend API integration, you might need to configure them in `lib/main.dart` or a separate configuration file.


## 💡 Usage Examples

### Running the App

After installation, you can launch the app on your preferred device or emulator.

```bash
flutter run
```

This command will build and run the application. If you have multiple devices connected, you might need to specify one:

```bash
flutter run -d "iPhone 15 Pro Max"
```

### Basic Navigation

Once the app is running, you can:
*   Navigate through categories to find specific flower types.
*   Add items to your cart.
*   Proceed to checkout.

![flower-e-commerce-usage-screenshot](/usage_example.png)

### Configuration Options

The app can be configured for different environments (e.g., development, production) using flavor-specific configurations.

| Option        | Description                                       | Default Value |
| :------------ | :------------------------------------------------ | :------------ |
| `API_BASE_URL`| Base URL for the backend API.                     | `http://localhost:8080/api` |
| `STRIPE_KEY`  | Public key for Stripe payment gateway integration.| `pk_test_YOUR_KEY` |
| `APP_THEME`   | Controls the default color scheme (light/dark).   | `light`       |

These values are typically set in a `.env` file or passed during the build process.


## 🗺️ Project Roadmap

Our vision for the Flower E-Commerce app includes continuous improvement and expansion. Here's a glimpse of what's planned:

*   **Version 1.1.0:**
    *   Integration of advanced search and filtering options.
    *   User reviews and ratings for products.
    *   Push notifications for order status updates.
*   **Version 1.2.0:**
    *   Personalized recommendations based on user history.
    *   Multiple delivery address management.
    *   Gift messaging and special occasion scheduling.
*   **Future Enhancements:**
    *   AR/VR feature for visualizing flowers in a space.
    *   Subscription service for regular flower deliveries.
    *   Integration with local florists for broader selection.


## 🤝 Contribution Guidelines

We welcome contributions from the community! To ensure a smooth collaboration, please follow these guidelines:

### Code Style

*   Adhere to the [Dart effective style guide](https://dart.dev/guides/language/effective-dart).
*   Run `flutter format .` before committing your changes.
*   Ensure your code passes static analysis checks: `flutter analyze`.

### Branch Naming Conventions

*   Use descriptive branch names.
*   For new features: `feature/<feature-name>` (e.g., `feature/add-wishlist`)
*   For bug fixes: `fix/<bug-description>` (e.g., `fix/checkout-bug`)
*   For documentation: `docs/<description>`

### Pull Request Process

1.  Fork the repository and create your branch from `main`.
2.  Ensure your code adheres to the code style and passes all tests.
3.  Write clear, concise commit messages.
4.  Open a pull request (PR) to the `main` branch.
5.  Provide a detailed description of your changes in the PR, including any relevant issue numbers.
6.  Be responsive to feedback during the review process.

### Testing Requirements

*   All new features should be accompanied by appropriate unit and widget tests.
*   Ensure existing tests pass before submitting a PR: `flutter test`.
*   Aim for good test coverage, especially for critical functionalities.


## 📜 License Information

This project is currently **Unlicensed**. This means that by default, all rights are reserved by the copyright holder, MahmoodEbrahim. You may not distribute, modify, or use this software for commercial purposes without explicit permission.

Copyright (c) 2023 MahmoodEbrahim. All rights reserved.
