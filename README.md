# <img src="./assets/images/appicon.png" width="40" style="vertical-align: middle; border-radius: 10px"/> FiestApp

Project by [__ARCAS__ Manon](https://github.com/Manon-Arc), [__MACE__ Léo](https://github.com/LeoMa33), [__DE AMEZAGA__ Bastien](https://github.com/Bastien-DA) and [__BARBOTEAU__ Mathieu](https://github.com/Kilecon).

Welcome to the FiestApp project ! <br>

This project is aimed at providing a mobile cross-platform application to manage event organization.

### 📌 Table of contents :

I. [About the project](#💡-about-the-project)

II. [Technologies used](#⚙️-technologies-used)

III. [Features](#🌟-availables-features)

IV. [Architecture](#​📋​-architecture)

V. [Project structure](#📁-project-structure)

VI. [Installation](#📥-install-the-project-development-mode)

### 💡 About the project :

FiestApp is a mobile application developed to help users organiz their event. It offers an intuitive interface to record profil, event, view detailed event : poll, course list... and gain a clear
overview of your event situation.

The application stores all your data in a Postgres Database and in a S3 minio.

#### View

<div align="center">
  <img src="https://github.com/user-attachments/assets/7b3f296f-838d-443a-bfe1-a568f1c15cd2" width="45%" style="margin-right:10px;" />
  <img src="https://github.com/user-attachments/assets/855c6ffc-b3a7-44ca-a891-bcd4ea07573f" width="38%" />
</div>

### ⚙️ Technologies used :

<img alt="Flutter badge" src="https://img.shields.io/badge/SDK-Flutter-blue">
<img alt="Nest badge" src="https://img.shields.io/badge/Framework-Nest-red">
<img alt="Postgres badge" src="https://img.shields.io/badge/DB-Postgres-blue">
<img alt="Minio badge" src="https://img.shields.io/badge/Storage-Minio-red">
<img alt="Docker badge" src="https://img.shields.io/badge/Deploy-Docker-blue">

### 🌟 Availables Features :

**Authentication & Onboarding:**
- Fingerprint-based device authentication

**Event Management:**
- Create and join events via QR codes or links
- Interactive map integration with custom markers
- Real-time collaboration features

**Smart Recommendations:**
- AI-powered food and drink suggestions
- Based on participant profiles (age, weight, alcohol consumption)

### ​📋​ Architecture :

The project is composed of a mobile application, who call our Rest API to interact with our database and call our AI service to get food and drink recommendation because of the user profile.

You can visualized the data flow here :

```plaintext
                    FIESTAPP ARCHITECTURE

┌───────────────────────────────────────────────────────────────┐
│                     CLIENT LAYER                             │
└─────────────────────┬─────────────────────────────────────────┘
                      │
        ┌─────────────▼─────────────┐
        │      MOBILE APP           │
        │      (Flutter)            │
        │                           │
        │ • Event Management        │
        │ • QR Code Scanner         │
        │ • Device Authentication   │
        │ • IA Service Calls        │
        └─────┬───────────┬─────────┘
              │           │
              │           │ HTTPS (Food Recommendations)
              │           │
              │     ┌─────▼─────────────────┐
              │     │  IA SERVICE           │
              │     │                       │
              │     │• Food Recommendations │
              │     │• Drink Estimations.   │
              │     │• Profile Analysis     │
              │     └───────────────────────┘
              │
              │ HTTP/HTTPS
              │
┌─────────────▼─────────────────────────────────────────────────┐
│                   API LAYER                                   │
└─────────────────────┬─────────────────────────────────────────┘
                      │
        ┌─────────────▼─────────────┐
        │      REST API             │
        │      (NestJS)             │
        │                           │
        │ • CRUD Operations         │
        │ • Authentication          │
        │ • Business Logic          │
        │ • File Management         │
        └───────┬─────────┬─────────┘
                │         │
                │         │
      ┌─────────▼─┐   ┌───▼──────────┐
      │ DATABASE  │   │   S3 MINIO   │
      │(Postgres) │   │ (File Store) │
      │           │   │              │
      │• Users    │   │• Images      │
      │• Events   │   │• Assets      │
      │• Polls    │   └──────────────┘
      │• Expenses |
      |• etc.     │   
      └───────────┘   
```

#### 1. Mobile Application :

The mobile application (this repository) is designed for user interaction.

**Key Features:**
- **User-friendly interface** for event management
- **Cross-platform compatibility** (iOS & Android) using Flutter
- **Secure authentication** through device fingerprint
- **Event creation and participation** via QR codes and links
- **Real-time collaboration** for polls and expenses
- **AI service integration** for food and drink recommendations
- **Multimedia content management** through file upload and storage

**Tech Stack:** Flutter, Riverpod, Mapbox

#### 2. REST API :

➜ [Install the REST API](https://github.com/LeoMa33/fiestapp-api) <br>

The REST API follows a DDD architecture for communication with Postgres.

**Key Features:**
- **CRUD operations** for managing users, events and event features
- **Authentication system** with JWT tokens
- **Business logic** implementation and validation
- **File management** integration with S3 Minio
- **Data persistence** in PostgreSQL database

**Tech Stack:** NestJS, PostgreSQL, Minio S3

#### 3. AI Service :

➜ [Install the AI Service](https://github.com/Manon-Arc/FiestAppService.git) <br>

*The service is already available at https://fiestapp-service.mizury.fr*

The AI service is designed for intelligent food and drink recommendations.

**Key Features:**
- **Smart estimations** for soft drinks, beer and pizza quantities
- **Profile-based analysis** using participant demographics
- **Consumption algorithms** based on age, weight, gender and alcohol habits
- **REST API endpoints** for recommendation requests
- **Real-time calculations** for event planning optimization

**Tech Stack:** Python, Machine Learning, FastAPI


### 📁 Project structure

- [📁 lib](lib/): Flutter source code
  - **`pages/`**: Application screens (Home, Profile, Events, etc.)
  - **`components/`**: Reusable UI components
  - **`models/`**: Data models (Event, User, Poll, etc.)
  - **`api/`**: API service classes
  - **`provider/`**: State management (Riverpod)
  - **`utils/`**: Utility functions and constants
  - **`mock/`**: Mock data for development
- [📁 assets](assets/): Application resources
  - **`images/`**: Icons and images
  - **`marker.png`**: Custom map marker

### 📥 Install the project (*Development mode*):

#### Prerequisites

- **OS**: Windows 10/11, macOS, or Linux
- **Flutter**: Version 3.32.4 or higher
- **IDE**: we recommand you tu use [Android Studio](https://developer.android.com/studio)
- 
#### Method:

1. Clone the repository: `git clone https://github.com/Bastien-DA/FiestApp.git`
2. Navigate to the project directory: `cd FiestApp`
3. Install dependencies: `flutter pub get`
   - If you are using an IDE, you can also use the "Get dependencies" button.
   - If you are using the command line, you can run `flutter pub get` to install the dependencies.
4. Run the application: `flutter run`
   - If you are using an IDE, you can also use the "Run" button.
   - If you are using the command line, you can run `flutter run` to start the application.

#### Environment Setup
Create a `.env` file with:
```
MAPBOX_TOKEN=pk.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
SERVICE_ENDPOINT="https://fiestapp-service.example.com"
S3_ENDPOINT="https://s3.example.com"
API_ENDPOINT="https://api.example.com"
```

___

> Developed with ❤️ for the **[FiestApp](https://github.com/Bastien-DA/FiestApp.git)** ecosystem.  

