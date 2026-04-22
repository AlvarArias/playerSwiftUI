# playerSwiftUI — CLAUDE.md

## Project Overview

SwiftUI radio streaming app for SVT/SR (Swedish Radio) channels targeting iOS, watchOS, and Share Extension.

| Component | Type | Purpose |
|-----------|------|---------|
| `Home Radio View/` | SwiftUI | Station list, tab navigation, splash, network check |
| `Detail View/` | SwiftUI | Player screen, Lottie animation, favorites button |
| `Toolbar/` | SwiftUI | Search bar, favorites display, settings |
| `Data model/ViewModels/` | Logic | HomeModell (list state), Detail Data Model (playback) |
| `Data model/Core Data/` | Persistence | DataController — favorites via Core Data |
| `Data model/Helpers/` | Utilities | Colors, date formatter, network checker |
| `Data model/JSON files/` | Models | NewRadioObj — station data model |
| `Data model/Song playing now/` | Feature | Now-playing metadata (NewSongModel) |
| `Compartido/` | Shared data | radios23.json — shared across iOS, Watch, and Share Extension |
| `radioSharer/` | Extension | iOS Share Extension |
| `watch_player/` | watchOS | WatchOS companion app |

**Frameworks:** SwiftUI, Combine, AVFoundation (audio playback), Core Data, Lottie  
**iOS Target:** iOS 16+  
**watchOS Target:** watchOS companion  
**Current Swift version:** 5.x (pending Swift 6 migration)  
**Key Dependencies:** Lottie (animations)

---

## Targets

| Target | Platform | Purpose |
|--------|----------|---------|
| `playerSwiftUI` | iOS | Main radio player app |
| `watch_player` | watchOS | WatchOS app shell |
| `watch_player WatchKit Extension` | watchOS | WatchKit extension logic |
| `radioSharer` | iOS | Share Extension for sharing radio stations |

---

## Architecture

### Data Flow
```
radios23.json → LoadRadioStationJSONFile → HomeModell (ViewModel) → HomeRadioView → DetalleUIView
SVT XML API → ParseController (XMLParser) → XMLSwiftUIView (schedule data)
```

### Key Classes/Structs
- `LoadRadioStationJSONFile` — loads `radios23.json` from bundle, returns `[radioStationInfo]`
- `PlayRadio` — wraps `AVPlayer`, handles audio session and stream playback
- `ParseController: XMLParserDelegate, ObservableObject` — fetches and parses SVT schedule XML feed
- `DataController` — Core Data stack (`NSPersistentContainer`)
- `UserSettings: ObservableObject` — UserDefaults wrapper for user preferences and favorites
- `theURLSetting: ObservableObject` — current playing URL and favorite state

---

## Swift 6 Migration — PENDING

The project is currently on Swift 5.x. The following steps are needed when migrating:

### Required Changes:

#### 1. Add `@MainActor` to ViewModels
```swift
// BEFORE
class HomeModell: ObservableObject { ... }

// AFTER
@MainActor
final class HomeModell: ObservableObject { ... }
```

#### 2. Replace `DispatchQueue` with async/await
```swift
// BEFORE
DispatchQueue.main.async { self.someValue = result }

// AFTER
await MainActor.run { self.someValue = result }
// or annotate the enclosing func with @MainActor
```

#### 3. Replace XMLParser semaphore pattern in `Request.swift`
```swift
// BEFORE (uses DispatchSemaphore — blocks thread)
let semaphore = DispatchSemaphore(value: 0)

// AFTER — wrap in async/await using withCheckedContinuation
func loadData(theRadioURL: String) async { ... }
```

#### 4. Replace deprecated APIs
```swift
// BEFORE
@Environment(\.presentationMode) var presentationMode
presentationMode.wrappedValue.dismiss()

// AFTER
@Environment(\.dismiss) var dismiss
dismiss()
```

#### 5. Guard force-unwraps in URL construction
```swift
// BEFORE
URL(string: theRadioURL)!

// AFTER
guard let url = URL(string: theRadioURL) else { return }
```

---

## Development Guidelines

### General Rules
- Prefer `async/await` + structured concurrency over GCD (`DispatchQueue`)
- Never force-unwrap (`!`) unless the invariant is provably safe — add a comment explaining why
- Use `guard let` early-exit over deeply nested `if let`
- Keep views dumb: no business logic in View structs — move to ViewModel
- Do not use `AnyView` — use generics or `@ViewBuilder` instead
- Handle network errors gracefully: show UI feedback, not silent failures
- `UserDefaults` changes go through `UserSettings` — never write directly to `UserDefaults` from a View

### Core Data Rules
- `DataController` is injected via `.environment(\.managedObjectContext, ...)`
- All Core Data writes must happen on the main context (use `@MainActor` or `viewContext`)
- Favorites are stored in Core Data — avoid duplicating favorite state in `UserDefaults`

### Shared Data (`Compartido/`)
- `radios23.json` is shared across the iOS, Watch, and Share Extension targets
- Any changes to the JSON schema (`radioStationInfo`) must be reflected in all targets that parse it
- `NewRadioObj.swift` in `Data model/JSON files/` defines the Codable model

### watchOS Extension
- The Watch extension has its own copy of `radios23.json` and `NewRadioObj.swift`
- Keep Watch UI simple — only display station list and basic playback controls
- Watch and iOS share no live state — each target manages its own `AVPlayer`

### SwiftUI Patterns
```swift
// Inject DataController via environment
.environment(\.managedObjectContext, dataController.container.viewContext)

// Use @StateObject for owned view models
@StateObject private var homeModell = HomeModell()

// Prefer .task over .onAppear for async operations
.task { await homeModell.fetchStations() }

// Handle playback errors at View level
.alert("Playback Error", isPresented: $viewModel.showError) { ... }
```

---

## File Reference Map

```
playerSwiftUI/
├── playerSwiftUI/                      ← Main iOS target
│   ├── Compartido/
│   │   └── radios23.json               ← Station data (shared across targets)
│   ├── Data model/
│   │   ├── Core Data/
│   │   │   └── DataController.swift    ← NSPersistentContainer setup
│   │   ├── Helpers/
│   │   │   ├── Colors.swift            ← App color constants
│   │   │   ├── Data_formater.swift     ← Date/time formatting helpers
│   │   │   ├── Helper.swift            ← Utility functions
│   │   │   └── network_checker.swift   ← NWPathMonitor network observer
│   │   ├── JSON files/
│   │   │   └── NewRadioObj.swift       ← radioStationInfo Codable model
│   │   ├── Song playing now/
│   │   │   └── NewSongModel.swift      ← Now-playing metadata model
│   │   ├── ViewModels/
│   │   │   ├── HomeModell.swift        ← Station list state (LoadRadioStationJSONFile)
│   │   │   └── Detail Data Model.swift ← PlayRadio, theURLSetting, favoriteSaved
│   │   ├── Request.swift               ← ParseController (XMLParser for SVT schedule API)
│   │   ├── XMLSwiftUIView.swift        ← XML schedule display view
│   │   └── mySettings.swift           ← UserSettings (UserDefaults wrapper)
│   ├── Detail View/
│   │   ├── DetalleUIView.swift         ← Main player/detail screen
│   │   ├── Barr2SwiftUIView.swift      ← Secondary bar UI
│   │   ├── LottieView.swift            ← Lottie animation wrapper
│   │   ├── favoriteButtonView.swift    ← Favorite toggle button
│   │   └── newXMLSwiftUIView.swift     ← Updated XML schedule view
│   ├── Home Radio View/
│   │   ├── HomeRadioView.swift         ← Root view, station list
│   │   ├── NewListView.swift           ← List of radio stations
│   │   ├── NewTabView.swift            ← Tab navigation
│   │   ├── SplashSwiftUIView.swift     ← Splash/launch screen
│   │   ├── CheckFunctions.swift        ← Network/state check logic
│   │   └── CheckNetworkView.swift      ← No-network UI
│   ├── Toolbar/
│   │   ├── ArrowToolBarView.swift      ← Toolbar navigation arrows
│   │   ├── Favorites/
│   │   │   └── FavoriteDispView.swift  ← Favorites list display
│   │   ├── Searchbar/
│   │   │   └── SerachView.swift        ← Station search
│   │   └── Settings/
│   │       └── newSettingsView.swift   ← User settings screen
│   ├── unused/                         ← Deprecated files (do not edit)
│   └── playerSwiftUIApp.swift         ← @main entry point
├── radioSharer/                        ← Share Extension target
│   └── ShareViewController.swift
├── watch_player/                       ← WatchOS app
└── watch_player WatchKit Extension/    ← WatchKit extension
```

---

## Naming Conventions

- Types: `UpperCamelCase` (`HomeRadioView`, `PlayRadio`, `radioStationInfo`)
- Properties/functions: `lowerCamelCase` (`currentStation`, `playSongRadio()`)
- Files: match the primary type they contain (`DetalleUIView.swift`, `HomeModell.swift`)
- `unused/` folder: archived/deprecated files — do not modify, do not delete without review

---

## Known Issues / Tech Debt

| File | Issue | Status |
|------|-------|--------|
| `Request.swift` | Uses `DispatchSemaphore` — blocks thread | Pending async/await migration |
| `Detail Data Model.swift` | `PlayRadio` missing `@MainActor` | Pending Swift 6 migration |
| `HomeModell.swift` | `LoadRadioStationJSONFile` is not `ObservableObject` | Refactor needed |
| `mySettings.swift` | Favorites in `UserDefaults` may conflict with Core Data favorites | Consolidate to one source |
| `SerachView.swift` | Filename typo (missing 'a') | Low priority rename |

---

## Next Steps

### Immediate
1. Migrate `Request.swift` — replace `DispatchSemaphore` with async/await
2. Add `@MainActor` to `PlayRadio` and `theURLSetting`
3. Consolidate favorites: pick Core Data OR `UserDefaults`, remove the other
4. Add error UI for network failures in `CheckNetworkView`

### Medium-term
1. Enable Swift 6 strict concurrency: `SWIFT_STRICT_CONCURRENCY = targeted`
2. Extract reusable station row component from `NewListView`
3. Unify radio station model — ensure `radioStationInfo` and `NewRadioObj` are not duplicating
4. Add unit tests for `ParseController` and `LoadRadioStationJSONFile`

### Long-term
1. Implement offline caching for station list
2. Improve watchOS companion: live now-playing sync via WatchConnectivity
3. Accessibility improvements (VoiceOver labels for player controls)
4. Migrate from `ObservableObject` to `@Observable` (iOS 17+)
