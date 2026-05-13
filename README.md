# playerSwiftUI

Swedish Radio (SVT/SR) streaming app for iOS, built entirely with SwiftUI.

![Swift](https://img.shields.io/badge/Swift-5.x-orange?style=flat&logo=swift)
![iOS](https://img.shields.io/badge/iOS-16+-blue?style=flat&logo=apple)
![watchOS](https://img.shields.io/badge/watchOS-companion-lightgrey?style=flat&logo=apple)
![SwiftUI](https://img.shields.io/badge/SwiftUI-✓-green?style=flat)
![License](https://img.shields.io/badge/license-MIT-lightgrey?style=flat)

---

## Features

- Stream Swedish radio stations (SVT/SR) in real time
- Background audio playback with lock screen controls
- WatchOS companion app for playback control on the wrist
- Favorites saved with Core Data
- Live schedule data via SVT XML API
- Station search and tab navigation
- Share Extension — share stations with other apps
- Lottie animation on the player screen
- Network availability check with dedicated UI

---

## Architecture

The app follows an MVVM pattern with SwiftUI as the UI layer and Combine for reactive data flow.

```
radios23.json ──► LoadRadioStationJSONFile ──► HomeModell (ViewModel) ──► HomeRadioView
SVT XML API   ──► ParseController (XML)    ──► XMLSwiftUIView
```

### Targets

| Target | Platform | Description |
|--------|----------|-------------|
| `playerSwiftUI` | iOS 16+ | Main radio player app |
| `watch_player` | watchOS | WatchOS companion app |
| `watch_player WatchKit Extension` | watchOS | WatchKit extension logic |
| `radioSharer` | iOS | Share Extension |

---

## Tech Stack

| Category | Technology |
|----------|------------|
| UI | SwiftUI |
| Reactive | Combine |
| Audio | AVFoundation |
| Persistence | Core Data |
| Animation | Lottie |
| Networking | URLSession · XMLParser |
| Concurrency | GCD (Swift 6 migration pending) |
| Watch | WatchConnectivity |

---

## Project Structure

```
playerSwiftUI/
├── Compartido/
│   └── radios23.json           # Station data shared across all targets
├── Data model/
│   ├── Core Data/              # DataController — favorites persistence
│   ├── ViewModels/             # HomeModell, Detail Data Model
│   ├── Helpers/                # Colors, network checker, formatters
│   └── JSON files/             # radioStationInfo Codable model
├── Home Radio View/            # Station list, tabs, splash, network check
├── Detail View/                # Player screen, Lottie animation, favorites
├── Toolbar/                    # Search, favorites display, settings
├── radioSharer/                # Share Extension target
└── watch_player/               # watchOS app
```

---

## Getting Started

```bash
git clone https://github.com/AlvarArias/playerSwiftUI.git
cd playerSwiftUI
open playerSwiftUI.xcodeproj
```

> Requires Xcode 15+ and iOS 16 simulator or device.

---

## Roadmap

- [ ] Swift 6 strict concurrency migration
- [ ] Replace `DispatchSemaphore` in `Request.swift` with async/await
- [ ] Live now-playing sync between iOS and Watch via WatchConnectivity
- [ ] Offline caching for station list
- [ ] Unit tests for `ParseController` and `LoadRadioStationJSONFile`
- [ ] Migrate `ObservableObject` to `@Observable` (iOS 17+)

---

## Author

**Alvar Arias**
- [LinkedIn](https://www.linkedin.com/in/alvararias/)
- [Portfolio](https://alvararias.github.io/)
- [GitHub](https://github.com/AlvarArias)
