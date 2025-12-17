<div align="center">

# 🐾 Rifq App

**A smart application that brings together all pet care services into one unified digital platform**

[![Flutter](https://img.shields.io/badge/Flutter-3.10.0-02569B?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.10.0-0175C2?logo=dart)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

[Demo Videos](#-demo-videos) • [Features](#-key-features) • [Tech Stack](#-technologies--libraries) • [Project Structure](#-project-structure)

---

</div>

## 📌 App Overview

Rifq offers an integrated system for managing a pet's life in terms of health and services. Through the app, users can:

- ✅ Create a personal profile and a dedicated profile for each pet
- ✅ View all their pets under one account
- ✅ Manage pet health records, including vaccinations, clinic name, and type of service received
- ✅ Track approved medical appointments with clinic names and doctor notes (if available)
- ✅ Browse and book veterinary clinics
- ✅ Book pet hotel services, select pets, and complete payments digitally
- ✅ Explore pet stores, view products and food, and make purchases
- ✅ Use an AI-powered chat service to inquire about their pet's condition by sending questions or images and receiving instant responses
- ✅ Access external services such as mobile pet services (coming soon)
- ✅ Offer pets for adoption or adopt pets through a trusted process

---

## 🎯 Problem Statement

- ❌ Pet owners lack a single application that gathers all pet-related services
- ❌ There is no reliable platform to store and manage pet health records and history
- ❌ Managing appointments, bookings, and payments is often fragmented and inconvenient
- ❌ There is no unified and trusted platform dedicated to pet adoption

> 💡 **Rifq solves these challenges by providing everything a pet owner needs in one place.**

---

## 👥 Target Users

- 🐕 **Pet Owners** - Manage their pets' health, book services, and shop for pet supplies
- 🏥 **Service Providers** - Clinics, hotels, stores, and external services

---

## 🧑‍⚕️ Service Providers

Service providers can:

- 📝 Register as a service provider and add their services
- 📨 Receive appointment requests that include pet information
- ✅ Accept or reject appointments
- 📋 View detailed pet health information
- 📝 Add doctor notes after accepting an appointment
- 🔄 Have approved appointments and notes automatically appear in the pet's profile for the owner

---

## ✨ Key Features

| Feature | Description |
|---------|-------------|
| 🤖 **AI-powered assistance** | Chat with AI to get instant answers about your pet's health |
| 🩺 **Healthcare management** | Comprehensive pet health records and appointment tracking |
| 🐶 **Adoption service** | Trusted platform for pet adoption |
| 🏨 **Hotel booking** | Book pet hotel services with digital payments |
| 🛒 **Pet store** | Browse and purchase pet products and food |
| 💳 **Secure payments** | Integrated with Moyasar Payment Gateway |
| 📱 **Modern UI/UX** | Beautiful and user-friendly interface |

---

## 🎥 Demo Videos

<div align="center">

### Watch the app in action!

[![Owner Flow Demo](https://img.shields.io/badge/👤_Owner_Flow_Demo-Watch_Now-red?style=for-the-badge&logo=youtube)](https://youtu.be/fytTfUbhCcY)

[![Provider Flow Demo](https://img.shields.io/badge/🏥_Provider_Flow_Demo-Watch_Now-blue?style=for-the-badge&logo=youtube)](https://youtu.be/ZeeCFmXZJK0)

</div>

---

## 💳 Payments

The app is integrated with **Moyasar Payment Gateway** to enable secure and seamless online payments for:

- 🏨 Pet hotel bookings
- 💼 Paid services
- 🛒 Store purchases

---

## 📂 Project Structure

The project follows a **feature-based clean architecture** with clear separation between core logic and application features.

```
├── assets/
│   ├── icon/
│   ├── images/
│   ├── lottie/
│   └── splash/
├── android/
├── ios/
├── lib/
│   ├── core/
│   │   ├── common/
│   │   │   ├── choose_path/
│   │   │   ├── splash/
│   │   │   └── widgets/
│   │   ├── di/
│   │   ├── routes/
│   │   ├── shared/
│   │   │   ├── enum/
│   │   │   ├── shared_in_owner_flow/
│   │   │   └── shared_in_service_provider_flow/
│   │   ├── theme/
│   │   └── utils/
│   │
│   ├── features/
│   │   ├── owner_flow/
│   │   │   ├── add_pet/
│   │   │   ├── adoption/
│   │   │   ├── ai/
│   │   │   ├── auth/
│   │   │   ├── clinic/
│   │   │   │   └── clinic_sub_features/
│   │   │   │       ├── book_appointment/
│   │   │   │       ├── booking_details/
│   │   │   │       ├── clinic_details/
│   │   │   │       └── confirmation/
│   │   │   ├── home/
│   │   │   ├── hotel/
│   │   │   │   └── sup_feauter/
│   │   │   │       ├── booking_hotel/
│   │   │   │       └── payment/
│   │   │   ├── nav/
│   │   │   ├── onbording/
│   │   │   ├── pet_profile/
│   │   │   │   └── sup_features/
│   │   │   │       ├── edit_pet_profile/
│   │   │   │       ├── pet_info_card/
│   │   │   │       └── pet_profile_health_record/
│   │   │   ├── profile/
│   │   │   └── store/
│   │   │
│   │   └── services_provider_flow/
│   │       ├── auth/
│   │       ├── home/
│   │       ├── nav/
│   │       └── profile/
│   │
│   └── main.dart
│
├── test/
├── .env
├── .gitignore
└── pubspec.yaml
```

> **Note:** Each feature follows clean architecture with `data`, `domain`, and `presentation` layers.

---

## 🛠️ Technologies & Libraries

### Framework
- ![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white) **Flutter**
- ![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white) **Dart**

### State Management & Architecture
- `flutter_bloc` - State management
- `equatable` - Value equality
- `injectable` - Dependency injection
- `get_it` - Service locator
- `dart_mappable` - Object mapping
- `multiple_result` - Result handling

### Backend & Services
- `supabase_flutter` - Backend as a Service
- `google_generative_ai` - AI chat functionality
- `flutter_ai_toolkit` - AI toolkit integration

### UI & UX
- `flutter_screenutil` - Responsive design
- `google_fonts` - Custom typography
- `flutter_svg` - SVG support
- `lottie` - Animations
- `flutter_animate` - Animation library
- `skeletonizer` - Loading skeletons
- `carousel_slider` - Image carousels
- `smooth_page_indicator` - Page indicators
- `loading_animation_widget` - Loading animations
- `dotted_line` - Dotted lines

### Forms & Validation
- `flutter_form_builder` - Form building
- `form_builder_validators` - Form validation
- `pinput` - PIN input

### Navigation & Utilities
- `go_router` - Declarative routing
- `intl` - Internationalization
- `url_launcher` - URL launching
- `image_picker` - Image selection
- `get_storage` - Local storage
- `flutter_dotenv` - Environment variables
- `easy_localization` - Localization

### Payment
- `moyasar` - Payment gateway integration

---

## 🔧 Dev Dependencies

- `flutter_test` - Testing framework
- `flutter_lints` - Linting rules
- `build_runner` - Code generation
- `injectable_generator` - DI code generation
- `dart_mappable_builder` - Mapping code generation

---

## 👥 Team

<div align="center">

| Team Member | Role |
|------------|------|
| **Rand Aljarbou** | Developer |
| **Shatha Alblawi** | Developer |
| **Hattem Althobaity** | Developer |

</div>

---

## 🚀 Notes

- ⚠️ Some services such as mobile pet services are under development
- 🚀 The application is designed to be scalable and ready for future expansion

---

<div align="center">

### **Rifq – Because your pet deserves better care** 🐾

Made with ❤️ by the Rifq Team

</div>
