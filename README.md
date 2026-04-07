# <img src="./assets/images/appicon.png" width="40" style="vertical-align: middle; border-radius: 10px"/> FiestApp

Développé par [__ARCAS__ Manon](https://github.com/Manon-Arc), [__MACE__ Léo](https://github.com/LeoMa33).

[![English](https://img.shields.io/badge/Switch_to-English-red?style=flat&logo=google-translate&logoColor=white)](README_EN.md)

# 📱 FiestApp Application Mobile

FiestApp est une application mobile complète de gestion d'événements, développée avec Flutter pour une expérience utilisateur fluide et native sur iOS et Android.

## 📌 Sommaire
- [🚀 Écosystème](#-écosystème)
- [🎯 Fonctionnalités](#-fonctionnalités)
- [⚙️ Stack technique](#️-stack-technique)  
- [📂 Arborescence](#-arborescence)
- [📥 Installation](#-installation)
- [🔐 Authentification](#-authentification)
- [🌐 Communication API](#-communication-api)

---

## 🚀 Écosystème

FiestApp est composé de trois briques principales fonctionnant en synergie :

| Composant | Stack Technique | Documentation |
| :--- | :--- | :--- |
| **Application Mobile** | ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white) | 📱 Ce repository |
| **API Principale** | ![NestJs](https://img.shields.io/badge/NestJs-E0234E?style=flat&logo=nestjs&logoColor=white) | [![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white)](https://github.com/Manon-Arc/FiestApp_Api) |
| **MicroService IA** | ![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white) | [![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white)](https://github.com/Manon-Arc/FiestAppService) |

---

## 🎯 Fonctionnalités

### 👤 Authentification & Profil
- Inscription et connexion sécurisées
- Gestion du profil utilisateur
- Refresh token automatique

### 🎉 Gestion d'Événements
- Création d'événements avec détails complets
- Rejoindre des événements via codes QR ou liens d'invitation
- Visualisation sur carte interactive avec Mapbox
- Invite de participants
- Gestion en temps réel

### 🗳️ Collaboration & Engagement
- Système de sondages interactifs
- Gestion des dépenses partagées
- Listes d'achats collaboratives
- Suggestions d'hébergements
- Transport et coordination

### 🤖 Recommandations Intelligentes
- Estimations IA de quantités (boissons, nourriture)
- Analyse basée sur les profils des participants
- Calculs temps réel pour l'optimisation d'événements

### 📸 Gestion Multimédia
- Téléchargement d'images de profil
- Stockage sécurisé via S3 Minio
- Compression automatique des images
- Gestion des notifications push via Firebase

---

## ⚙️ Stack Technique

| Technologie | Usage |
| :--- | :--- |
| ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white) | Framework mobile cross-platform |
| ![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white) | Langage de programmation |
| ![Riverpod](https://img.shields.io/badge/Riverpod-4A90E2?style=flat&logo=riverpod&logoColor=white) | Gestion d'état |
| ![Mapbox](https://img.shields.io/badge/Mapbox-000000?style=flat&logo=mapbox&logoColor=white) | Intégration cartographie |
| ![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=flat&logo=firebase&logoColor=white) | Notifications & Analytics |
| ![Dio](https://img.shields.io/badge/Dio-22C55E?style=flat&logo=dart&logoColor=white) | HTTP Client |

---

## 📂 Arborescence

```
📦 lib
 ┣ 📂 core                        # 🧩 Fondations & Services
 ┃ ┣ 📂 network                   # 🌐 Configuration HTTP
 ┃ ┣ 📂 routing                   # 🛣️ Navigation
 ┃ ┣ 📂 services                  # ⚙️ Services globaux
 ┃ ┣ 📂 utils                     # 🔧 Utilitaires
 ┃ ┗ 📂 common_widgets            # 🧩 Widgets communs
 ┣ 📂 feature                     # 🚀 Modules Fonctionnels
 ┃ ┣ 📂 auth                      # 🔐 Authentification
 ┃ ┣ 📂 event                     # 🎉 Gestion d'événements
 ┃ ┣ 📂 user                      # 👤 Profil utilisateur
 ┃ ┣ 📂 invitation                # 📨 Invitations
 ┃ ┣ 📂 estimation                # 🤖 Recommandations IA
 ┃ ┣ 📂 poll                      # 🗳️ Sondages
 ┃ ┣ 📂 expense                   # 💰 Dépenses
 ┃ ┣ 📂 shopping                  # 🛒 Listes d'achats
 ┃ ┣ 📂 transport                 # 🚗 Transport
 ┃ ┣ 📂 accomodation              # 🏨 Hébergements
 ┃ ┣ 📂 notification              # 📲 Notifications
 ┃ ┗ 📂 splash                    # 🎬 Écran de démarrage
 ┣ 📜 main.dart                   # 🏁 Point d'entrée
 ┣ 📜 constant.dart               # 📋 Constantes
 ┗ 📜 enum.dart                   # 📝 Énumérations
```

Chaque feature suit une structure MVC/MVVM avec une séparation claire entre présentation, logique métier et services.

---

## 📥 Installation

### Compatibilité OS
| Statut | Système d'exploitation |
| :---: | :--- |
| ✅ | ![Windows](https://img.shields.io/badge/Windows-0078D6?style=flat&logo=windows&logoColor=white) |
| ✅ | ![macOS](https://img.shields.io/badge/macOS-000000?style=flat&logo=apple&logoColor=white) |
| ✅ | ![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=black) |

### Prérequis
| Outil | Version |
| :--- | :--- |
| ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white) | **3.38.1+** |
| ![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white) | **3.8.1+** (inclus dans Flutter) |
| ![Android Studio](https://img.shields.io/badge/Android_Studio-3DDC84?style=flat&logo=android-studio&logoColor=white) ou ![Xcode](https://img.shields.io/badge/Xcode-007AFF?style=flat&logo=xcode&logoColor=white) | Dernière version |

### Configuration (`.env`)
Avant de lancer le projet, créez un fichier `.env` à la racine et renseignez les variables suivantes :

| Variable | Description |
| :--- | :--- |
| `MAPBOX_TOKEN` | Token pour l'API Mapbox (cartes interactives) |
| `API_ENDPOINT` | URL de l'API principale (ex: https://api.fiestapp.fr) |
| `S3_ENDPOINT` | URL du stockage S3 Minio |

### Étapes d'installation

```bash
# 1. Cloner le dépôt
git clone https://github.com/LeoMa33/FiestApp_App.git

# 2. Accéder au dossier
cd FiestApp_App

# 3. Installer les dépendances
flutter pub get

# 4. Générer les fichiers (Riverpod, etc.)
flutter pub run build_runner build

# 5. Lancer l'application
flutter run

# Ou pour un build optimisé
flutter run --release
```

> [!IMPORTANT]
> **Informations Importantes**
>
> - Assurez-vous que votre API FiestApp est accessible avant de lancer l'application
> - Configurez les tokens Firebase pour les notifications push
> - Vérifiez que Mapbox est configuré correctement pour la géolocalisation
> - Sur iOS, vous devrez exécuter `pod install` dans le dossier `ios/` si les dépendances natives ne s'installent pas automatiquement

---

## 🔐 Authentification

### Flux d'Authentification

L'authentification fonctionne selon le modèle suivant :

1. **Enregistrement** : L'utilisateur crée un compte avec ses identifiants
2. **Connexion** : L'utilisateur se connecte à chaque lancement de l'app
3. **Obtention des tokens** : L'API retourne un `access_token` (court, ~15 min) et un `refresh_token` (long, ~7 jours)
4. **Stockage sécurisé** : Les tokens sont stockés dans le `flutter_secure_storage` (Keychain iOS / Keystore Android)
5. **Renouvellement** : Lorsque l'`access_token` expire, le `refresh_token` est utilisé automatiquement pour obtenir un nouveau token

### Services d'Authentification

- **Stockage sécurisé** : `flutter_secure_storage` pour les tokens JWT
- **Gestion d'état** : Riverpod pour maintenir l'état d'authentification

---

## 🌐 Communication API

### Client HTTP

L'application utilise **Dio** avec les configurations suivantes :

- **Base URL** : Configurée via `.env` `API_ENDPOINT`
- **Intercepteurs** : Gestion automatique des tokens JWT
- **Timeouts** : Gérés pour une meilleure expérience utilisateur
- **Gestion d'erreurs** : Interception des 401 pour refresh token

### Appels API

Tous les appels à l'API FiestApp sont effectués via les services dans `lib/core/network/` avec une gestion centralisée des erreurs.

Les **recommandations IA** (estimations) sont obtenues via l'API FiestApp (NestJS), qui communique elle-même avec le service Python.

---

> Développé avec ❤️ pour l'écosystème **[FiestApp](https://github.com/Manon-Arc/FiestApp_Api)**.
