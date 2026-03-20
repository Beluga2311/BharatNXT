# BharatNxt — Flutter Assignment

A Flutter app built as an interview assignment demonstrating Clean Architecture, BLoC state management, and local persistence.

---

## Features

- **Chat** — Create/delete sessions, AI mock replies, typing indicator, Hive persistence.
- **Listing** — Paginated product suggestions with manual page/limit controls.
- **Theme** — Light/dark toggle with persisted preference.

---

## Architecture

**Clean Architecture** with feature-first folders. Each feature has three layers:

```
Presentation (BLoC + Pages + Widgets)
     ↓
Domain (Entities, Use Cases, Repository contracts)
     ↓
Data (Models, Repository impls, Data sources)
```

Domain has zero Flutter/third-party dependencies. Data models implement domain entity interfaces, making real API integration a drop-in swap.

---

## Key Concepts

| Concept | Detail |
|---|---|
| State management | `flutter_bloc` — BLoC for features, Cubit for theme toggle |
| Sealed classes | `ChatEvent/State`, `ListingEvent/State` — exhaustive compile-time handling |
| Freezed models | Listing models are immutable with auto-generated `copyWith`, `==`, `hashCode` |
| Dependency injection | `GetIt` lazy singletons via `core/di/injector.dart` |
| Local storage | Hive abstracted behind `LocalStorageService` interface |
| Navigation | Imperative `Navigator.push`; `IndexedStack` for bottom nav tab state |
| Mock data | Both features simulate async network calls via `Future.delayed` |

---

## Screenshots

<img src="screenshots/Screenshot 2026-03-20 at 12.11.57 PM.png" width="250" /> <img src="screenshots/Screenshot 2026-03-20 at 12.12.00 PM.png" width="250" /> <img src="screenshots/Screenshot 2026-03-20 at 12.12.47 PM.png" width="250" />

<img src="screenshots/Screenshot 2026-03-20 at 12.12.57 PM.png" width="250" /> <img src="screenshots/Screenshot 2026-03-20 at 12.14.10 PM.png" width="250" /> <img src="screenshots/Screenshot 2026-03-20 at 12.15.51 PM.png" width="250" />

<img src="screenshots/Screenshot 2026-03-20 at 12.15.57 PM.png" width="250" /> <img src="screenshots/Screenshot 2026-03-20 at 12.16.05 PM.png" width="250" /> <img src="screenshots/Screenshot 2026-03-20 at 12.16.18 PM.png" width="250" />

<img src="screenshots/Screenshot 2026-03-20 at 12.16.28 PM.png" width="250" />

---

## Running

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```
