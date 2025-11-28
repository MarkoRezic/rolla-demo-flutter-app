# rolla_demo_app


# Setup & Run
Make sure to follow all of the setup steps below before debugging or building the app, to run/build the apk once ready run:
`fvm flutter run --<mode>`
`fvm flutter build apk --release`

The built app should be available under: `build\app\outputs\flutter-apk\app-release.apk`.

## FVM
This project uses fvm (Flutter Version Manager) to keep a separate fixed flutter version for the project, and to make version management for a team easier

To activate it locally run:
`dart pub global activate fvm`

In the project the .fvmrc file specifies the flutter version used.
As of writing this document, it uses the latest stable version of flutter 3.38.0.

To install a particular version, run:
`fvm install <version>`
For example:
`fvm install stable`

To switch to a different version:
`fvm use <version>`

IMPORTANT: any `flutter` or `dart` commands from now on should be prefixed with `fvm` (`fvm flutter ...`)
Make sure to also set up the project to use the fvm Dart SDK. For Android Studio:
File -> Settings -> Languages & Frameworks -> Dart -> Dart SDK Path
example: `path\to\project\.fvm\flutter_sdk\bin\cache\dart-sdk`

Note: you can probably still run the project without fvm - but make sure your flutter version is the same

## Packages & Generated Files
To get all the necessary packages run:
`fvm flutter pub get`

### build_runner
To generate files (for packages like freezed)
Run the following (and rerun if the files ever change):
`fvm flutter pub run build_runner build --delete-conflicting-outputs`

If something went wrong with the generation and you need to start over:
`fvm flutter pub run build_runner clean`

### .arb and intl
To generate translation files (from the .arb templates located under `lib/l10n`)
Run the following (and rerun if the .arb files change):
`fvm flutter pub run intl_utils:generate`

The resulting files will be placed under `lib/generated`

### App Icon & Splash Screen
To generate the app launcher icon (currently the asset is located in `assets/icons/app_icon.png`):
`fvm flutter pub run flutter_launcher_icons:main`

To generate the app splash screen (currently the center icon asset is located in `assets/icons/app_icon.png`)
`flutter pub run flutter_native_splash:create`


# Architecture
In this section are brief descriptions provided (where needed) for the project folders and files

```
/ (project root)
├─ android/ 
├─ ios/ 
├─ assets/ 
│ ├─ data/ # static JSON or seed data
│ ├─ fonts/ # font files referenced in pubspec
│ ├─ icons/ # icon assets
│ └─ images/ # app images (unused)
├─ build/ 
├─ lib/
│ ├─ main.dart # Application entrypoint (initialization + runApp)
│ ├─ injection.dart # App-level DI/service-locator registrations - calls core and score injections
│ ├─ generated/ # Generated code (i18n, codegen outputs) - does not need to be manually changed
│ │ └─ intl/
│ │ ├─ l10n.dart 
│ │ └─ l10n.dart.dart
│ ├─ l10n/ # Localization resource files (arb, app_localizations) - for translation texts use .arb files
│ │ ├─ app_localizations.dart
│ │ ├─ app_localizations_en.dart
│ │ ├─ intl_en.arb
│ │ └─ intl_hr.arb
│ ├─ core/ # Shared/core layer used across features
│ │ ├─ assets/ # constants/paths for assets
│ │ ├─ data/ # core data layer - contains shared prefs repository and global settings models
│ │ ├─ di/ # injection of core blocs/services
│ │ ├─ domain/ # shared domain models / interfaces
│ │ ├─ error/ # app-wide error & failure types
│ │ ├─ extensions/ # extension methods - sorted in subfolders by containing type
│ │ ├─ localization/ # app-level localization helpers/wrappers (here is the tr utility for translation that uses the current locale)
│ │ ├─ presentation/ # shared UI widgets, common blocs/cubits
│ │ ├─ theme/ # theme definitions, colors, text styles
│ │ └─ utils/ # utilities (formatters, date helpers)
│ └─ features/ # Feature modules (each feature follows the same clean architecture)
│   ├─ scores/
│   │ ├─ data/ # data sources, repository implementations, models
│   │ ├─ di/ # injection of score blocs/services
│   │ ├─ domain/ # use-cases, entities, repository interfaces
│   │ └─ presentation/ # UI layer: pages, widgets, state management (Cubit/Bloc)
│   └─ settings/
│     └─ presentation/ # UI for settings (small feature with no domain/data yet)
└─ pubspec.yaml # dependencies, assets declarations, flutter config
```

# Additional Notes & Assumptions
The UI itself was pretty forward - but i wanted to make the app as functional as possible and not just "get the UI/Task done as-is"
This is why i dedicated quite some time planning out the structure of the project itself, and adding an init screen for the users name, which then further leads into the users settings etc.

---

The Settings in particular were also a good choice for showing the clean architecture, as Shared Preferences were used as the repository and persistence across app restarts.
The app has a full-feature language and theme support which are very extensible.

---

The Scores JSON was generated using a js script and then imported as the final asset - not that some scores were deliberately removed to show error or missing data handling in the app.
Any loading times visible in the app are actually mocked - this was intentionally made to be able to show off loading states / skeleton loaders etc.

---

Regarding timeframes: the 30D timeframe was actually implemented to span an entire month instead of the last 30D - Two reasons:
- since the 7D view shows an entire week (Mon-Sun) I decided to make the Month properly adjust to the timeframe
- getting the last N days is trivial so I Thought this would better show a more interesting solution (if required)

The "Monthly" switch on the 1Y view was also completely optional - I added it to showcase both a line chart and bar chart

---

The "Readiness" and "Activity" score detail screens are accessible from the "Health Score" screen - and they transfer the currently selected date when opened from there.

Most metric scores were calculated with taking into consideration the actual medical implications for example:
- Scores and their progress weren't naively measured as "More is better"
- Simpler metrics like "Steps" were based around a threshold value and anything higher was simply the maximum score
- More complex metrics that required a target value but had a specific feasible range were calculated slightly differently - where score was measured as the distance from the target within the feasible range
- Going outside of the feasible range meant a score of 0
- Being inside a target range (as opposed to just having a target value) meant a score of 100

---

For the most part the widgets were split up into smaller reusable widgets (I personally wanted to do more modularization but time is tight these days).

Notes for some of the widgets (that might not be obvious from the provided video):
- The date switcher (left/right) on the 1D/7D/30D/1Y view also has a date picker when the date is tapped
- The minimum/maximum date cases are also handled so the user cannot go past todays date nor before the minimum date of the earliest score they have recorded
- Widgets rarely used hard-coded colors (unless accent for score type was required) - they almost always use theme defined colors to support theme adaptability
- The DisabledWrapper is devised in a way that it can wrap any widget to present it in a disabled state - with no additional adjustments required in the child widget UI
- Settings are persisted across app restarts - and only the initial launch shows the "Enter your name" screen
- System theme properly matches the light/dark mode of the device
- Contextual insights could have had more meaningful texts - but the focus was on still keeping everything multi-language friendly

---

Regarding testing I wanted to run this on more devices to see how the UI behaves - but I didnt have much time left so I decided to continue working on the features.
Widget/Unit tests and a PDF export of the score results were also something I wanted to add but scrapped the idea in the end.