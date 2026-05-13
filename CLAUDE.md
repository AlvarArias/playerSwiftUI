# playerSwiftUI — CLAUDE.md

## Proyecto hermano — New_SR_Player

Ruta: `/Users/alvararias/Documents/Swift Apps/Apps Projects/SVT API Radio project/New_SR_Player`

Proyecto más avanzado (Swift 6, iOS 26+) del que se pueden portar componentes listos. Antes de construir algo nuevo, revisar si ya existe ahí.

| Componente listo                                             | Archivo en New_SR_Player          |
| ------------------------------------------------------------ | --------------------------------- |
| `PulsingRing` ViewModifier (buffering rings)                 | `Helpers/LottieStruc.swift`       |
| `PlayPulseButtonStyle` (scale on press)                      | `Helpers/LottieStruc.swift`       |
| `EqualizerView` (3 barras animadas)                          | `Helpers/LottieStruc.swift`       |
| `GIFView` (GIF sin dependencias)                             | `Helpers/LottieStruc.swift`       |
| `BannerStore` (error banners auto-dismiss)                   | `Helpers/BannerStore.swift`       |
| `AudioPlayer` (AVPlayer + KVO + NowPlaying + RemoteCommand)  | `Model/Player/AudioPlayer.swift`  |
| `FavoritesStore` (UserDefaults + JSONEncoder)                | `Model/FavoritesStore.swift`      |
| `SRAPIClient` (SR API v2 async/await)                        | `Model/Player/SRAPIClient.swift`  |

---

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
radios23.json → StationStore.load() → HomeRadioView / NewListView → DetalleUIView
SR API v2     → StationStore.loadNowPlayingImages() → nowPlayingImages[stationId] → station cards + detail image
SVT XML API   → ScheduleParser.fetchSchedule() → ScheduleView (schedule data)
AVPlayer KVO  → PlayerViewModel (isPlaying / isBuffering) → DetalleUIView animations
```

### Key Classes/Structs
- `StationStore` — `@MainActor @Observable` — loads `radios23.json`, fetches `nowPlayingImages` from SR API in parallel at launch
- `PlayerViewModel` — `@MainActor @Observable` — wraps `AVPlayer`, KVO on `timeControlStatus` drives `isPlaying` and `isBuffering`
- `UserSettings` — `@Observable` — UserDefaults wrapper for user preferences and favorites
- `ParseController: XMLParserDelegate, ObservableObject` — fetches and parses SVT schedule XML feed
- `DataController` — Core Data stack (`NSPersistentContainer`)
- `ScheduleParser` — `@Observable` — async schedule fetching for `DetalleUIView`

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
// Inject @Observable objects via environment (iOS 17+)
.environment(stationStore)
.environment(playerViewModel)

// Read @Observable from environment in views
@Environment(StationStore.self) private var stationStore
@Environment(PlayerViewModel.self) private var player

// Prefer .task over .onAppear for async operations
.task { await scheduleParser.fetchSchedule(from: station.scheduleurl) }

// Handle playback errors at View level
.alert("Uppspelningsfel", isPresented: $playerBinding.showError) { ... }

// Buffering state via KVO — never set isPlaying manually
// player.timeControlStatus drives isPlaying and isBuffering automatically
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
│   │   │   ├── HomeModell.swift        ← StationStore (@Observable) — station list + nowPlayingImages from SR API
│   │   │   └── Detail Data Model.swift ← PlayerViewModel (@Observable) — AVPlayer + KVO (isPlaying, isBuffering)
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
| `mySettings.swift` | Favorites in `UserDefaults` may conflict with Core Data favorites | Consolidate to one source |
| `SerachView.swift` | Filename typo (missing 'a') | Low priority rename |

### Completed (this cycle)

| File | Change |
| ---- | ------ |
| `Detail Data Model.swift` | Replaced `PlayRadio` with `PlayerViewModel` — `@MainActor @Observable`, KVO on `timeControlStatus` |
| `HomeModell.swift` | Replaced `LoadRadioStationJSONFile` with `StationStore` — `@MainActor @Observable`, parallel SR API image fetch |
| `DetalleUIView.swift` | Buffering rings animation, program image from `nowPlayingImages`, equalizer tied to KVO state |
| `NewListView.swift` | Program image from `nowPlayingImages` per station card |
| `LottieView.swift` | `isPlaying` parameter — `play()`/`pause()` driven from `updateUIView`, not `makeUIView` |

---

## Next Steps

### Immediate
1. Migrate `Request.swift` — replace `DispatchSemaphore` with async/await
2. Consolidate favorites: pick Core Data OR `UserDefaults`, remove the other
3. Add error UI for network failures in `CheckNetworkView`

### Medium-term
1. Enable Swift 6 strict concurrency: `SWIFT_STRICT_CONCURRENCY = targeted`
2. Extract reusable station row component from `NewListView`
3. Unify radio station model — ensure `radioStationInfo` and `NewRadioObj` are not duplicating
4. Add unit tests for `ScheduleParser` and `StationStore`

### Long-term

1. Implement offline caching for station list and program images
2. Improve watchOS companion: live now-playing sync via WatchConnectivity
3. Accessibility improvements (VoiceOver labels for player controls)
