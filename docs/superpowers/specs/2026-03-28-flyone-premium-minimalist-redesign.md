# Flyone Premium Minimalist Redesign — "Soft Depth"

## Overview

Full UI/UX redesign of the Flyone Flutter app toward a premium minimalist aesthetic ("Soft Depth"). The approach preserves the existing color palette (deep purple, lilac, teal, soft white) while adding restraint, whitespace, and refined interactions. Every screen gets touched.

## Design Tokens & Foundation

### Border Radius (3 tiers, down from 7)
- `small: 12px` — inputs, chips, badges, small buttons
- `medium: 16px` — cards, containers, modals
- `large: 24px` — bottom sheets, panels, bottom nav

### Shadows (2 tiers, replacing scattered patterns)
- `subtle`: offset(0, 2), blur 8, deepPurple at 0.06 opacity
- `elevated`: offset(0, 4), blur 16, deepPurple at 0.10 opacity (press/interaction states)
- All dual-shadow patterns removed. All colored shadows (lilac, etc.) removed.

### Spacing (strict 4px grid)
- `xs: 4`, `sm: 8`, `md: 12`, `lg: 16`, `xl: 20`, `xxl: 24`, `xxxl: 32`

### Opacity Constants
- `dim: 0.06`, `light: 0.12`, `medium: 0.35`, `strong: 0.60`

### Animation
- Duration: `fast: 200ms`, `normal: 300ms`, `slow: 450ms`
- Curve: `Curves.easeOutBack` (spring) for interactions, `Curves.easeOut` for entrances
- Press scale: `0.96` universally (replaces current 0.97/0.98 mix)
- Stagger interval: `80ms` between items (tightened from 100ms)

### Typography Refinements
- Heading1: 32px (up from 28), Poppins w700, letter-spacing -0.5
- Heading2: 22px, Poppins w600, letter-spacing -0.3
- Heading3: 18px, Poppins w500
- Body: 15px (down from 16), Inter w400
- BodySmall: 13px (down from 14), Inter w400
- Caption: 12px, Inter w400, letter-spacing 0.2
- Label: 11px, Inter w500, letter-spacing 0.8, uppercase
- All hardcoded font sizes replaced with AppTypography references

### Gradient Refinement
- Primary: vertical (top-to-bottom) lilac → softWhite, replacing diagonal
- Dark: unchanged (deepPurple → #4A3F7A)
- Accent: teal at 0.9 → teal at 0.7 opacity (more subtle)

### Shimmer
- Base: `#EFECF5`, highlight: `#F8F6FC` (softer contrast)

## Core Components

### Bottom Nav
- Floating bar: 24px radius, 16px horizontal margin, 12px from bottom edge
- Background: white at 0.92 opacity with subtle shadow
- Active tab: morphing pill indicator (lilac at 0.12 opacity) behind icon + label
- Inactive: icon only, textSecondary color
- Spring animation 300ms on tab switch
- Remove top border divider — shadow handles separation

### AppCard
- Single `subtle` shadow only
- 16px border-radius universally
- Internal padding: 16px
- Press: scale 0.96 + transition to `elevated` shadow via spring curve

### PillButton
- Primary: Deep Purple solid fill, white text (no gradient default)
- Accent: Teal solid fill, white text
- Ghost: transparent + 1px deepPurple border
- Gradient variant reserved for hero CTAs only
- Standard height: 48px, small: 36px
- Press: scale 0.96 + 5% darken

### Section Headers
- Title: Heading3
- Action text: 11px uppercase, 0.8 letter-spacing, teal color
- Subtle fade-in on scroll

### Toast Notifications
- 16px radius, single subtle shadow
- Reduced icon size, increased internal whitespace

## Screen Designs

### Home Screen
- **Header**: Greeting + avatar only. Points badge moves to profile screen.
- **Hero text**: 32px heading1, -0.5 letter-spacing
- **Category icons**: 52px circles, surfaceVariant fill (not lilac), increased horizontal spacing, teal for active state
- **Schedule cards**: Fix overflow bug. Padding 16px. Single subtle shadow. "See Details" as ghost pill button (not floating/overlapping). "Baggage Type" with proper word spacing. Reduce info density — show route + time + date only.
- **Destination cards**: 3:4 aspect ratio (taller). Bottom 40% gradient overlay only. Remove bookmark icon. Price as small pill at bottom-left.
- **Voucher carousel**: Remove decorative circles/shapes. Cleaner layout, more whitespace, softer colors.
- **FAB**: 52px, teal solid fill, subtle shadow, no gradient.

### Search Screen
- **Header illustration**: Simplify to 2-3 geometric shapes max (from 7+). Lower opacity.
- **Form card**: Single subtle shadow, 24px radius, 20% more internal spacing.
- **Location selector**: Larger tap targets, swap button 40px with subtle shadow.
- **Date/passenger selectors**: Cleaner rows, more breathing room.
- **Search button**: Full-width deep purple solid, 48px height.

### Search Results
- **Filter bar**: Horizontal scroll chips, 12px radius, ghost style default, deep purple fill when active.
- **Route cards**: Remove left gradient stripe. Single subtle shadow. More whitespace between info rows. Price right-aligned in regular weight (not bold badge).
- **Dashed route line**: 1px width, lighter color.

### Booking Detail
- **Route summary card**: Keep gradient, reduce color intensity 20%.
- **Passenger form**: 52px input height, more spacing between fields.
- **Seat map**: Larger seat targets, clearer state colors (selected/available/taken).
- **Price breakdown**: Clean table, thin dividers, total in heading2 weight.
- **Section separation**: 24px spacing replaces heavy ruled dividers.

### Payment Screen
- **Wallet card**: Keep dark gradient, remove decorative circles.
- **Payment methods**: Simplified — brand icon + name + last 4 digits, radio on right, no colored backgrounds.
- **Order summary**: More whitespace, subtotals in caption weight, total in heading3.
- **CTA**: Full-width "Pay Now" deep purple solid, 48px.

### E-Ticket
- **Ticket card**: Keep notch design, refine notch radius to 12px.
- **QR section**: More padding around QR code, centered.
- **Info rows**: Caption labels above body values.
- **Download button**: Ghost style (not gradient).

### Profile
- **Background**: Remove decorative circles.
- **Avatar**: 80px centered, subtle shadow ring.
- **Loyalty badge**: Small pill below name (not separate card).
- **Info rows**: Icon + label + value, 56px row height.
- **Settings**: Simple list with chevrons, dividers only, no cards.

### Notifications
- **Tab bar**: Custom pill tabs (not Material TabBar). Unread as small teal dot (not number badge).
- **Cards**: Timestamp right-aligned, unread = 6px teal dot on left.

### Chat
- **User bubbles**: Deep purple solid (not gradient), 16px radius, 4px bottom-right.
- **AI bubbles**: surfaceVariant fill, 16px radius, 4px bottom-left.
- **Input bar**: Floating, 24px radius, subtle shadow, send = teal circle.

### Tracking
- **Map placeholder**: Softer grid, muted colors.
- **Bottom panel**: 24px top radius, drag handle indicator, cleaner info layout.

### Splash & Onboarding
- Apply same spacing and typography tokens. Simplify decorative elements.

## Files to Modify

### Foundation (modify first)
- `core/theme/app_colors.dart` — add opacity constants, shimmer updates
- `core/theme/app_typography.dart` — update sizes, add letter-spacing, add label style
- `core/theme/app_theme.dart` — update theme defaults

### New File
- `core/theme/app_constants.dart` — border radius, shadows, spacing, animation constants

### Core Widgets
- `core/widgets/pill_button.dart` — redesign variants
- `core/widgets/app_card.dart` — single shadow, standardized radius
- `core/widgets/app_bottom_nav.dart` — floating bar redesign
- `core/widgets/section_header.dart` — label style for action text
- `core/widgets/skeleton_loader.dart` — softer shimmer colors
- `core/widgets/toast_notification.dart` — softer styling
- `core/router/shell_screen.dart` — floating bottom nav integration

### Feature Screens (all presentation/ files)
- Every screen and widget file under `features/*/presentation/`

## Out of Scope
- Dark mode
- Localization / string extraction (separate effort)
- Backend integration
- New features or screens
- Accessibility audit (separate effort)
