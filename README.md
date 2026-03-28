<div align="center">

# <img src="https://img.icons8.com/fluency/48/airplane-take-off.png" width="36" /> Flyone

### AI-Powered Travel Booking Platform

**Book flights, trains, buses & boats — all in one stunning app.**

[![Flutter](https://img.shields.io/badge/Flutter-3.7+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.7+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-10B981?style=for-the-badge)](LICENSE)

<br/>

<img width="280" alt="Home Screen" src="https://img.shields.io/badge/13-Screens-2D2654?style=for-the-badge" />
<img width="280" alt="Features" src="https://img.shields.io/badge/102-Dart_Files-5BCFCF?style=for-the-badge" />
<img width="280" alt="Design" src="https://img.shields.io/badge/Premium-UI%2FUX-D6CCFF?style=for-the-badge" />

</div>

---

## About

Flyone is a premium, AI-powered travel booking mobile app that aggregates flights, trains, buses, and boats into a single platform. Built with Flutter for cross-platform performance, it features intelligent recommendations, real-time tracking, dynamic pricing, digital ticketing with QR codes, and a luxury editorial design system.

**Current Stage:** Frontend prototype with complete UI, mock data, and animations. Backend integration planned.

<img width="1892" height="1220" alt="CleanShot 2026-03-28 at 3  49 37" src="https://github.com/user-attachments/assets/a00eaf72-10a7-4b71-a6a4-be270c4fe385" />


---

## Features

| Feature | Description |
|---------|-------------|
| **Multi-Modal Search** | Search across flights, trains, buses, and boats with filters for class, passengers, and dates |
| **Smart Booking Flow** | Passenger forms, interactive seat maps, add-ons (baggage, meals, insurance, lounge) |
| **Digital E-Tickets** | QR code and barcode tickets with passenger info and PNR |
| **AI Chat Assistant** | Conversational travel helper with quick reply suggestions |
| **Live Tracking** | Real-time vehicle tracking with route progress visualization |
| **Payment Integration** | Multiple payment methods, wallet, Buy Now Pay Later, promo codes |
| **Booking Management** | Tabbed view of upcoming, completed, and cancelled trips |
| **Notifications** | Categorized alerts for bookings, deals, and system updates |
| **Loyalty Program** | Points system with tier progression (Explorer → Navigator) |
| **Profile Management** | Personal info, preferences, and settings |

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | Flutter 3.7+ / Dart 3.7+ |
| **State Management** | Riverpod (`flutter_riverpod`) |
| **Navigation** | GoRouter (`go_router`) |
| **Animations** | `flutter_animate` |
| **Fonts** | Google Fonts (Poppins + Inter) |
| **HTTP** | Dio |
| **QR Codes** | `qr_flutter` |
| **Images** | `cached_network_image` |

---

## Design System

<table>
<tr>
<td width="50%">

### Color Palette

| Color | Hex | Usage |
|-------|-----|-------|
| Deep Purple | `#2D2654` | Primary, headers, text |
| Teal | `#5BCFCF` | Accent, CTAs, success |
| Light Lilac | `#D6CCFF` | Backgrounds, badges |
| Soft White | `#F8F9FC` | Page backgrounds |

</td>
<td width="50%">

### Typography

| Style | Size | Font |
|-------|------|------|
| Display | 36px w800 | Poppins |
| Heading 1 | 28px w700 | Poppins |
| Heading 2 | 22px w600 | Poppins |
| Route Code | 22px w700 | Poppins |
| Body | 15px w400 | Inter |
| Caption | 11px w400 | Inter |

</td>
</tr>
</table>

### Design Highlights

- **Gradient Hero Headers** — Deep purple gradient headers with frosted glass buttons across all screens
- **Premium Minimalist** — "Soft Depth" aesthetic with subtle shadows and 4px spacing grid
- **Choreographed Animations** — Staggered entrance reveals (80ms intervals), spring press states (0.96 scale)
- **3-Tier Border Radius** — 12px (inputs), 16px (cards), 24px (panels)
- **Floating Bottom Nav** — Glass-morphic bar with morphing pill indicator

---

## Project Structure

```
flyone-app/
├── flyone/                      # Flutter application
│   ├── lib/
│   │   ├── core/
│   │   │   ├── theme/           # Colors, typography, constants
│   │   │   ├── widgets/         # Shared UI components
│   │   │   ├── router/          # GoRouter configuration
│   │   │   └── utils/           # Transport icons, helpers
│   │   └── features/
│   │       ├── home/            # Dashboard with schedules, destinations, vouchers
│   │       ├── search/          # Trip search + results with route cards
│   │       ├── booking/         # Booking detail with seat map, addons, pricing
│   │       ├── bookings/        # Bookings list (upcoming/completed/cancelled)
│   │       ├── payment/         # Payment methods, wallet, order summary
│   │       ├── ticket/          # E-ticket with QR code and barcode
│   │       ├── chat/            # AI assistant with chat bubbles
│   │       ├── tracking/        # Live tracking with map and route progress
│   │       ├── profile/         # User profile with loyalty and settings
│   │       ├── notifications/   # Tabbed notification categories
│   │       ├── onboarding/      # 3-page intro with orbit animations
│   │       ├── splash/          # Animated splash screen
│   │       └── loyalty/         # Loyalty tier data
│   ├── test/
│   └── pubspec.yaml
└── README.md
```

Each feature follows the **domain-driven structure**: `data/` (repositories), `domain/` (models, providers), `presentation/` (screens, widgets).

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.7.0`
- Dart SDK `^3.7.0`
- Android Studio or VS Code with Flutter extension
- Android emulator or iOS simulator

### Installation

```bash
# Clone the repository
git clone https://github.com/mejba13/flyone-app.git
cd flyone-app/flyone

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Available Commands

```bash
flutter run              # Run on connected device/emulator
flutter analyze          # Static analysis
flutter test             # Run tests
flutter build apk        # Build Android APK
flutter build ios        # Build iOS (macOS only)
```

---

## App Screens

| Screen | Route | Description |
|--------|-------|-------------|
| Splash | `/splash` | Animated logo with gradient background |
| Onboarding | `/onboarding` | 3-page intro with orbit icon animations |
| Home | `/home` | Dashboard with schedules, destinations, vouchers |
| Search | `/search` | Multi-modal trip search form |
| Search Results | `/search-results` | Filterable route cards with ratings |
| Booking Detail | `/booking-detail` | Passenger form, seat map, add-ons, pricing |
| Payment | `/payment` | Methods, wallet, BNPL, order summary |
| E-Ticket | `/eticket` | QR/barcode ticket with notch design |
| My Bookings | `/bookings` | Tabbed trip management |
| Profile | `/profile` | User info, loyalty tier, settings |
| Notifications | `/notifications` | Categorized alerts with unread dots |
| AI Chat | `/chat` | Conversational travel assistant |
| Live Tracking | `/tracking` | Real-time vehicle tracking |

---

## Architecture

```
┌─────────────────────────────────────────────┐
│                 Presentation                 │
│   Screens → Widgets → Animations            │
├─────────────────────────────────────────────┤
│                   Domain                     │
│   Models → Providers (Riverpod)              │
├─────────────────────────────────────────────┤
│                    Data                      │
│   Mock Repositories → (Future: API + DB)     │
└─────────────────────────────────────────────┘
```

- **State Management:** Riverpod with `FutureProvider`, `StateProvider`, and `StateNotifierProvider`
- **Routing:** GoRouter with `ShellRoute` for bottom navigation tabs
- **Data Layer:** Mock repositories with simulated async delays (ready for real API swap)

---

## Planned Backend (from PRD)

| Service | Technology | Purpose |
|---------|-----------|---------|
| API Gateway | Node.js (NestJS) | RESTful client-facing APIs |
| ML Service | Python (FastAPI) | AI recommendations, price prediction |
| Databases | PostgreSQL, MongoDB, Redis | Transactional, sessions, cache |
| Search | Elasticsearch | Full-text search |
| Messaging | Apache Kafka | Event-driven communication |
| Infrastructure | AWS (EKS, RDS, S3) | Cloud hosting |
| GDS | Amadeus, Sabre, Travelport | Flight inventory |

---

## Developed By

<div align="center">

<img width="380" height="420" alt="engr-mejba-ahmed" src="https://github.com/user-attachments/assets/83e72c39-5eaa-428a-884b-cb4714332487" />


### **Engr Mejba Ahmed**

**AI Developer | Software Engineer | Entrepreneur**

[![Portfolio](https://img.shields.io/badge/Portfolio-mejba.me-10B981?style=for-the-badge&logo=google-chrome&logoColor=white)](https://www.mejba.me)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/mejba)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/mejba13)

</div>

---

## Hire / Work With Me

I build AI-powered applications, mobile apps, and enterprise solutions. Let's bring your ideas to life!

| Platform | Description | Link |
|----------|-------------|------|
| **Fiverr** | Custom builds, integrations, performance optimization | [fiverr.com/s/EgxYmWD](https://www.fiverr.com/s/EgxYmWD) |
| **Mejba Personal Portfolio** | Full portfolio & contact | [mejba.me](https://www.mejba.me) |
| **Ramlit Limited** | Software development company | [ramlit.com](https://www.ramlit.com) |
| **ColorPark Creative Agency** | UI/UX & creative solutions | [colorpark.io](https://www.colorpark.io) |
| **xCyberSecurity** | Global cybersecurity services | [xcybersecurity.io](https://www.xcybersecurity.io) |

---

<div align="center">

**Built with Flutter & crafted with care**

</div>
