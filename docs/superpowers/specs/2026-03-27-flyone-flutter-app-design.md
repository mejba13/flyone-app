# Flyone Flutter Travel Booking App — Design Spec

**Date:** 2026-03-27
**Status:** Approved
**Author:** Claude Code + Engr Mejba Ahmed

## Overview

Complete Flutter mobile app for Flyone — an AI-powered travel booking platform aggregating flights, trains, buses, and boats. Built with clean architecture, Riverpod state management, and a custom 4-color design system matching the PRD brand identity.

## Tech Stack

- **Framework:** Flutter 3.x with Dart
- **State Management:** Riverpod (flutter_riverpod)
- **Navigation:** GoRouter with ShellRoute for bottom nav
- **HTTP Client:** Dio (abstracted behind repository interfaces)
- **Animations:** flutter_animate
- **Fonts:** google_fonts (Poppins headings, Inter body)
- **QR Codes:** qr_flutter
- **Images:** cached_network_image
- **Loading:** shimmer
- **Dates:** intl

## Architecture

### Clean Architecture Layers

```
lib/
├── main.dart
├── app.dart                          # MaterialApp.router, theme, providers
├── core/
│   ├── theme/
│   │   ├── app_theme.dart            # ThemeData + custom ThemeExtension
│   │   ├── app_colors.dart           # 4-color palette + semantic aliases
│   │   └── app_typography.dart       # Poppins/Inter text styles
│   ├── router/
│   │   └── app_router.dart           # GoRouter config with ShellRoute
│   ├── widgets/                      # Shared reusable widgets
│   │   ├── app_card.dart             # 16px rounded card with shadow
│   │   ├── pill_button.dart          # Pill-shaped gradient button
│   │   ├── skeleton_loader.dart      # Shimmer loading placeholder
│   │   ├── app_bottom_nav.dart       # Bottom navigation bar
│   │   ├── toast_notification.dart   # Slide-in toast overlay
│   │   └── rating_stars.dart         # Star rating widget
│   ├── constants/
│   │   └── app_constants.dart        # App-wide constants
│   └── utils/
│       └── result.dart               # Result<T> pattern (Success/Failure)
├── features/
│   ├── splash/
│   │   └── presentation/
│   │       └── splash_screen.dart
│   ├── onboarding/
│   │   └── presentation/
│   │       ├── onboarding_screen.dart
│   │       └── widgets/
│   │           └── onboarding_page.dart
│   ├── home/
│   │   ├── presentation/
│   │   │   ├── home_screen.dart
│   │   │   └── widgets/
│   │   │       ├── points_badge.dart
│   │   │       ├── category_icons.dart
│   │   │       ├── upcoming_schedule_card.dart
│   │   │       ├── destination_card.dart
│   │   │       └── voucher_carousel.dart
│   │   ├── domain/
│   │   │   └── home_provider.dart
│   │   └── data/
│   │       └── mock_home_data.dart
│   ├── search/
│   │   ├── presentation/
│   │   │   ├── search_screen.dart
│   │   │   ├── search_results_screen.dart
│   │   │   └── widgets/
│   │   │       ├── trip_type_toggle.dart
│   │   │       ├── location_selector.dart
│   │   │       ├── date_picker_field.dart
│   │   │       ├── passenger_class_selector.dart
│   │   │       ├── route_card.dart
│   │   │       └── filter_sort_bar.dart
│   │   ├── domain/
│   │   │   ├── search_provider.dart
│   │   │   └── models/
│   │   │       ├── search_query.dart
│   │   │       └── search_result.dart
│   │   └── data/
│   │       ├── search_repository.dart
│   │       └── mock_search_repository.dart
│   ├── booking/
│   │   ├── presentation/
│   │   │   ├── booking_detail_screen.dart
│   │   │   └── widgets/
│   │   │       ├── passenger_form.dart
│   │   │       ├── seat_selection.dart
│   │   │       ├── addons_section.dart
│   │   │       ├── promo_code_field.dart
│   │   │       └── price_breakdown.dart
│   │   ├── domain/
│   │   │   ├── booking_provider.dart
│   │   │   └── models/
│   │   │       └── booking.dart
│   │   └── data/
│   │       ├── booking_repository.dart
│   │       └── mock_booking_repository.dart
│   ├── payment/
│   │   ├── presentation/
│   │   │   ├── payment_screen.dart
│   │   │   └── widgets/
│   │   │       ├── payment_method_card.dart
│   │   │       ├── add_card_form.dart
│   │   │       └── wallet_balance.dart
│   │   ├── domain/
│   │   │   ├── payment_provider.dart
│   │   │   └── models/
│   │   │       └── payment_method.dart
│   │   └── data/
│   │       ├── payment_repository.dart
│   │       └── mock_payment_repository.dart
│   ├── ticket/
│   │   ├── presentation/
│   │   │   ├── eticket_screen.dart
│   │   │   └── widgets/
│   │   │       ├── ticket_qr_code.dart
│   │   │       ├── ticket_info_card.dart
│   │   │       └── ticket_barcode.dart
│   │   ├── domain/
│   │   │   └── models/
│   │   │       └── ticket.dart
│   │   └── data/
│   │       └── mock_ticket_data.dart
│   ├── profile/
│   │   ├── presentation/
│   │   │   ├── profile_screen.dart
│   │   │   └── widgets/
│   │   │       ├── profile_header.dart
│   │   │       ├── loyalty_tier_badge.dart
│   │   │       └── settings_list.dart
│   │   ├── domain/
│   │   │   └── profile_provider.dart
│   │   └── data/
│   │       ├── user_repository.dart
│   │       └── mock_user_repository.dart
│   ├── notifications/
│   │   ├── presentation/
│   │   │   ├── notifications_screen.dart
│   │   │   └── widgets/
│   │   │       └── notification_card.dart
│   │   ├── domain/
│   │   │   ├── notification_provider.dart
│   │   │   └── models/
│   │   │       └── app_notification.dart
│   │   └── data/
│   │       ├── notification_repository.dart
│   │       └── mock_notification_repository.dart
│   ├── chat/
│   │   ├── presentation/
│   │   │   ├── chat_screen.dart
│   │   │   └── widgets/
│   │   │       ├── chat_bubble.dart
│   │   │       ├── quick_reply_chips.dart
│   │   │       └── typing_indicator.dart
│   │   ├── domain/
│   │   │   ├── chat_provider.dart
│   │   │   └── models/
│   │   │       └── chat_message.dart
│   │   └── data/
│   │       ├── chat_repository.dart
│   │       └── mock_chat_repository.dart
│   ├── tracking/
│   │   ├── presentation/
│   │   │   └── tracking_screen.dart
│   │   ├── domain/
│   │   │   └── tracking_provider.dart
│   │   └── data/
│   │       ├── tracking_repository.dart
│   │       └── mock_tracking_repository.dart
│   └── loyalty/
│       ├── domain/
│       │   └── models/
│       │       └── loyalty_info.dart
│       └── data/
│           ├── loyalty_repository.dart
│           └── mock_loyalty_repository.dart
```

### Repository Pattern

Each domain has an abstract repository interface and a mock implementation:

```dart
// Abstract interface
abstract class SearchRepository {
  Future<Result<List<SearchResult>>> search(SearchQuery query);
  Future<Result<List<String>>> getSuggestions(String query);
}

// Mock implementation
class MockSearchRepository implements SearchRepository {
  @override
  Future<Result<List<SearchResult>>> search(SearchQuery query) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return Success(_mockResults);
  }
}
```

### Result Pattern

```dart
sealed class Result<T> {
  const Result();
}
class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}
class Failure<T> extends Result<T> {
  final String message;
  final Exception? exception;
  const Failure(this.message, [this.exception]);
}
```

### Riverpod Providers

Each feature exposes providers that abstract data access:

```dart
final searchRepositoryProvider = Provider<SearchRepository>(
  (ref) => MockSearchRepository(),
);

final searchResultsProvider = FutureProvider.family<List<SearchResult>, SearchQuery>(
  (ref, query) async {
    final repo = ref.read(searchRepositoryProvider);
    final result = await repo.search(query);
    return switch (result) {
      Success(:final data) => data,
      Failure(:final message) => throw Exception(message),
    };
  },
);
```

## Design System

### Colors

| Name | Hex | Usage |
|------|-----|-------|
| Light Lilac | `#D6CCFF` | Primary — backgrounds, cards, highlights |
| Deep Purple | `#2D2654` | Dark — headers, CTAs, text |
| Teal/Mint | `#5BCFCF` | Accent — badges, icons, secondary actions |
| Soft White | `#F8F9FC` | Base — page backgrounds |

Semantic aliases: `cardBackground`, `badgeColor`, `dividerColor`, `errorColor`, `successColor`.

### Typography

| Style | Font | Weight | Size |
|-------|------|--------|------|
| Heading 1 | Poppins | Bold | 28px |
| Heading 2 | Poppins | SemiBold | 22px |
| Heading 3 | Poppins | Medium | 18px |
| Body | Inter | Regular | 16px |
| Caption | Inter | Regular | 12px |
| Button | Poppins | Medium | 16px |

### Components

- **Cards:** 16px border-radius, soft shadow (`elevation: 2`, `shadowColor: Colors.black12`)
- **Buttons:** Pill-shaped (border-radius 24px), gradient fill (lilac → teal for primary CTAs), Deep Purple for solid buttons
- **Icons:** 2px stroke weight line icons
- **Bottom Nav:** 4 tabs — Home (house), Search (search), Bookings (calendar), Profile (person)
- **Skeleton Loading:** Shimmer effect with lilac tint on soft white
- **Toast:** Slide-in from top with icon (success/error/info), auto-dismiss after 3s
- **Pull-to-Refresh:** Custom indicator with lilac spinner

### Animations (flutter_animate)

- Screen entrances: `fadeIn` + `slideY` (200ms, ease)
- Card list items: staggered `fadeIn` + `slideX` (100ms offset per item)
- Swap animation on from/to: `rotate` + `scale` on swap icon
- Bottom nav: `scale` pulse on active tab change
- Hero transitions: search result card → booking detail header
- Voucher carousel: auto-scroll with parallax

## Screen Specifications

### 1. Splash Screen
- Centered Flyone logo with fade-in animation
- Auto-navigate to Onboarding (first time) or Home (returning user) after 2s
- Soft white background with lilac accent

### 2. Onboarding (3 slides)
- Slide 1: "Travel Made Effortless" — multi-modal transport illustration
- Slide 2: "AI-Powered Planning" — smart recommendations illustration
- Slide 3: "Digital Tickets & Tracking" — e-ticket illustration
- Page indicator dots, Skip button, Next/Get Started CTA
- Lilac + teal flat illustration style

### 3. Home Dashboard
- **Top bar:** Points badge (star icon + "320 points"), search icon, notification bell with dot
- **Hero text:** "Travel Made Effortless" in Poppins Bold 28px
- **Category icons:** Trains, Flights, Boats, Bus — circular icons with badges (e.g., "20%" on Trains)
- **Upcoming Schedules:** Horizontal scrollable cards showing carrier, route codes, time, duration, type badge, "See Details" button
- **Recommendations:** "View All" header, grid of destination image cards
- **Voucher Carousel:** Auto-scrolling promotional banners (e.g., "New member 30% off", "Buy 1 Get 1")

### 4. Trip Search
- **Header illustration:** Train/transport illustration with "Find Your Best Trip"
- **Trip type toggle:** One Way / Round Trip pill toggle
- **From/To fields:** Location pins with city names, swap button with rotation animation
- **Date field:** Calendar icon with date picker
- **Passenger field:** Person count + class (Economy/Business/First)
- **Search CTA:** Full-width dark pill button

### 5. Search Results
- **Header:** "Search Results" with result count, origin/destination summary with swap
- **Filter/Sort bar:** Horizontal chips (Price, Duration, Rating, Departure)
- **Route cards:** Carrier logo + name, class badge, route codes with dotted line + transport icon, departure/arrival times, duration, rating stars, "Ability to reschedule" teal badge, price per pax, heart + bookmark icons

### 6. Booking Detail
- **Route summary header** (carrier, route, times)
- **Passenger form:** Name, email, phone (auto-fill from profile), add passenger button
- **Seat selection:** Interactive grid with color legend (available/occupied/premium/selected)
- **Add-ons:** Checkable cards (baggage, meals, insurance, lounge)
- **Promo code:** Text field with apply button
- **Price breakdown:** Itemized list with total, Continue to Payment CTA

### 7. E-Ticket
- **Header:** Share + more options buttons
- **Ticket card:** Trip type badge, carrier logo, route codes with times, duration, gate/terminal info
- **Passenger name** section
- **QR code** centered
- **Barcode** with reference number
- **Download button:** Full-width teal pill

### 8. Payment
- **Saved methods:** List of cards with radio selection
- **Add new card:** Expandable form (number, expiry, CVV)
- **Wallet balance:** Card showing balance with top-up option
- **BNPL toggle:** Buy Now Pay Later option with info
- **Order summary:** Collapsed price breakdown
- **Pay Now CTA:** Full-width dark pill with amount

### 9. Profile
- **Avatar** with edit icon
- **Name + email** below avatar
- **Loyalty tier badge:** Explorer/Navigator/Captain with progress bar
- **Personal info card:** Phone, nationality, passport (edit)
- **Saved travelers** section
- **Settings list:** Notifications, Language, Currency, Privacy, Help, Logout

### 10. Notifications
- **Tab bar:** Bookings / Deals / System
- **Notification cards:** Icon, title, description, timestamp, read/unread indicator
- **Empty state** per tab with illustration

### 11. AI Chat Assistant
- **Chat bubbles:** User (right, dark bg) and AI (left, lilac bg)
- **Quick reply chips:** Horizontal scrollable suggestions
- **Typing indicator:** Animated dots
- **Input bar:** Text field with send button
- **Suggested prompts** on empty state

### 12. Live Tracking
- **Map placeholder** (colored container with route visualization)
- **Vehicle info card:** Type, position, ETA
- **Route timeline:** Origin → stops → destination with progress indicator

## Navigation Map

```
Splash → Onboarding (first time) → Home
                                    ↓
Bottom Nav Shell ─── Home ──────── Search (from category tap)
                 ├── Search ─────── Search Results → Booking Detail → Payment → E-Ticket
                 ├── Bookings ───── E-Ticket (from booking list)
                 └── Profile

Standalone routes:
  - Notifications (from Home bell icon)
  - AI Chat (from FAB or home)
  - Live Tracking (from booking/e-ticket)
```

## Mock Data Domains

| Repository | Mock Data |
|------------|-----------|
| AuthRepository | Fake user session, social auth stubs |
| SearchRepository | 10+ route results across transport modes |
| BookingRepository | Booking creation, seat map, add-ons list |
| PaymentRepository | 3 saved cards, wallet with $150 balance |
| LoyaltyRepository | 320 points, Explorer tier, 5 vouchers |
| UserRepository | Profile with passport, 2 saved travelers |
| NotificationRepository | 15 notifications across 3 categories |
| ChatRepository | Pre-scripted AI responses with delays |
| TrackingRepository | Simulated vehicle position updates |

## Performance Targets

- App launch (cold start): < 3s
- Screen transitions: < 300ms
- Search results render: < 500ms (mock delay 800ms to simulate real API)
- Smooth 60fps animations throughout
- App size: < 50MB
