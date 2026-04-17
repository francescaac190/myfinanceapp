# 💰 Finova — Personal Finance App

> **Status:** 🚧 Refactoring — building in public
> **Started:** April 2026
> **Target:** Flutter app with Clean Architecture, tests, and CI/CD

A personal finance management app built with Flutter. This repo is both the app itself and the **plan I'm following to build it**. Every section below is a milestone — checked off as I ship it.

<br />

## 🎯 What this app will do

- Track balances across multiple accounts (checking, savings, cash, credit cards)
- Log income and expenses with categories
- Manage recurring bills with due date reminders
- Set savings goals and track progress
- Set monthly budget limits per category with alerts at 70% and 90%

<br />

## 🖼️ Design

The full UI is designed in Figma. Screens included: Home, Bills, Savings, Profile, Wallet, Budget Limits, Set Budget Limit.

> 📸 _Screenshots go here once the screens are built. For now, Figma exports; later, real app screenshots._

- [ ] Add Figma screenshots of all 7 screens
- [ ] Record a short GIF walkthrough once Home screen works
- [ ] Add a hero image to the top of this README

<br />

---

# 📋 Build Plan

Building this in **4 phases**. Each phase ships something working before moving to the next.

---

## Phase 1 — Foundation (Week 1)

Get the project skeleton right before writing any feature code.

- [x] Create Flutter project with Flutter 3.24+
- [ ] Set up folder structure (feature-first)
- [x] Add core dependencies to `pubspec.yaml`:
  - [x] `flutter_bloc` for state management
  - [x] `go_router` for navigation
  - [x] `dio` for networking
  - [x] `get_it` for dependency injection
  - [x] `flutter_secure_storage` for tokens
- [ ] Create the design system files:
  - [x] `app_colors.dart` ✅
  - [ ] `app_text_styles.dart`
  - [ ] `app_spacing.dart`
  - [ ] `app_radius.dart`
- [x] Set up `AppTheme` in `main.dart`
- [ ] Add `very_good_analysis` linter
- [ ] Create a "Hello World" screen using the design system to verify it works

**Goal:** When I run `flutter run`, I see a branded splash screen with the correct colors.

<br />

---

## Phase 2 — Mock API & First Screen (Week 2)

Build the Home screen end-to-end using fake data. Proves the architecture works before adding more complexity.

- [ ] Copy the mock API files into the project:
  - [ ] Fixtures into `assets/mocks/`
  - [ ] `api_endpoints.dart`, `api_dtos.dart`, `mock_api_service.dart` into `lib/core/api/`
- [ ] Register `assets/mocks/` in `pubspec.yaml`
- [ ] Build the **Home screen**:
  - [ ] Total balance card
  - [ ] "Spending This Month" card with category breakdown
  - [ ] Quick actions row (Send / Request / Pay Bills / Top Up)
  - [ ] Recent transactions list
  - [ ] Bottom navigation bar
- [ ] Connect the screen to `MockApiService.getHomeOverview()`
- [ ] Handle loading state (shimmer or spinner)
- [ ] Handle error state (retry button)

**Goal:** Home screen looks identical to the Figma design, loads data from mocks, handles loading and error states.

<br />

---

## Phase 3 — Core Features (Weeks 3–5)

Build the remaining screens one by one. Each screen follows the same pattern as Home.

### Wallet screen

- [ ] List of accounts with balances
- [ ] Total balance header with trend
- [ ] Card visual for each account (VISA/Mastercard styling)
- [ ] Connect to `MockApiService.getAccounts()`

### Bills screen

- [ ] Summary card with paid/pending/overdue totals
- [ ] Category breakdown chart (`fl_chart`)
- [ ] Upcoming bills list
- [ ] Overdue alert banner (if any)
- [ ] Mark-as-paid flow

### Savings screen

- [ ] Total saved card with trend
- [ ] Goal cards with progress bars
- [ ] "Create New Goal" button + form
- [ ] Add contribution flow

### Budget Limits screen

- [ ] Monthly spending summary with chart
- [ ] List of budgets with progress bars
- [ ] Color changes based on state (OK / WARNING / CRITICAL / EXCEEDED)
- [ ] Tap to edit a budget

### Set Budget Limit screen

- [ ] Category picker
- [ ] Amount input
- [ ] Period toggle (Weekly / Monthly)
- [ ] Threshold switches (Warning at 70%, Critical at 90%)
- [ ] Save button

### Profile screen

- [ ] User info header
- [ ] Linked accounts section
- [ ] Settings (Notifications, Currency, Language)
- [ ] Security (Face ID, Change PIN, Change Password)
- [ ] Logout button

**Goal:** All 7 screens from the Figma design are built and working with mock data.

<br />

---

## Phase 4 — Quality & Polish (Week 6)

This is what separates a "school project" from a portfolio piece. **Don't skip this phase.**

### Testing

- [ ] Add `flutter_test`, `bloc_test`, `mocktail` to `dev_dependencies`
- [ ] Write unit tests for at least 3 BLoCs (Home, Budgets, Transactions)
- [ ] Write widget tests for at least 2 critical screens
- [ ] Aim for 60%+ coverage

### CI/CD

- [ ] Add GitHub Actions workflow (`.github/workflows/ci.yml`)
- [ ] CI runs: `flutter analyze`, `flutter test`, `dart format --set-exit-if-changed`
- [ ] Add a CI status badge to this README

### i18n

- [ ] Set up `flutter_localizations`
- [ ] Create `.arb` files for English and Spanish
- [ ] Extract all visible strings

### Accessibility

- [ ] Verify minimum 48×48 tap targets on buttons
- [ ] Add `Semantics` labels to custom widgets
- [ ] Test with large font sizes enabled

### Documentation

- [ ] Take screenshots of every screen → add to this README
- [ ] Record a short demo GIF → add to top of README
- [ ] Write a simple architecture explanation in `docs/ARCHITECTURE.md`
- [ ] Update this README to remove the "build plan" framing and make it portfolio-facing

### Deploy

- [ ] Build release APK
- [ ] Attach APK to a GitHub Release
- [ ] Add download link to this README

**Goal:** Recruiters can open this repo, see what it is in 10 seconds, and download a working APK.

<br />

---

# 🛠️ Tech Stack (the plan)

| Category         | Choice                              | Why                                            |
| ---------------- | ----------------------------------- | ---------------------------------------------- |
| Framework        | Flutter 3.24                        | Cross-platform, my strongest stack             |
| State management | BLoC                                | Explicit events/states, great for interviews   |
| Navigation       | go_router                           | Declarative, supports deep links + auth guards |
| Networking       | Dio                                 | Industry standard, great interceptors          |
| DI               | get_it                              | Simple, no code generation needed initially    |
| Storage          | flutter_secure_storage + Hive       | Tokens secure, cache fast                      |
| Money            | decimal package                     | No float precision bugs                        |
| Charts           | fl_chart                            | Flexible, works well with custom theme         |
| Testing          | flutter_test + bloc_test + mocktail | Standard toolkit                               |

<br />

---

# 📂 Folder structure (target)

Where I'm heading. Not everything exists yet — growing into this structure feature by feature.

```
lib/
├── core/
│   ├── theme/          # AppColors ✅, AppTextStyles, AppSpacing
│   ├── api/            # Endpoints, DTOs, MockApiService ✅
│   ├── errors/         # Failure sealed class
│   ├── router/         # GoRouter config
│   └── di/             # get_it setup
│
├── features/
│   ├── home/
│   ├── wallet/
│   ├── bills/
│   ├── savings/
│   ├── budgets/
│   ├── transactions/
│   └── profile/
│
└── main.dart
```

Each feature folder will eventually have `data/`, `domain/`, and `presentation/` subfolders. Added as each feature is built — no empty folders upfront.

<br />

---

# ▶️ How to run (once Phase 1 is done)

```bash
git clone https://github.com/YOUR_USERNAME/finova.git
cd finova
flutter pub get
flutter run
```

The app runs in **mock mode by default** — no backend needed. All data comes from JSON fixtures in `assets/mocks/`.

<br />

<!-- ---

# 📖 Related docs

- 🔗 **Backend spec** → see [`docs/BACKEND_SPEC.md`](docs/BACKEND_SPEC.md) _(the full backend contract for when the backend gets built)_
- 🔗 **Backend repo** → _coming after the Flutter app is done_

<br />

--- -->

# 👩‍💻 About

Built by **Francesca Antelo Callau** — Frontend & Mobile Engineer based in Bolivia 🇧🇴.
Portfolio project demonstrating Flutter architecture, state management, and clean code practices.

**[LinkedIn](https://linkedin.com/in/YOUR_USERNAME)** · **[GitHub](https://github.com/YOUR_USERNAME)**

<br />

---

# 📝 Progress log

Notes on what I finished each week. Helps me see progress and gives me material for LinkedIn posts.

- **Week 1 (Apr 14–20):** Set up design system, created `AppColors`. Backend spec written. Mock API layer built.
- **Week 2:** _In progress…_

<br />

---

_This README updates as the app gets built._
