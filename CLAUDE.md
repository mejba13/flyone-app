# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Flyone is an AI-powered travel booking platform aggregating flights, trains, buses, and boats. The active codebase is a Flutter mobile app in the `flyone/` directory (95 Dart files). The root also contains a legacy `src/Main.java` placeholder and the PRD document (`Flyone_PRD_v1.0.docx`).

## Build & Run

All commands run from the `flyone/` directory:

```bash
cd flyone
flutter pub get          # install dependencies
flutter run              # run on connected device/emulator
flutter analyze          # static analysis (uses flutter_lints)
flutter test             # run tests (currently only flyone/test/widget_test.dart)
flutter build apk        # release APK
flutter build ios        # release iOS
```

SDK requirement: Dart `^3.7.0`

## Architecture

**Feature-first structure** under `flyone/lib/`:

- `core/` — shared theme, widgets, router, utilities
- `features/<name>/` — each feature follows `data/`, `domain/` (models, providers), `presentation/` (screens, widgets)

**State management:** Riverpod (`flutter_riverpod`). Providers live in `features/<name>/domain/<name>_provider.dart`.

**Routing:** GoRouter via `core/router/app_router.dart`. Shell route wraps the 4 bottom-nav tabs (Home, Search, Bookings, Profile). Detail screens (booking, payment, e-ticket, chat, tracking, notifications) are top-level routes outside the shell.

**Data layer:** Currently all mock data — each feature has `data/mock_<name>_repository.dart` with an abstract repository interface. No real API integration yet.

## Design System

Defined in `core/theme/`:

- **Colors** (`app_colors.dart`): Light Lilac `#D6CCFF` (primary), Deep Purple `#2D2654` (dark/text), Teal `#5BCFCF` (accent), Soft White `#F8F9FC` (background). Gradients: `primaryGradient`, `darkGradient`, `accentGradient`.
- **Typography** (`app_typography.dart`): Poppins (headings), Inter (body) via `google_fonts`.
- **Theme** (`app_theme.dart`): Material 3 light theme with `FlyoneThemeExtension` for custom colors. Access via `Theme.of(context).extension<FlyoneThemeExtension>()`.
- **Shared widgets** (`core/widgets/`): `PillButton`, `AppCard`, `SkeletonLoader`, `SectionHeader`, `RatingStars`, `AppBottomNav`, `ToastNotification`.

Cards use 16px border-radius. Buttons are pill-shaped with gradient fills.

## Key Dependencies

- `go_router` — declarative routing
- `flutter_riverpod` — state management
- `dio` — HTTP client (configured but not yet connected to APIs)
- `flutter_animate` — animations
- `qr_flutter` — QR codes on e-tickets
- `shimmer` — loading skeletons
- `cached_network_image` — image caching

## Features Implemented (Frontend Only)

Splash, onboarding, home dashboard, search (with filters), search results, booking detail (passenger form, seat map, addons, promo), payment (wallet, BNPL, payment methods), e-ticket (QR/barcode), notifications, AI chat assistant, live tracking, profile with loyalty.

## Planned Backend (from PRD)

Microservices: Node.js (NestJS) + Python (FastAPI). PostgreSQL, MongoDB, Redis, Elasticsearch. Kafka for events. GDS integrations (Amadeus, Sabre, Travelport). None of this is implemented yet.
