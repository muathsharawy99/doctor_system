# D❤CARE — Doctor System

A Flutter app for doctors to manage their patients: create an account, log in, then list, add, edit and delete patients and view your profile. It is available in **English and Arabic**.

## Features

- **Splash** — animated logo, then create account
- **Auth** — create account and log in (doctor; the admin side is "coming soon"); the session is saved on the device
- **Patients** — list (pull to refresh), add, edit and delete; date pickers for date of birth and visit time
- **Profile** — the doctor's data and logout
- **Localization** — English and Arabic

## Tech stack

| Concern | Package / approach |
|---|---|
| State management | `flutter_bloc` (Cubit) + `equatable` |
| Architecture | MVVM per feature: `service` → `manager` (cubit) → `screens` / `widgets` |
| Networking | `dio` behind a `ServerGate` singleton returning `CustomResponse<T>` |
| Dependency injection | `get_it` |
| Routing | Named routes (`NamedRoutes` + `AppRoutes`) |
| Local storage | `shared_preferences` via `CacheHelper` (signed-in doctor in `UserModel`) |
| Localization | `easy_localization` with generated `LocaleKeys` |
| Responsive sizes | `flutter_screenutil` |
| Assets | `flutter_gen` (+ `lottie`) |
| Toasts | `flash` |
| App icon | `flutter_launcher_icons` |

## Project structure

```
lib/
  core/
    blocs/          # safe Cubit
    extensions/     # context, widget and string extensions (unified_extensions.dart barrel)
    resources/      # API endpoints, constants, sizes, font sizes, shadows
    services/       # ServerGate (Dio), service locator, cache, bloc observer
    shared/         # base model, UserModel, routes, reusable widgets
    utils/          # theme, colors, logger, unfocus
  features/
    intro/splash/   # splash
    auth/           # register, login (+ role tiles)
    patients/       # list, add, details (shared form, card, service)
    profile/        # profile + logout
  gen/              # generated files — don't edit by hand
  main.dart
assets/
  images/  lottie_files/  translations/ (en.json, ar.json)
```

Each feature follows the same layout:

```
features/<feature>/
  data/models/   manager/ (cubit + state)   screens/   service/   widgets/
```

Features with several screens keep one sub-folder per screen under `screens/`, sharing the feature's `service/`, `data/models/` and `widgets/`.

## Getting started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart run easy_localization:generate -S assets/translations -f keys -O lib/gen -o locale_keys.g.dart
flutter run
```

For iOS, run `cd ios && pod install && cd ..` after `pub get`. App icons: `dart run flutter_launcher_icons`.

Before committing:

```bash
flutter analyze
```

Build a release APK:

```bash
flutter build apk --split-per-abi
```

## API

The base URL and every endpoint are in `lib/core/resources/api_constants.dart`. Responses report success with `code` 200 / 201 in the body.

## Adding text

1. Add the key to **both** `assets/translations/en.json` and `ar.json`.
2. Regenerate the keys (command above).
3. Use it as `LocaleKeys.<key>.tr()`.

## Git

All work happens directly on `main` — no feature branches. Commits and pushes are done by the author.

## Author

**Muath Sharawy** — Flutter developer

- Email: muath0sharawy@gmail.com
- LinkedIn: [linkedin.com/in/muathsharawy99](https://linkedin.com/in/muathsharawy99)
- GitHub: [github.com/muathsharawy99](https://github.com/muathsharawy99)
- Portfolio: [muathsharawy.web.app](https://muathsharawy.web.app)
