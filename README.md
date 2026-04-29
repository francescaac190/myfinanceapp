# 💰 Finova — Personal Finance App

> **Status:** 🚧 In progress — building in public
> **Started:** April 2026
> **Target launch:** June 12, 2026
> **Goal:** Flutter app for senior Flutter roles

A personal finance management app built with Flutter and Clean Architecture. This README is a living document — milestones get checked off as they ship.

<br />

## 🎯 What this app does

- Track balances across multiple accounts (checking, savings, cash, credit cards)
- Log income and expenses with categories
- Manage recurring bills with due date reminders
- Set savings goals and track progress
- Set monthly budget limits per category with alerts at 70% and 90%

<br />

## 🖼️ Design

The full UI is designed in Figma. Screens: Home, Bills, Savings, Profile, Wallet, Budget Limits, Set Budget Limit.

> 📸 _Screenshots and demo GIF will be added once screens are built._

<br />

---

# 🗺️ Roadmap

**8-week plan · Apr 17 – Jun 12, 2026 · ~10h/week**

| Week                      | Phase                     | Milestone                                           |
| ------------------------- | ------------------------- | --------------------------------------------------- |
| **Week 1** (Apr 17–23)    | Phase 1 — Foundation      | Project skeleton + design system + shell navigation |
| **Week 2** (Apr 24–30)    | Phase 2 — First Feature   | Home screen fully working with mock API             |
| **Week 3** (May 1–7)      | Phase 3a — Core Screens   | Wallet + Bills screens                              |
| **Week 4** (May 8–14)     | Phase 3b — Core Screens   | Savings + Budget Limits screens                     |
| **Week 5** (May 15–21)    | Phase 3c — Forms & Detail | Set Budget + Profile + Add Transaction              |
| **Week 6** (May 22–28)    | Phase 4a — Testing        | Unit tests + widget tests + coverage ≥ 60%          |
| **Week 7** (May 29–Jun 4) | Phase 4b — Polish         | i18n + CI/CD + accessibility                        |
| **Week 8** (Jun 5–11)     | Phase 4c — Launch         | Deploy + README + LinkedIn post                     |

### Success criteria

- [ ] 7 screens built, working with mock data
- [ ] Clean Architecture with feature-first folder structure
- [ ] BLoC state management, GoRouter navigation, design system in place
- [ ] 60%+ test coverage on use cases and BLoCs
- [ ] CI pipeline running on every PR
- [ ] Deployed APK on GitHub Releases + demo GIF + polished README
- [ ] i18n (English + Spanish)
- [ ] Published on LinkedIn with at least 2 build-in-public posts

<br />

---

## Phase 1 — Foundation

**Week 1 · Apr 17–23 · Est. 10h**

Get the project skeleton right. No features yet — just a branded shell with a working bottom nav bar navigating between 5 empty placeholder screens.

**Setup**

- [x] Create Flutter project with proper structure
- [x] Initialize Git repo
- [x] Add core dependencies (`flutter_bloc`, `go_router`, `dio`, `get_it`, `flutter_secure_storage`, `equatable`, `decimal`)
- [x] Add `very_good_analysis` to `dev_dependencies` ✅
- [x] Update `analysis_options.yaml` ✅

**Design system**

- [x] `app_colors.dart` ✅
- [x] `app_text_styles.dart` ✅
- [x] `app_spacing.dart` — xs (4) · sm (8) · md (16) · lg (24) · xl (32) · xxl (48) ✅
- [x] `app_radius.dart` — sm (8) · md (12) · lg (16) · xl (20) · full (999) ✅
- [x] Wire everything into `AppTheme.dark` in `main.dart` ✅

**Navigation shell**

- [x] `core/navigation/app_shell.dart`
- [x] `core/navigation/widgets/app_bottom_nav_bar.dart`
- [x] `core/navigation/widgets/app_floating_button.dart`
- [x] `core/navigation/widgets/bottom_bar_item.dart`
- [x] `core/router/app_router.dart` with `StatefulShellRoute.indexedStack`
- [x] 5 placeholder pages: Home, Wallet, Bills, Savings, Profile ✅

**DI + Mock API**

- [x] `core/di/injection.dart` with `setupDependencies()` ✅
- [x] Copy mock API files into `core/api/` (`api_endpoints.dart`, `api_exception.dart`, `mock_api_service.dart`) ✅
- [x] Copy JSON fixtures into `assets/mock/fixtures/` (15 fixtures: auth, users, home, accounts, transactions, categories, bills, savings, budgets, errors) ✅
- [x] Register `assets/mock/fixtures/` in `pubspec.yaml` ✅
- [x] Register `MockApiService` as lazy singleton in `injection.dart` ✅

**Main wiring**

- [x] Update `main.dart` to 3-step structure: init → DI → runApp ✅
- [x] `flutter analyze` passes with zero warnings ✅ _(`No issues found!`)_
- [ ] `flutter run` launches on iOS and Android, all 5 tabs navigate _(needs manual device verification)_

**Definition of Done**

- [x] `flutter analyze` clean ✅
- [ ] `flutter run` works on iOS and Android _(manual verification)_
- [ ] All 5 tabs navigate correctly _(manual verification)_
- [x] No hardcoded colors outside `core/theme/` ✅
- [x] `main.dart` under 40 lines ✅ _(34 lines)_
- [ ] Repo is public on GitHub

<br />

---

## Phase 2 — First Feature (Home)

**Week 2 · Apr 24–30 · Est. 12h**

Build the Home screen end-to-end following the full Clean Architecture pattern (data → domain → presentation). This is the template every other feature copies.

**Domain layer**

- [ ] Entities: `HomeOverview`, `SpendingCategory`, `QuickAction`, `RecentTransaction`
- [ ] `HomeRepository` abstract class
- [ ] `GetHomeOverviewUseCase`

**Data layer**

- [ ] `HomeOverviewDto` matching mock JSON
- [ ] `HomeRepositoryImpl` mapping DTO → entity
- [ ] Register in `injection.dart`

**BLoC**

- [ ] Events: `LoadHomeOverview`, `RefreshHomeOverview`
- [ ] States: `HomeInitial`, `HomeLoading`, `HomeLoaded`, `HomeError`
- [ ] `HomeBloc` wired to use case
- [ ] 3 BLoC unit tests

**UI**

- [ ] Reusable widgets: `AppCard`, `MoneyText`, `TrendBadge`
- [x] `HomeHeader` widget (greeting + avatar) ✅
- [x] `BalanceCard` widget ✅
- [x] `SpendingBalance` widget ✅
- [x] `SpendingCard` / `SpendingCardList` widget ✅
- [x] `TransactionList` widget ✅
- [x] `GradientProgressBar` widget ✅
- [x] `HomeScreen` assembled with all sections ✅
- [ ] Loading state (shimmer or skeleton)
- [ ] Error state with retry button
- [ ] Pull-to-refresh

**Definition of Done**

- [ ] Home screen matches Figma design
- [ ] Loading, error, and success states all work
- [ ] Pull-to-refresh triggers new data load
- [ ] 3+ BLoC unit tests pass
- [ ] Zero hardcoded colors/sizes in `features/home/`
- [ ] At least 5 meaningful commits

<br />

---

## Phase 3 — Core Screens

**Weeks 3–5 · May 1–21 · Est. 30h total**

Each screen follows the same 5-step recipe from Phase 2: domain → data → BLoC → UI → connect + test states.

### Week 3 — Wallet + Bills (May 1–7)

**Wallet screen**

- [ ] Accounts list with card-style design (VISA/Mastercard gradients)
- [ ] Total balance header with trend badge
- [ ] Quick actions: Add money / Transfer / Pay
- [ ] Recent transactions section

**Bills screen**

- [ ] Summary card with paid/pending/overdue totals
- [ ] Donut chart for category breakdown (`fl_chart`)
- [ ] Upcoming bills list with days-until-due badges
- [ ] Overdue alert banner
- [ ] Mark-as-paid bottom sheet

### Week 4 — Savings + Budget Limits (May 8–14)

**Savings screen**

- [ ] Total saved card with monthly trend
- [ ] Goal cards with progress bars and contribution amounts
- [ ] "Create New Goal" floating button → form bottom sheet
- [ ] Empty state when no goals exist

**Budget Limits screen**

- [ ] Monthly spending summary with donut chart
- [ ] Budget list with color-coded progress bars
- [ ] State logic: OK / WARNING / CRITICAL / EXCEEDED
- [ ] Tap to edit → navigates to Set Budget screen

### Week 5 — Forms + Details (May 15–21)

**Set Budget Limit screen**

- [ ] Category picker
- [ ] Large amount input with currency formatting
- [ ] Period toggle (Weekly / Monthly)
- [ ] Threshold switches (70% warning, 90% critical)
- [ ] Form validation + error states
- [ ] Save button → POST to mock API

**Profile screen**

- [ ] User header with avatar
- [ ] Linked accounts section
- [ ] Settings group (Notifications, Currency, Language)
- [ ] Security group (Face ID, Change PIN, Change Password)
- [ ] Logout button with confirmation dialog

**Add Transaction flow**

- [ ] Amount input with +/- toggle (income vs expense)
- [ ] Category picker, account picker, date picker, notes field
- [ ] Submit → mock API → return to Home with refreshed data

**Definition of Done for Phase 3**

- [ ] All 7 screens built and pixel-close to Figma
- [ ] Every screen has loading / error / empty states
- [ ] Navigation between screens works with proper back stacks
- [ ] At least 2 BLoC unit tests per feature (14+ total)
- [ ] Demo video recorded of a full user flow

<br />

---

## Phase 4 — Testing, Polish & Launch

**Weeks 6–8 · May 22–Jun 11 · Est. 25h total**

### Week 6 — Testing (May 22–28)

- [ ] Add `bloc_test`, `mocktail`, `golden_toolkit` to `dev_dependencies`
- [ ] Use case tests: success + failure paths, target 90%+ coverage on domain layer
- [ ] BLoC tests: state transition tests with `bloc_test`, cover error emissions
- [ ] Widget tests for 2 critical screens (Home, Budget Limits)
- [ ] Run `flutter test --coverage`, generate HTML report
- [ ] Tag commit: `v0.4.0-tests-complete`

**Definition of Done**

- [ ] Total coverage ≥ 60%, domain layer ≥ 90%
- [ ] All tests pass locally, no flaky tests

### Week 7 — Polish (May 29–Jun 4)

**i18n**

- [ ] Add `flutter_localizations` + `intl`
- [ ] Create `lib/l10n/app_en.arb` and `app_es.arb`
- [ ] Extract all hardcoded strings
- [ ] Language switcher in Profile settings
- [ ] Test with device set to Spanish

**CI/CD**

- [ ] Create `.github/workflows/ci.yml` (format → analyze → test → build APK)
- [ ] Add CI status badge to README
- [ ] Verify CI runs green on a PR

**Accessibility + Performance**

- [ ] All interactive elements ≥ 48×48
- [ ] `Semantics` labels on custom widgets
- [ ] Verify 60fps on real device, check for unnecessary rebuilds
- [ ] Add `const` constructors everywhere possible

**Definition of Done**

- [ ] App works in English and Spanish
- [ ] CI badge shows green
- [ ] Accessibility inspector shows no warnings
- [ ] 60fps on real device

### Week 8 — Launch (Jun 5–11)

- [ ] Export high-quality screenshots (every screen) → `docs/images/`
- [ ] Record 30-second demo GIF (Kap / ScreenToGif), optimize to <10MB
- [ ] Rewrite README: add hero image, demo GIF, screen gallery, architecture decisions
- [ ] Build release APK: `flutter build apk --release`
- [ ] Tag `v1.0.0`, create GitHub Release with changelog + APK attached
- [ ] Write `docs/ARCHITECTURE.md` with Mermaid diagram
- [ ] LinkedIn launch post with demo GIF and repo link

**Definition of Done**

- [ ] `v1.0.0` tagged and released
- [ ] README has screenshots, GIF, and download link
- [ ] APK downloadable from GitHub Releases
- [ ] LinkedIn post live

<br />

---

# 🛠️ Tech Stack

| Category         | Choice                              | Why                                            |
| ---------------- | ----------------------------------- | ---------------------------------------------- |
| Framework        | Flutter 3.24                        | Cross-platform, primary stack                  |
| State management | BLoC                                | Explicit events/states, great for interviews   |
| Navigation       | go_router                           | Declarative, supports deep links + auth guards |
| Networking       | Dio                                 | Industry standard, great interceptors          |
| DI               | get_it                              | Simple, no code generation needed              |
| Storage          | flutter_secure_storage + Hive       | Tokens secure, cache fast                      |
| Money            | decimal package                     | No float precision bugs                        |
| Charts           | fl_chart                            | Flexible, works well with custom theme         |
| Testing          | flutter_test + bloc_test + mocktail | Standard toolkit                               |

<br />

---

# 📂 Folder Structure

```
lib/
├── core/
│   ├── theme/          # AppColors ✅, AppTextStyles ✅, AppSpacing, AppRadius
│   ├── api/            # Endpoints, DTOs, MockApiService
│   ├── errors/         # Failure sealed class
│   ├── router/         # GoRouter config ✅
│   ├── navigation/     # AppShell, BottomNavBar ✅
│   └── di/             # get_it setup
│
├── features/
│   ├── home/           # presentation/screens ✅, presentation/widgets ✅
│   ├── wallet/
│   ├── bills/
│   ├── savings/
│   ├── budgets/
│   ├── transactions/
│   └── profile/
│
└── main.dart
```

Each feature folder has `data/`, `domain/`, and `presentation/` subfolders — added as each feature is built.

<br />

---

# ▶️ How to Run

```bash
git clone https://github.com/francescaac190/finova.git
cd finova
flutter pub get
flutter run
```

The app runs in **mock mode by default** — no backend needed. All data comes from JSON fixtures in `assets/mocks/`.

<br />

---

# 📝 Progress Log

- **Week 1 (Apr 17–23):** Design system complete (`AppColors` ✅, `AppTextStyles` ✅, `AppSpacing` ✅, `AppRadius` ✅, `AppTheme.dark` wired). Navigation shell built (`AppShell`, `AppRouter`, `BottomNavBar`, `FloatingButton`, `BottomBarItem` ✅) plus all 5 placeholder screens (Home, Wallet, Bills, Savings, Profile) and auth screens scaffolded (Login, Signup). Lint config set up (`very_good_analysis` + `analysis_options.yaml` ✅).
- **Week 2 (Apr 17–ongoing):** Home screen UI built end-to-end — `HomeHeader`, `BalanceCard`, `SpendingBalance`, `SpendingCard`/`SpendingCardList`, `TransactionList`, and `GradientProgressBar` widgets all complete ✅. Home screen assembled with static/mock data. Mock API stack fully wired: 15 JSON fixtures in `assets/mock/fixtures/`, `ApiEndpoints` constants, `MockApiService` (`get`/`post` with latency + special-case `POST /budgets`), `ApiException`, and `setupDependencies()` registering `Dio` + `MockApiService` lazy singletons. `main.dart` now runs `init → DI → runApp` in 34 lines. `flutter analyze` clean.

<br />

---

# 👩‍💻 About

Built by **Francesca Antelo Callau** — Frontend & Mobile Engineer.

**[LinkedIn](https://linkedin.com/in/YOUR_USERNAME)** · **[GitHub](https://github.com/francescaac190)**

<br />

---

_This README updates as the app gets built. Last updated: April 28, 2026._
