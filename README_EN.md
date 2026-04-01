# <img src="./assets/images/appicon.png" width="40" style="vertical-align: middle; border-radius: 10px"/> FiestApp

Developed by [__ARCAS__ Manon](https://github.com/Manon-Arc), [__MACE__ Léo](https://github.com/LeoMa33).

[![Français](https://img.shields.io/badge/Vers_le-Français-blue?style=flat&logo=google-translate&logoColor=white)](README.md)

# 📱 FiestApp Mobile Application

FiestApp is a complete mobile event management application, developed with Flutter for a smooth and native user experience on iOS and Android.

## 📌 Table of Contents
- [🚀 Ecosystem](#-ecosystem)
- [🎯 Features](#-features)
- [⚙️ Tech Stack](#️-tech-stack)  
- [📂 Project Structure](#-project-structure)
- [📥 Installation](#-installation)
- [🔐 Authentication](#-authentication)
- [🌐 API Communication](#-api-communication)

---

## 🚀 Ecosystem

FiestApp is composed of three main components working in synergy:

| Component | Tech Stack | Documentation |
| :--- | :--- | :--- |
| **Mobile Application** | ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white) | 📱 This repository |
| **Main API** | ![NestJs](https://img.shields.io/badge/NestJs-E0234E?style=flat&logo=nestjs&logoColor=white) | [![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white)](https://github.com/LeoMa33/fiestapp-api) |
| **AI MicroService** | ![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white) | [![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white)](https://github.com/Manon-Arc/FiestAppService) |

---

## 🎯 Features

### 👤 Authentication & Profile
- Secure registration and login
- User profile management
- Automatic token refresh

### 🎉 Event Management
- Create events with comprehensive details
- Join events via QR codes or invitation links
- Interactive map visualization with Mapbox
- Participant invitations
- Real-time management

### 🗳️ Collaboration & Engagement
- Interactive polling system
- Shared expense management
- Collaborative shopping lists
- Accommodation suggestions
- Transport and coordination

### 🤖 Intelligent Recommendations
- AI-powered quantity estimations (drinks, food)
- Profile-based participant analysis
- Real-time calculations for event optimization

### 📸 Multimedia Management
- Profile image uploads
- Secure storage via S3 Minio
- Automatic image compression
- Push notifications via Firebase

---

## ⚙️ Tech Stack

| Technology | Usage |
| :--- | :--- |
| ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white) | Cross-platform mobile framework |
| ![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white) | Programming language |
| ![Riverpod](https://img.shields.io/badge/Riverpod-4A90E2?style=flat&logo=riverpod&logoColor=white) | State management |
| ![Mapbox](https://img.shields.io/badge/Mapbox-000000?style=flat&logo=mapbox&logoColor=white) | Map integration |
| ![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=flat&logo=firebase&logoColor=white) | Notifications & Analytics |
| ![Dio](https://img.shields.io/badge/Dio-22C55E?style=flat&logo=dart&logoColor=white) | HTTP Client |

---

## 📂 Project Structure

```
📦 lib
 ┣ 📂 core                        # 🧩 Foundations & Services
 ┃ ┣ 📂 network                   # 🌐 HTTP Configuration
 ┃ ┣ 📂 routing                   # 🛣️ Navigation
 ┃ ┣ 📂 services                  # ⚙️ Global Services
 ┃ ┣ 📂 utils                     # 🔧 Utilities
 ┃ ┗ 📂 common_widgets            # 🧩 Common Widgets
 ┣ 📂 feature                     # 🚀 Functional Modules
 ┃ ┣ 📂 auth                      # 🔐 Authentication
 ┃ ┣ 📂 event                     # 🎉 Event Management
 ┃ ┣ 📂 user                      # 👤 User Profile
 ┃ ┣ 📂 invitation                # 📨 Invitations
 ┃ ┣ 📂 estimation                # 🤖 AI Recommendations
 ┃ ┣ 📂 poll                      # 🗳️ Polls
 ┃ ┣ 📂 expense                   # 💰 Expenses
 ┃ ┣ 📂 shopping                  # 🛒 Shopping Lists
 ┃ ┣ 📂 transport                 # 🚗 Transport
 ┃ ┣ 📂 accomodation              # 🏨 Accommodations
 ┃ ┣ 📂 notification              # 📲 Notifications
 ┃ ┗ 📂 splash                    # 🎬 Splash Screen
 ┣ 📜 main.dart                   # 🏁 Entry Point
 ┣ 📜 constant.dart               # 📋 Constants
 ┗ 📜 enum.dart                   # 📝 Enumerations
```

Each feature follows an MVC/MVVM structure with a clear separation between presentation, business logic, and services.

---

## 📥 Installation

### OS Compatibility
| Status | Operating System |
| :---: | :--- |
| ✅ | ![Windows](https://img.shields.io/badge/Windows-0078D6?style=flat&logo=windows&logoColor=white) |
| ✅ | ![macOS](https://img.shields.io/badge/macOS-000000?style=flat&logo=apple&logoColor=white) |
| ✅ | ![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=black) |

### Prerequisites
| Tool | Version |
| :--- | :--- |
| ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white) | **3.38.1+** |
| ![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white) | **3.8.1+** (included in Flutter) |
| ![Android Studio](https://img.shields.io/badge/Android_Studio-3DDC84?style=flat&logo=android-studio&logoColor=white) or ![Xcode](https://img.shields.io/badge/Xcode-007AFF?style=flat&logo=xcode&logoColor=white) | Latest version |

### Configuration (`.env`)
Before launching the project, create a `.env` file at the root and set the following variables:

| Variable | Description |
| :--- | :--- |
| `MAPBOX_TOKEN` | Token for Mapbox API (interactive maps) |
| `API_ENDPOINT` | Main API URL (e.g: https://api.fiestapp.fr) |
| `S3_ENDPOINT` | S3 Minio storage URL |

### Installation Steps

```bash
# 1. Clone the repository
git clone https://github.com/LeoMa33/FiestApp_App.git

# 2. Navigate to the folder
cd FiestApp_App

# 3. Install dependencies
flutter pub get

# 4. Generate files (Riverpod, etc.)
flutter pub run build_runner build

# 5. Launch the application
flutter run

# Or for an optimized build
flutter run --release
```

> [!IMPORTANT]
> **Important Information**
>
> - Ensure your FiestApp API is accessible before launching the application
> - Configure Firebase tokens for push notifications
> - Verify Mapbox is properly configured for geolocation
> - On iOS, you may need to run `pod install` in the `ios/` folder if native dependencies don't install automatically

---

## 🔐 Authentication

### Authentication Flow

Authentication works according to the following model:

1. **Registration** : User creates an account with their credentials
2. **Login** : User logs in each time the app launches
3. **Token Acquisition** : The API returns an `access_token` (short-lived, ~15 min) and a `refresh_token` (long-lived, ~7 days)
4. **Secure Storage** : Tokens are stored in `flutter_secure_storage` (Keychain on iOS / Keystore on Android)
5. **Token Renewal** : When the `access_token` expires, the `refresh_token` is automatically used to obtain a new token

### Authentication Services

- **Secure Storage** : `flutter_secure_storage` for JWT tokens
- **State Management** : Riverpod to maintain authentication state

---

## 🌐 API Communication

### HTTP Client

The application uses **Dio** with the following configurations:

- **Base URL** : Configured via `.env` `API_ENDPOINT`
- **Interceptors** : Automatic JWT token management
- **Timeouts** : Managed for better user experience
- **Error Handling** : 401 interception for token refresh

### API Calls

All calls to the FiestApp API are made through services in `lib/core/network/` with centralized error handling.

**AI recommendations** (estimations) are obtained through the FiestApp API (NestJS), which communicates with the Python service.

---

> Developed with ❤️ for the **[FiestApp](https://github.com/LeoMa33/FiestApp_Api)** ecosystem.
